import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter_util_code/utils.dart';
import 'package:pointycastle/asymmetric/api.dart';
import 'package:fast_rsa/fast_rsa.dart' as fast_rsa;

///  Name: 加密工具类
///  Created by Fitem on 2023/6/9
class EncryptUtils {
  /// MD5加密
  /// [content] 加密内容
  static String md5Encrypt(String content) {
    Uint8List uint8list = const Utf8Encoder().convert(content);
    Digest digest = md5.convert(uint8list);
    return digest.toString();
  }

  /// RC4加密
  /// [content] 加密内容
  static String rc4Encrypt(String content, String keyStr) {
    var rc4 = RC4(keyStr);
    return rc4.encode(content);
  }

  /// AES加密, 默认[AESMode.ecb]加密方式
  /// [content] 明文
  /// [key] 秘钥
  static aesEncrypt(String content, String keyStr) {
    final key = Key.fromUtf8(keyStr);
    final iv = IV.fromLength(16);
    final encryptor = Encrypter(AES(key, mode: AESMode.ecb));
    final encrypted = encryptor.encrypt(content, iv: iv);
    return encrypted.base64;
  }

  /// AES解密, 默认[AESMode.ecb]加密方式
  /// [content] 密文
  /// [key] 秘钥
  static aesDecrypt(String content, String keyStr) {
    final key = Key.fromUtf8(keyStr);
    final iv = IV.fromLength(16);
    final encryptor = Encrypter(AES(key, mode: AESMode.ecb));
    final encrypted = Encrypted.fromBase64(content);
    final decrypted = encryptor.decrypt(encrypted, iv: iv);
    return decrypted;
  }

  /// RSA加密算法加密，秘钥格式为[pkcs8]
  /// [content]明文
  /// [publicKeyStr]公钥
  static String rsaEncrypt(String content, String publicKeyStr) {
    final parser = RSAKeyParser();
    String publicKeyString = _transformPem(publicKeyStr);
    RSAPublicKey publicKey = parser.parse(publicKeyString) as RSAPublicKey;
    final encryptor = Encrypter(RSA(publicKey: publicKey));
    final encrypted = encryptor.encrypt(content);
    return encrypted.base64;
  }

  /// RSA加密算法解密，秘钥格式为[pkcs8]
  /// [encryptedStr]密文，base64编码
  /// [privateKeyStr]私钥
  static String rsaDecrypt(String encryptedStr, String privateKeyStr) {
    final parser = RSAKeyParser();
    String publicKeyString = _transformPem(privateKeyStr);
    RSAPrivateKey privateKey = parser.parse(publicKeyString) as RSAPrivateKey;
    final encryptor = Encrypter(RSA(privateKey: privateKey));
    final encrypted = Encrypted.fromBase64(encryptedStr);
    final decrypted = encryptor.decrypt(encrypted);
    return decrypted;
  }

  /// sha256withRSA签名，秘钥格式为[pkcs8]
  /// [content]明文
  /// [privateKeyStr]私钥
  static Future<String> sha256withRSASign(String content, String privateKeyStr) async {
    RSAKeyParser parser = RSAKeyParser();
    Signer signer;
    // 初始化私钥
    String privateKeyString = _transformPem(privateKeyStr, isPublic: false);
    RSAPrivateKey privateKey = parser.parse(privateKeyString) as RSAPrivateKey;
    signer = Signer(RSASigner(RSASignDigest.SHA256, privateKey: privateKey));
    // 将参数值拼接成字符串
    var md5Str = md5Encrypt(content);
    var sign = signer.sign(md5Str).base64;
    return sign;
  }

  /// sha256withRSA验签，秘钥格式为[pkcs8]
  /// [content]明文
  /// [encryptedContent]密文
  /// [publicKeyStr]公钥
  static bool sha256withRSAVerify(String content, String encryptedContent, String publicKeyStr) {
    RSAKeyParser parser = RSAKeyParser();
    Signer signer;
    // 初始化公钥
    String publicKeyString = _transformPem(publicKeyStr);
    RSAPublicKey publicKey = parser.parse(publicKeyString) as RSAPublicKey;
    signer = Signer(RSASigner(RSASignDigest.SHA256, publicKey: publicKey));
    // 验签
    var verify = signer.verify(content, Encrypted.from64(encryptedContent));
    return verify;
  }

  /// md5withRSA签名
  /// [content]明文
  /// [privateKeyStr]私钥
  static Future<String> md5withRSASign(String content, String privateKeyStr) async {
    String privateKey = await fast_rsa.RSA.convertPrivateKeyToPKCS1(privateKeyStr);
    var md5Content = md5Encrypt(content);
    var sign = await fast_rsa.RSA.signPKCS1v15(md5Content, fast_rsa.Hash.MD5, privateKey);
    return sign;
  }

  /// md5withRSA解签
  /// [encryptedStr]密文
  /// [publicKeyStr]公钥
  static Future<String> md5withRSADecrypt(String encryptedStr, String publicKeyStr) async {
    String publicKey = await fast_rsa.RSA.convertPublicKeyToPKCS1(publicKeyStr);
    var decrypt = await fast_rsa.RSA.decryptPKCS1v15(encryptedStr, publicKey);
    return decrypt;
  }

  /// md5withRSA验签
  /// [content]明文
  /// [encryptedContent]密文
  /// [publicKeyStr]公钥
  static Future<bool> md5withRSAVerify(String content, String encryptedContent, String publicKeyStr) async {
    String publicKey = await fast_rsa.RSA.convertPublicKeyToPKCS1(publicKeyStr);
    var md5Content = md5Encrypt(content);
    var verify = await fast_rsa.RSA.verifyPKCS1v15(md5Content, encryptedContent, fast_rsa.Hash.MD5, publicKey);
    return verify;
  }

  /// 把秘钥从字符串转成PEM文件格式
  /// [str]秘钥，字符串
  /// [isPublic]是否是公钥
  static String _transformPem(String str, {bool isPublic = true}) {
    var begin = isPublic ? '-----BEGIN PUBLIC KEY-----\n' : "-----BEGIN PRIVATE KEY-----\n";
    var end = isPublic ? '\n-----END PUBLIC KEY-----' : '\n-----END PRIVATE KEY-----';
    // 如果已经是PEM格式的秘钥，直接返回
    if(str.contains(begin) && str.contains(end)) return str;

    int splitCount = str.length ~/ 64;
    List<String> strList = [];

    for (int i = 0; i < splitCount; i++) {
      strList.add(str.substring(64 * i, 64 * (i + 1)));
    }
    if (str.length % 64 != 0) {
      strList.add(str.substring(64 * splitCount));
    }

    return begin + strList.join('\n') + end;
  }
}

class RC4 {
  int i = 0, j = 0;

  List<int> ksa = [];

  RC4(String key, [int dropBytes = 0]) {
    if (dropBytes % 256 != 0) {
      throw Exception("Drop Bytes must be multiple of 256, was <$dropBytes>.");
    }
    ksa = _makeKey(key, dropBytes);
  }

  List<int> _encryptByte(int i, int j, List<int> S) {
    i = (i + 1) % 256;
    j = (j + S[i]) % 256;
    _swap(S, i, j);
    int K = S[(S[i] + S[j]) % 256];
    if (K >= 256) {
      LogUtils.println("oh noes!");
    }
    return [i, j, K];
  }

  _swap(List<int> S, int i, int j) {
    var tmp = S[i];
    S[i] = S[j];
    S[j] = tmp;
  }

  List<int> range(int i) {
    return List.generate(i, (e) => e);
  }

  List<int> _makeKey(String key, int dropBytes) {
    //The key-scheduling algorithm (KSA)
    List<int> S = range(256);
    j = 0;
    for (int i in range(256)) {
      var asciiCode = key.codeUnitAt(i % key.length);
      j = (j + S[i] + asciiCode) % 256;
      _swap(S, i, j);
    }
    i = j = 0;

    //Do the RC4-drop[(nbytes)]
    if (dropBytes > 0) {
      for (int dropped in range(dropBytes)) {
        var results = _encryptByte(i, j, S);
        i = results[0];
        j = results[1];
      }
    }
    return S;
  }

  String _crypt(String message) {
    //The pseudo-random generation algorithm (PRGA)
    List<int> S = [...ksa]; //make a deep copy of you KSA array, gets modified
    List<int> combined = [];
    int i = this.i;
    int j = this.j;
    int messageLength = message.length;
    for (int c = 0; c < messageLength; c++) {
      var results = _encryptByte(i, j, S);
      i = results[0];
      j = results[1];
      int K = results[2];

      int asciiCode, index;
      try {
        asciiCode = message.codeUnitAt(c);
        index = K ^ asciiCode;
        combined.add(index);
      } on RangeError {
        LogUtils.println(message);
        throw Exception("Crap");
      }
    }
    String decrypted = String.fromCharCodes(combined);
    return decrypted;
  }

  String encode(String message, [bool encodeBase64 = true]) {
    String encrypted = _crypt(message);
    if (encodeBase64) {
      List<int> asciiCodes = encrypted.codeUnits;
      String base64 = base64Encode(asciiCodes);
      encrypted = base64;
    }
    return encrypted;
  }

  String decode(String message, [bool encodedBase64 = true]) {
    if (encodedBase64) {
      List<int> bytes = base64Decode(message);
      message = String.fromCharCodes(bytes);
    }

    String decrypted = _crypt(message);
    return decrypted;
  }
}

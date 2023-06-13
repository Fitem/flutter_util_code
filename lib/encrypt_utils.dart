import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:encrypt/encrypt.dart';
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
  /// [content] 明文
  static String rc4Encrypt(String content, String keyStr) {
    RC4 rc4 = RC4(keyStr);
    Uint8List data = Uint8List.fromList(content.codeUnits);
    Uint8List crypt = rc4.crypt(data);
    return base64Encode(crypt);
  }

  /// RC4解密
  /// [content] 密文
  static String rc4Decrypt(String content, String keyStr) {
    RC4 rc4 = RC4(keyStr);
    Uint8List data = base64Decode(content);
    Uint8List crypt = rc4.crypt(data);
    return utf8.decode(crypt);
  }

  /// AES加密, 默认[AESMode.ecb]加密方式
  /// [content] 明文
  /// [aesKey] 秘钥
  static aesEncrypt(String content, String keyStr) {
    final key = Key.fromUtf8(keyStr);
    final iv = IV.fromLength(16);
    final encryptor = Encrypter(AES(key, mode: AESMode.ecb));
    final encrypted = encryptor.encrypt(content, iv: iv);
    return encrypted.base64;
  }

  /// AES解密, 默认[AESMode.ecb]加密方式
  /// [content] 密文
  /// [aesKey] 秘钥
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
    String publicKeyString = _transformPem(privateKeyStr, isPublic: false);
    RSAPrivateKey privateKey = parser.parse(publicKeyString) as RSAPrivateKey;
    final encryptor = Encrypter(RSA(privateKey: privateKey));
    final encrypted = Encrypted.fromBase64(encryptedStr);
    final decrypted = encryptor.decrypt(encrypted);
    return decrypted;
  }

  /// sha256withRSA签名，秘钥格式为[pkcs8]
  /// [content]明文
  /// [privateKeyStr]私钥
  static String sha256withRSASign(String content, String privateKeyStr) {
    RSAKeyParser parser = RSAKeyParser();
    Signer signer;
    // 初始化私钥
    String privateKeyString = _transformPem(privateKeyStr, isPublic: false);
    RSAPrivateKey privateKey = parser.parse(privateKeyString) as RSAPrivateKey;
    signer = Signer(RSASigner(RSASignDigest.SHA256, privateKey: privateKey));
    var sign = signer.sign(content).base64;
    return sign;
  }

  /// sha256withRSA验签，秘钥格式为[pkcs8]
  /// [content]明文
  /// [signature]签名
  /// [publicKeyStr]公钥
  static bool sha256withRSAVerify(String content, String signature, String publicKeyStr) {
    RSAKeyParser parser = RSAKeyParser();
    Signer signer;
    // 初始化公钥
    String publicKeyString = _transformPem(publicKeyStr);
    RSAPublicKey publicKey = parser.parse(publicKeyString) as RSAPublicKey;
    signer = Signer(RSASigner(RSASignDigest.SHA256, publicKey: publicKey));
    // 验签
    var verify = signer.verify(content, Encrypted.from64(signature));
    return verify;
  }

  /// md5withRSA签名，秘钥格式为[pkcs8]
  /// [content]明文
  /// [privateKeyStr]私钥
  static Future<String> md5withRSASign(String content, String privateKeyStr) async {
    // 初始化私钥
    String privateKeyString = _transformPem(privateKeyStr, isPublic: false);
    String privateKey = await fast_rsa.RSA.convertPrivateKeyToPKCS1(privateKeyString);
    var sign = await fast_rsa.RSA.signPKCS1v15(content, fast_rsa.Hash.MD5, privateKey);
    return sign;
  }

  /// md5withRSA验签，秘钥格式为[pkcs8]
  /// [content]明文
  /// [signature]签名
  /// [publicKeyStr]公钥
  static Future<bool> md5withRSAVerify(String content, String signature, String publicKeyStr) async {
    // 初始化公钥
    String publicKeyString = _transformPem(publicKeyStr);
    String publicKey = await fast_rsa.RSA.convertPublicKeyToPKCS1(publicKeyString);
    var verify = await fast_rsa.RSA.verifyPKCS1v15(signature, content, fast_rsa.Hash.MD5, publicKey);
    return verify;
  }

  /// 把秘钥从字符串转成PEM文件格式
  /// [str]秘钥，字符串
  /// [isPublic]是否是公钥
  static String _transformPem(String str, {bool isPublic = true}) {
    var begin = isPublic ? '-----BEGIN PUBLIC KEY-----\n' : "-----BEGIN PRIVATE KEY-----\n";
    var end = isPublic ? '\n-----END PUBLIC KEY-----' : '\n-----END PRIVATE KEY-----';
    // 如果已经是PEM格式的秘钥，直接返回
    if (str.contains(begin) && str.contains(end)) return str;
    // 去掉空格和换行
    str.replaceAll(' ', '').replaceAll('\n', '');

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
  /// 初始化
  /// [keyStr] key
  RC4(String keyStr) {
    Uint8List key = Uint8List.fromList(keyStr.codeUnits);
    setKey(key);
  }

  final Uint8List _s = Uint8List(256);
  int _i = 0;
  int _j = 0;

  void setKey(Uint8List key) {
    for (int i = 0; i < 256; i++) {
      _s[i] = i;
    }

    int j = 0;
    for (int i = 0; i < 256; i++) {
      j = (j + _s[i] + key[i % key.length]) % 256;
      swap(i, j);
    }

    _i = 0;
    _j = 0;
  }

  /// 加密
  /// [data]数据
  Uint8List crypt(Uint8List data) {
    Uint8List result = Uint8List(data.length);

    for (int k = 0; k < data.length; k++) {
      result[k] = data[k] ^ next();
    }

    return result;
  }

  void swap(int i, int j) {
    int temp = _s[i];
    _s[i] = _s[j];
    _s[j] = temp;
  }

  int next() {
    _i = (_i + 1) % 256;
    _j = (_j + _s[_i]) % 256;
    swap(_i, _j);
    return _s[(_s[_i] + _s[_j]) % 256];
  }
}

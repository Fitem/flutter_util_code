import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_util_code/utils.dart';

///  Name: 加密工具类测试
///  Created by Fitem on 2023/6/28
void main() {
  String publicKey = '''
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMKXEQ1npgt0l5nJODHdnUMW16
/HWloj3cPLvCbbEcsTTe/gGyZTvMvt2xDewRUnVqaZefn2vGlqhurkRQ7xpmo58l
wb9c70d/RIZ3I+TULJH3mqZbv8nHq/BLlTL9DVqwp3G0ysdzLWHNAzAMwf7BjaNE
Ro/zc4A598XePziqQwIDAQAB
''';
  String privateKey = '''
MIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAMwpcRDWemC3SXmc
k4Md2dQxbXr8daWiPdw8u8JtsRyxNN7+AbJlO8y+3bEN7BFSdWppl5+fa8aWqG6u
RFDvGmajnyXBv1zvR39Ehncj5NQskfeaplu/ycer8EuVMv0NWrCncbTKx3MtYc0D
MAzB/sGNo0RGj/NzgDn3xd4/OKpDAgMBAAECgYEAvWoZd1i1s3N5XLXS+gvA5Chz
fW4qrGBI6kMCpBFnB8q01cptwpg/kebnAXR8N1n8i5ypyrN6p4VxgTZ3NWuQXk16
G4UcZcqRciButOs0E+W4Ot5+PMLuutcsFW/uYtaTRIMWHLV0GuHJjUCbLKKJolFc
thMggXOwy6EucL2NALkCQQD7koP0UiHTFyMHmdHKuAESQFU4fNzypzBlvOBBNX7T
1caLiCoRjUCDEGf8ABE4CTMeDT1SVBgLkfg0o3SFxI2vAkEAz8FQTFWerhnIGkdE
bm/togRUk/LbYIg3YWMfsaDhMU3ue2h4ojXWvNduEjiLm9oX1MsmsBmZdpCRSW4/
5AeFrQJBAKQ3c+Ncaa/9fmRLyGJn0mszi22gNCpBcJo4vLpUTUHCXiRe8fcbGW10
nCwnbxYBC1kmk0zWkAudcUQLHtjjAQkCQHMu+4UG504hbybaol8UYUy1V+sa93QC
saml2lmSF6hNS85R8qgEb4UNb7JcdVK4TQQmidGSr9njdxmeLYAQh5UCQDlMuw0H
25UPw+9QMujcT3UTvABy0lOXRInZgEUU6YAjy0rNVUxLeNoyXlObRTlpoyVz58Er
fp2bts3jaD4PsSU=
  ''';
  String content = 'hello world!';
  String rc4Key = 'abc123';
  String aesKey = 'xsH/6p7B2xhebSoZ';
  group('EncryptedUtils', () {
    // MD5加密
    test('MD5', () {
      String md5 = EncryptUtils.md5Encrypt(content);
      expect(md5, 'fc3ff98e8c6a0d3087d515c0473f8677');
    });
    // RC4加密/解密
    test('RC4', () {
      String encrypt = EncryptUtils.rc4Encrypt(content, rc4Key);
      String decrypt = EncryptUtils.rc4Decrypt(encrypt, rc4Key);
      expect(encrypt, 'YrlMGzqCagCj9+ff');
      expect(decrypt, content);
    });
    // AES加密/解密
    test('AES', () {
      String encrypt = EncryptUtils.aesEncrypt(content, aesKey);
      String decrypt = EncryptUtils.aesDecrypt(encrypt, aesKey);
      expect(encrypt, 'XkxSOtpoErJzTyW5/6sGNA==');
      expect(decrypt, content);
    });
    // RSA加密/解密
    test('RSA', () async {
      String encrypt = EncryptUtils.rsaEncrypt(content, publicKey);
      String decrypt = EncryptUtils.rsaDecrypt(encrypt, privateKey);
      debugPrint('encrypt: $encrypt');
      expect(decrypt, content);
    });
    // SHA256withRSA 签名/验签
    test('SHA256withRSA', () {
      String sign = EncryptUtils.sha256withRSASign(content, privateKey);
      bool verify = EncryptUtils.sha256withRSAVerify(content, sign, publicKey);
      debugPrint('sign: $sign');
      expect(verify, true);
    });
    // MD5withRSA 签名/验签
    // 若出现库无法找到问题，需要将example项目下的build文件拷贝到根目录下
    test('MD5withRSA', () async {
      String sign = await EncryptUtils.md5withRSASign(content, privateKey);
      bool verify = await EncryptUtils.md5withRSAVerify(content, sign, publicKey);
      debugPrint('sign: $sign');
      expect(verify, true);
    });
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_util_code/utils.dart';
import 'package:flutter_util_code_example/widget/display_screen.dart';

///  Name: 加密页面
///  Created by Fitem on 2023/6/12
class EncryptPage extends StatefulWidget {
  const EncryptPage({super.key});

  @override
  EncryptPageState createState() => EncryptPageState();
}

class EncryptPageState extends State<EncryptPage> {
  final GlobalKey<DisplayScreenState> globalKey = GlobalKey();
  final String content = 'hello world!';
  final String rc4Key = 'abc123';
  final String aesKey = 'xsH/6p7B2xhebSoZ';
  final String publicKey = '''
MIGfMA0GCSqGSIb3DQEBAQUAA4GNADCBiQKBgQDMKXEQ1npgt0l5nJODHdnUMW16
/HWloj3cPLvCbbEcsTTe/gGyZTvMvt2xDewRUnVqaZefn2vGlqhurkRQ7xpmo58l
wb9c70d/RIZ3I+TULJH3mqZbv8nHq/BLlTL9DVqwp3G0ysdzLWHNAzAMwf7BjaNE
Ro/zc4A598XePziqQwIDAQAB
''';
  final String privateKey = '''
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('加密页面'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ElevatedButton(onPressed: _handleMD5, child: const Text('MD5加密')),
            ElevatedButton(onPressed: _handleRC4, child: const Text('RC4加密')),
            ElevatedButton(onPressed: _handleAES, child: const Text('AES加密/解密')),
            ElevatedButton(onPressed: _handleRSA, child: const Text('RSA加密/解密')),
            ElevatedButton(onPressed: _handleSha256withRSA, child: const Text('sha256withRSA签名/验签')),
            ElevatedButton(onPressed: _handleMd5withRSA, child: const Text('md5withRSA签名/验签')),
            const Spacer(),
            Expanded(flex: 2, child: DisplayScreen(key: globalKey)),
          ],
        ),
      ),
    );
  }

  /// 添加内容
  void addContent(String content) {
    globalKey.currentState?.addContent(content);
  }

  _handleMD5() {
    addContent('''MD5加密:
    原文：$content
    加密：${EncryptUtils.md5Encrypt(content)}
    ''');
  }

  _handleRC4() {
    addContent('''RC4加密:
    原文：$content
    加密：${EncryptUtils.rc4Encrypt(content, rc4Key)}
    ''');
  }

  _handleAES() {
    String encryptedContent = EncryptUtils.aesEncrypt(content, aesKey);
    addContent('''AES加密:
    原文：$content
    加密：$encryptedContent
    解密：${EncryptUtils.aesDecrypt(encryptedContent, aesKey)}
    ''');
  }

  _handleRSA() {
    String encryptedContent = EncryptUtils.rsaEncrypt(content, publicKey);
    addContent('''RSA加密:
    原文：$content
    加密：$encryptedContent
    解密：${EncryptUtils.rsaDecrypt(encryptedContent, privateKey)}
    ''');
  }

  void _handleSha256withRSA() {
    String encryptedContent = EncryptUtils.sha256withRSASign(content, privateKey);
    addContent('''sha256withRSA加密:
    原文：$content
    加密：$encryptedContent
    验签：${EncryptUtils.sha256withRSAVerify(content, encryptedContent, publicKey)}
    ''');
  }

  Future<void> _handleMd5withRSA() async {
    String encryptedContent = await EncryptUtils.md5withRSASign(content, privateKey);
    bool isValid = await EncryptUtils.md5withRSAVerify(content, encryptedContent, publicKey);
    addContent('''md5withRSA签名:
    原文：$content
    加密：$encryptedContent
    验签：$isValid
    ''');
  }
}

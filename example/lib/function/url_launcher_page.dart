import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_util_code/utils.dart';

///  Name: Url跳转工具类
///  Created by Fitem on 2023/6/20
class UrlLauncherPage extends StatefulWidget {
  const UrlLauncherPage({super.key});

  @override
  UrlLauncherPageState createState() => UrlLauncherPageState();
}

class UrlLauncherPageState<UrlLauncherPage> extends State {
  final String httpUrl = 'https://flutter.dev';
  final String phoneNumber = '10086';
  final String email = 'smith@example.org';
  String filePath = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Url跳转工具类'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            _buildButton('浏览器打开url', () => UrlLauncherUtils.launchInBrowser(httpUrl)),
            _buildButton('非浏览器第三方应用打开url', () => UrlLauncherUtils.launchInNonBrowser(httpUrl)),
            _buildButton('WebView打开url', () => UrlLauncherUtils.launchInApp(httpUrl)),
            _buildButton('关闭WebView', () {
              UrlLauncherUtils.launchInApp(httpUrl);
              Timer(const Duration(seconds: 3), () => UrlLauncherUtils.onCloseInAppWebView());
              return Future.value(true);
            }),
            _buildButton('打电话', () => UrlLauncherUtils.onCall(phoneNumber)),
            _buildButton('发短信', () => UrlLauncherUtils.sendSMS(phoneNumber, content: '短信内容')),
            _buildButton('发送邮件', () => UrlLauncherUtils.sendEmail(email, subject: '邮件主题', content: '邮件内容')),
            _buildButton('打开文件', openFile),
          ],
        ),
      ),
    );
  }

  /// 通用按钮
  Widget _buildButton(String text, Future<dynamic> Function() onPressed) {
    return ElevatedButton(
        onPressed: () async {
          bool result = await onPressed();
          ToastUtils.showCenter(result ? '跳转成功' : '跳转失败');
        },
        child: Text(text));
  }

  /// 打开文件
  Future<bool> openFile() async {
    final String tempFilePath = await PathUtils.getAppSupportPath();
    String filePath = '$tempFilePath/temp.pdf';
    if(!File(tempFilePath).existsSync()) {
      Directory(tempFilePath).createSync(recursive: true);
    }
    final File testFile = File(filePath);
    await testFile.writeAsString('Hello, world!');
    filePath = testFile.absolute.path;
    return UrlLauncherUtils.openFile(filePath);
  }
}

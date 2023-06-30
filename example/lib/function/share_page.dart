import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_util_code/share_utils.dart';
import 'package:flutter_util_code/utils.dart';

///  Name: 分享页面
///  Created by Fitem on 2023/6/28
class SharePage extends StatefulWidget {
  const SharePage({super.key});

  @override
  SharePageState createState() => SharePageState();
}

class SharePageState<SharePage> extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('分享工具类'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            _buildButton('分享文本', () => ShareUtils.shareText('分享内容', subject: '分享主题')),
            _buildButton(
              '分享图片-path',
              () async {
                final data = await rootBundle.load('assets/flutter_logo.png');
                final Uint8List bytes = data.buffer.asUint8List();
                final String tempFilePath = await PathUtils.getAppSupportPath();
                String filePath = '$tempFilePath/flutter_logo.png';
                if (!File(tempFilePath).existsSync()) {
                  Directory(tempFilePath).createSync(recursive: true);
                }
                final File imageFile = File(filePath);
                await imageFile.writeAsBytes(bytes);
                filePath = imageFile.absolute.path;
                return ShareUtils.shareImage(
                  name: 'flutter_logo.png',
                  path: filePath,
                  subject: '分享主题',
                  text: '分享内容',
                );
              },
            ),
            _buildButton(
              '分享图片-bytes',
              () async {
                final data = await rootBundle.load('assets/flutter_logo.png');
                return ShareUtils.shareImage(
                  name: 'flutter_logo.png',
                  bytes: data.buffer.asUint8List(),
                  mineType: 'image/png',
                  subject: '分享主题',
                  text: '分享内容',
                );
              },
            ),
            _buildButton(
              '分享多张图片',
              () async {
                final data1 = await rootBundle.load('assets/flutter_logo.png');
                final data2 = await rootBundle.load('assets/ic_launcher.png');
                ShareFile file1 =
                    ShareFile(name: 'flutter_logo.png', bytes: data1.buffer.asUint8List(), mineType: 'image/png');
                ShareFile file2 =
                    ShareFile(name: 'ic_launcher.png', bytes: data2.buffer.asUint8List(), mineType: 'image/png');
                return ShareUtils.shareImages(
                  images: [file1, file2],
                  subject: '分享主题',
                  text: '分享内容',
                );
              },
            ),
            _buildButton(
              '分享文件-path',
              () async {
                final String tempFilePath = await PathUtils.getAppSupportPath();
                String filePath = '$tempFilePath/temp.txt';
                if (!File(tempFilePath).existsSync()) {
                  Directory(tempFilePath).createSync(recursive: true);
                }
                final File testFile = File(filePath);
                await testFile.writeAsString('Hello, world!');
                filePath = testFile.absolute.path;
                return ShareUtils.shareFile(
                  name: 'temp.txt',
                  path: filePath,
                  subject: '分享主题',
                  text: '分享内容',
                );
              },
            ),
            _buildButton(
              '分享文件-bytes',
              () async {
                final String tempFilePath = await PathUtils.getAppSupportPath();
                String filePath = '$tempFilePath/temp.txt';
                if (!File(tempFilePath).existsSync()) {
                  Directory(tempFilePath).createSync(recursive: true);
                }
                final File testFile = File(filePath);
                await testFile.writeAsString('Hello, world!');
                filePath = testFile.absolute.path;
                return ShareUtils.shareFile(
                  name: 'temp.txt',
                  bytes: testFile.readAsBytesSync(),
                  mineType: 'text/plain',
                  subject: '分享主题',
                  text: '分享内容',
                );
              },
            ),
            _buildButton(
              '分享个文件',
              () async {
                final String tempFilePath = await PathUtils.getAppSupportPath();
                String filePath1 = '$tempFilePath/temp1.txt';
                String filePath2 = '$tempFilePath/temp2.txt';
                if (!File(tempFilePath).existsSync()) {
                  Directory(tempFilePath).createSync(recursive: true);
                }
                final File testFile1 = File(filePath1);
                final File testFile2 = File(filePath2);
                await testFile1.writeAsString('Hello, world!');
                await testFile2.writeAsString('Hello, world!');
                filePath1 = testFile1.absolute.path;
                filePath2 = testFile2.absolute.path;
                return ShareUtils.shareFiles(
                  files: [
                    ShareFile(name: 'temp1.txt', path: filePath1),
                    ShareFile(name: 'temp2.txt', path: filePath2),
                  ],
                  subject: '分享主题',
                  text: '分享内容',
                );
              },
            ),
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
          ToastUtils.showCenter(result ? '分享成功' : '分享失败');
        },
        child: Text(text));
  }
}

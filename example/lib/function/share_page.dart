import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                // 拷贝图片
                final data = await rootBundle.load('assets/flutter_logo.png');
                final Uint8List bytes = data.buffer.asUint8List();
                final String tempFilePath = await PathUtils.getAppCachePath();
                String filePath = '$tempFilePath/flutter_logo.png';
                final File imageFile = File(filePath);
                await imageFile.writeAsBytes(bytes);
                // 获取图片路径
                return ShareUtils.shareImage(name: 'flutter_logo.png', path: filePath);
              },
            ),
            _buildButton(
              '分享图片-bytes',
              () async {
                // 获取图片bytes
                final data = await rootBundle.load('assets/flutter_logo.png');
                final Uint8List bytes = data.buffer.asUint8List();
                return ShareUtils.shareImage(name: 'flutter_logo.png', bytes: bytes);
              },
            ),
            _buildButton(
              '分享多张图片',
              () async {
                // 获取多少张图片bytes
                final data1 = await rootBundle.load('assets/flutter_logo.png');
                final data2 = await rootBundle.load('assets/ic_launcher.png');
                final bytes1 = data1.buffer.asUint8List();
                final bytes2 = data2.buffer.asUint8List();
                ShareFile file1 = ShareFile(name: 'flutter_logo.png', bytes: bytes1);
                ShareFile file2 = ShareFile(name: 'ic_launcher.png', bytes: bytes2);
                return ShareUtils.shareImages([file1, file2]);
              },
            ),
            _buildButton(
              '分享文件-path',
              () async {
                // 拷贝文件
                final String tempFilePath = await PathUtils.getAppCachePath();
                String filePath = '$tempFilePath/temp.txt';
                final File testFile = File(filePath);
                await testFile.writeAsString('Hello, world!');
                return ShareUtils.shareFile(name: 'temp.txt', path: filePath);
              },
            ),
            _buildButton(
              '分享文件-bytes',
              () async {
                // 创建文件
                final String tempFilePath = await PathUtils.getAppCachePath();
                String filePath = '$tempFilePath/temp.txt';
                final File testFile = File(filePath);
                await testFile.writeAsString('Hello, world!');
                // 获取文件bytes
                Uint8List bytes = await testFile.readAsBytes();
                return ShareUtils.shareFile(name: 'temp.html', bytes: bytes);
              },
            ),
            _buildButton(
              '分享多个文件',
              () async {
                // 创建多个文件
                final String tempFilePath = await PathUtils.getAppCachePath();
                String filePath1 = '$tempFilePath/temp1.txt';
                String filePath2 = '$tempFilePath/temp2.txt';
                final File testFile1 = File(filePath1);
                final File testFile2 = File(filePath2);
                await testFile1.writeAsString('Hello, world!');
                await testFile2.writeAsString('Hello, world!');
                // 获取文件路径
                filePath1 = testFile1.absolute.path;
                filePath2 = testFile2.absolute.path;
                return ShareUtils.shareFiles([
                  ShareFile(name: 'temp1.txt', path: filePath1),
                  ShareFile(name: 'temp2.txt', path: filePath2),
                ]);
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_util_code/utils.dart';
import 'package:flutter_util_code_example/widget/display_screen.dart';

///  Name: Path工具页
///  Created by Fitem on 2023/6/5
class PathPage extends StatefulWidget {
  const PathPage({Key? key}) : super(key: key);

  @override
  UuidPageState createState() => UuidPageState();
}

class UuidPageState<UuidPage> extends State {

  final GlobalKey<DisplayScreenState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Path工具类'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ElevatedButton(onPressed: _handlePath , child: const Text('获取系统Path信息')),
            const Spacer(),
            Expanded(
              flex: 2,
              child: DisplayScreen(key: globalKey)
            ),
          ],
        ),
      ),
    );
  }

  /// 添加内容
  void addContent(String content) {
    globalKey.currentState?.addContent(content);
  }


  Future<void> _handlePath() async {
    // App缓存目录
    String appCachePath = await PathUtils.getAppCachePath();
    // App支持目录
    String appSupportPath = await PathUtils.getAppSupportPath();
    // App文档目录
    String appDocPath = await PathUtils.getAppDocPath();
    // iOS / Android 通用目录
    addContent('App缓存目录: $appCachePath\n');
    addContent('App支持目录: $appSupportPath\n');
    addContent('App文档目录: $appDocPath\n');

    // iOS独有目录
    if(Platform.isIOS || Platform.isMacOS) {
      // 下载目录 - 仅iOS
      String downloadPath = await PathUtils.getDownloadPath();
      addContent('下载目录: $downloadPath\n');
    } else if(Platform.isAndroid) {
      // Android独有目录
      // Android外部存储目录
      String androidStoragePath = await PathUtils.getAndroidStoragePath();
      // Android外部缓存目录
      List<String> androidExternalCachePaths = await PathUtils.getAndroidExternalCachePaths();
      // Android图片目录
      List<String> androidPicturePaths = await PathUtils.getAndroidPicturePaths();
      // Android视频目录
      List<String> androidMoviePaths = await PathUtils.getAndroidMoviePaths();
      // Android音乐目录
      List<String> androidMusicPaths = await PathUtils.getAndroidMusicPaths();
      // Android相机目录
      List<String> androidDCIMPaths = await PathUtils.getAndroidDCIMPaths();
      // Android下载目录
      List<String> androidDownloadPaths = await PathUtils.getAndroidDownloadPaths();
      // Android文档目录
      List<String> androidDocumentPaths = await PathUtils.getAndroidDocumentPaths();

      addContent('Android外部存储目录: $androidStoragePath\n');
      addContent('Android外部缓存目录: $androidExternalCachePaths\n');
      addContent('Android图片目录: $androidPicturePaths\n');
      addContent('Android视频目录: $androidMoviePaths\n');
      addContent('Android音乐目录: $androidMusicPaths\n');
      addContent('Android相机目录: $androidDCIMPaths\n');
      addContent('Android下载目录: $androidDownloadPaths\n');
      addContent('Android文档目录: $androidDocumentPaths\n');
    }
  }
}

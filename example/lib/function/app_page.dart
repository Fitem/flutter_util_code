import 'package:flutter/material.dart';
import 'package:flutter_util_code/utils.dart';
import 'package:flutter_util_code_example/widget/display_screen.dart';

///  Name: App相关工具类
///  Created by Fitem on 2023/6/7
class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  AppPageState createState() => AppPageState();
}

class AppPageState<AppPage> extends State {

  final GlobalKey<DisplayScreenState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App工具类'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ElevatedButton(onPressed: () async => addContent('AppName: ${await AppUtils.getAppName()}'), child: const Text('获取App名称')),
            ElevatedButton(onPressed: () async => addContent('PackageName: ${await AppUtils.getPackageName()}'), child: const Text('获取App包名')),
            ElevatedButton(onPressed: () async => addContent('VersionName: ${await AppUtils.getVersionName()}'), child: const Text('获取App版本名称')),
            ElevatedButton(onPressed: () async => addContent('VersionNumber: ${await AppUtils.getVersionNumber()}'), child: const Text('获取App版本号')),
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

}
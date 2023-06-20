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
            ElevatedButton(onPressed: () async => addContent(), child: const Text('获取App信息')),
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
  Future<void> addContent() async {
    StringBuffer sb = StringBuffer();
    sb.write('App名称: ${await AppUtils.getAppName()} \n');
    sb.write('App包名: ${await AppUtils.getPackageName()} \n');
    sb.write('App版本名称: ${await AppUtils.getVersionName()} \n');
    sb.write('App版本号: ${await AppUtils.getVersionNumber()} \n');
    sb.write('App构建签名: ${await AppUtils.getBuildSignature()} \n');
    sb.write('App安装商店: ${await AppUtils.getInstallerStore()} \n');
    globalKey.currentState?.addContent(sb.toString());
  }

}
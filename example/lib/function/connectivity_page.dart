import 'package:flutter/material.dart';
import 'package:flutter_util_code/utils.dart';
import 'package:flutter_util_code_example/widget/display_screen.dart';

///  Name: 网络监听页
///  Created by Fitem on 2023/7/3
class ConnectivityPage extends StatefulWidget {
  const ConnectivityPage({super.key});

  @override
  ConnectivityPageState createState() => ConnectivityPageState();
}

class ConnectivityPageState<ConnectivityPage> extends State {
  final ConnectivityUtils _connectivityUtils = ConnectivityUtils.getInstance();
  final GlobalKey<DisplayScreenState> globalKey = GlobalKey();
  late ConnectivityResultCallBack _callBack;

  @override
  void initState() {
    super.initState();
    _callBack = (ConnectivityResult result) {
      addContent('当前网络状态: $result\n');
    };
  }

  @override
  void dispose() {
    // 取消网络监听
    disposeConnectivity();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('网络监听工具类'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ElevatedButton(onPressed: checkConnectivity, child: const Text('获取当前网络状态')),
            ElevatedButton(onPressed: addListener, child: const Text('添加网络状态监听')),
            ElevatedButton(onPressed: removeListener, child: const Text('移除网络状态监听')),
            ElevatedButton(onPressed: disposeConnectivity, child: const Text('取消网络状态监听')),
            const Spacer(),
            Expanded(flex: 2, child: DisplayScreen(key: globalKey)),
          ],
        ),
      ),
    );
  }

  /// 检查网络状态
  Future<void> checkConnectivity() async {
    ConnectivityResult result = await _connectivityUtils.checkConnectivity();
    addContent('当前网络状态: $result\n');
  }

  /// 添加监听
  void addListener() {
    _connectivityUtils.listen(_callBack);
  }

  /// 移除监听
  void removeListener() {
    _connectivityUtils.off(_callBack);
  }

  /// 取消网络监听
  void disposeConnectivity(){
    _connectivityUtils.dispose();
  }

  /// 添加内容
  void addContent(String content) {
    globalKey.currentState?.addContent(content);
  }
}

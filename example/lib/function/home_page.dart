import 'package:flutter/material.dart';
import 'package:flutter_util_code_example/router/router.dart';
import 'package:get/get.dart';

///  Name: 首页
///  Created by Fitem on 2023/5/31
class HomePage extends StatelessWidget {
  HomePage({super.key});

  final Map<String, String> _routerMap = {
    RouterName.log: '日志工具类',
    RouterName.sharedPreference: 'SharedPreference工具类',
    RouterName.toast: 'Toast工具类',
    RouterName.uuid: 'UUID工具类',
    RouterName.device: '设备Device工具类',
    RouterName.app: 'App工具类',
    RouterName.path: 'Path工具类',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterUtilCode'),
      ),
      body: ListView.builder(
        itemCount: _routerMap.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(_routerMap.values.elementAt(index)),
            onTap: () {
              Get.toNamed(_routerMap.keys.elementAt(index));
            },
          );
        },
      ),
    );
  }
}

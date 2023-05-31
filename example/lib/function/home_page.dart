import 'package:flutter/material.dart';
import 'package:flutter_util_code_example/router/router.dart';
import 'package:get/get.dart';

///  Name: 首页
///  Created by Fitem on 2023/5/31
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterUtilCode'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('日志工具类'),
            onTap: () {
              Get.toNamed(RouterName.log);
            },
          ),
          ListTile(
            title: const Text('SharedPreference工具类'),
            onTap: () {
              Get.toNamed(RouterName.sharedPreference);
            },
          ),
        ],
      ),
    );
  }
}
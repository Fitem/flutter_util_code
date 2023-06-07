import 'package:flutter/material.dart';
import 'package:flutter_util_code/utils.dart';
import 'package:flutter_util_code_example/widget/display_screen.dart';

///  Name: 设备工具页
///  Created by Fitem on 2023/6/5
class DevicePage extends StatelessWidget {
  DevicePage({Key? key}) : super(key: key);

  final GlobalKey<DisplayScreenState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device工具类'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ElevatedButton(onPressed: () async => addContent('设备唯一ID: ${await DeviceUtils.getDeviceId()}'), child: const Text('获取设备ID')),
            ElevatedButton(onPressed: () async => addContent('品牌: ${await DeviceUtils.getBrand()}'), child: const Text('获取设备品牌')),
            ElevatedButton(onPressed: () async => addContent('设备型号: ${await DeviceUtils.getModel()}'), child: const Text('获取设备型号')),
            ElevatedButton(onPressed: () async => addContent('系统版本: ${await DeviceUtils.getSystemVersion()}'), child: const Text('获取设备系统版本号')),
            ElevatedButton(onPressed: () async => addContent('版本名称: ${await DeviceUtils.getSystemName()}'), child: const Text('获取设备系统名称')),
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
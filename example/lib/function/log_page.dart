import 'package:flutter/material.dart';
import 'package:flutter_util_code/utils.dart';

///  Name: Log工具类页面
///  Created by Fitem on 2023/5/31
class LogPage extends StatefulWidget {
  const LogPage({super.key});

  @override
  LogPageState createState() => LogPageState();
}

class LogPageState<LogPage> extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log工具类'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ElevatedButton(onPressed: _handlePrintLog, child: const Text('打印日志')),
            ElevatedButton(onPressed: _handlePrintLongLog, child: const Text('打印长日志')),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('日志开关:'),
                Switch(value: LogUtils.isOpenLog, onChanged: onSwitchChanged),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// 打印日志
  void _handlePrintLog() {
    LogUtils.println('这是一条测试日志');
  }

  /// 打印长日志
  void _handlePrintLongLog() {
    LogUtils.logger('这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，'
        '这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，'
        '这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，'
        '这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，这是一条非常长的日志，');
  }

  /// 日志开关
  void onSwitchChanged(bool value) {
    setState(() {
      if (!value) LogUtils.println('日志开关已关闭');
      LogUtils.isOpenLog = value;
      if (value) LogUtils.println('日志开关已打开');
    });
  }
}

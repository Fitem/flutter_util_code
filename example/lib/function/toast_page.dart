import 'package:flutter/material.dart';
import 'package:flutter_util_code/utils.dart';

///  Name: Toast工具页
///  Created by Fitem on 2023/6/4
class ToastPage extends StatelessWidget {
  const ToastPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Toast工具类'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ElevatedButton(onPressed: _handleToastShow, child: const Text('ToastUtils.show()')),
            ElevatedButton(onPressed: _handleToastShowCenter, child: const Text('ToastUtils.showCenter()')),
            ElevatedButton(onPressed: _handleToastShowToast, child: const Text('ToastUtils.showToast()')),
          ],
        ),
      ),
    );
  }

  /// 显示Toast
  void _handleToastShow() {
    ToastUtils.show('这是一条测试Toast');
  }

  /// 显示中间Toast
  void _handleToastShowCenter() {
    ToastUtils.showCenter('这是一条测试Toast');
  }

  /// 显示自定义Toast
  void _handleToastShowToast() {
    ToastUtils.showToast(
      '这是一条测试Toast',
      gravity: FToastGravity.snackBar,
      toast: FToast.lengthLong,
      bgColor: Colors.red,
      textColor: Colors.white,
      fontSize: 20,
    );
  }
}

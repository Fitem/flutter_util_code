import 'package:flutter/material.dart';
import 'package:flutter_util_code/share_utils.dart';
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
              '分享图片',
              () => ShareUtils.shareImage(
                path: 'assets/images/logo.png',
                name: 'logo.png',
                subject: '分享主题',
                text: '分享内容',
              ),
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

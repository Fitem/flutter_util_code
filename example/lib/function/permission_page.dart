import 'package:flutter/material.dart';
import 'package:flutter_util_code/utils.dart';
import 'package:flutter_util_code_example/widget/display_screen.dart';

///  Name: 权限页面
///  Created by Fitem on 2023/7/4
class PermissionPage extends StatefulWidget {
  const PermissionPage({Key? key}) : super(key: key);

  @override
  PermissionPageState createState() => PermissionPageState();
}

class PermissionPageState<PermissionPage> extends State {
  Permission permission = Permission.storage;
  List<Permission> permissions = [Permission.storage, Permission.camera];
  final GlobalKey<DisplayScreenState> globalKey = GlobalKey();

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
            _buildButton('当前权限状态', () async {
              PermissionStatus status = await PermissionUtils.getPermissionStatus(permission);
              ToastUtils.show('获取当前权限状态：$status');
              return status;
            }),
            _buildButton('请求单个权限', () async {
              PermissionStatus status = await PermissionUtils.requestPermission(
                permission,
                success: () => ToastUtils.showToast('$permission 权限获取成功！'),
                denied: (isPermanentlyDenied) {
                  if (isPermanentlyDenied) {
                    ToastUtils.showToast('$permission 被拒绝请打开应用设置手动开启！');
                  } else {
                    ToastUtils.showToast('$permission 被拒绝，请重新授权！');
                  }
                },
                other: (status) => ToastUtils.showToast('$permission 权限状态：$status'),
              );
              return status;
            }),
            _buildButton('请求多个权限', () async {
              PermissionStatus status = await PermissionUtils.requestPermissions(
                permissions,
                success: () => ToastUtils.showToast('$permission 权限获取成功！'),
                denied: (isPermanentlyDenied) {
                  if (isPermanentlyDenied) {
                    ToastUtils.showToast('$permission 被拒绝请打开应用设置手动开启！');
                  } else {
                    ToastUtils.showToast('$permission 被拒绝，请重新授权！');
                  }
                },
                other: (status) => ToastUtils.showToast('$permission 权限状态：$status'),
              );
              return status;
            }),
            const Spacer(),
            Expanded(flex: 2, child: DisplayScreen(key: globalKey)),
          ],
        ),
      ),
    );
  }

  /// 通用按钮
  Widget _buildButton(String text, Future<PermissionStatus> Function() onPressed) {
    return ElevatedButton(
        onPressed: () async {
          PermissionStatus status = await onPressed();
          addContent('当前权限状态：$status');
        },
        child: Text(text));
  }

  /// 添加内容
  void addContent(String content) {
    globalKey.currentState?.addContent(content);
  }
}

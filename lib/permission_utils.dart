import 'package:permission_handler/permission_handler.dart';

/// 授权成功回调
typedef SuccessCallBack = void Function();

/// 授权失败回调
typedef DeniedCallBack = void Function(bool isPermanentlyDenied);

/// 其他回调
typedef OtherCallBack = void Function(PermissionStatus status);

///  Name: PermissionUtils
///  Created by Fitem on 2023/7/4
class PermissionUtils {

  /// 获取权限状态
  /// [Permission] 请求的权限
  static Future<PermissionStatus> getPermissionStatus(Permission permission) async {
    return await permission.status;
  }

  /// 请求权限
  /// [Permission] 请求的权限
  /// [success] 授权成功回调
  /// [denied] 授权失败回调; [isPermanentlyDenied] 是否永久拒绝
  /// [other] 其他回调
  static Future<PermissionStatus> requestPermission(
    Permission permission, {
    SuccessCallBack? success,
    DeniedCallBack? denied,
    OtherCallBack? other,
  }) async {
    var status = await permission.request();
    if (status == PermissionStatus.granted) {
      success?.call();
    } else if (status == PermissionStatus.denied || status == PermissionStatus.restricted) {
      denied?.call(status.isPermanentlyDenied);
    } else {
      other?.call(status);
    }
    return status;
  }

  /// 请求获取多个权限
  /// [Permission] 请求的权限
  /// [success] 授权成功回调
  /// [denied] 授权失败回调; [isPermanentlyDenied] 是否永久拒绝
  /// [other] 其他回调
  static Future<PermissionStatus> requestPermissions(
    List<Permission> permissions, {
    SuccessCallBack? success,
    DeniedCallBack? denied,
    OtherCallBack? other,
  }) async {
    // 请求权限
    Map<Permission, PermissionStatus> map = await permissions.request();
    // 遍历权限
    for (Permission key in map.keys) {
      var status = map[key];
      if (status == PermissionStatus.granted) {
        // 只有全部权限都被授权，才返回成功
      } else if (status == PermissionStatus.denied || status == PermissionStatus.restricted) {
        // 若有一个权限被拒绝，则返回失败
        denied?.call(status!.isPermanentlyDenied);
        return status!;
      } else {
        // 若有其他情况，则返回其他
        other?.call(status!);
        return status!;
      }
    }
    success?.call();
    return PermissionStatus.granted;
  }
}

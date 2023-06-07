import 'package:package_info_plus/package_info_plus.dart';

///  Name: App工具类
///  基于 [package_info_plus](https://pub.dev/packages/package_info_plus)
///  Created by Fitem on 2023/6/7
class AppUtils {
  /// App名称
  static Future<String> getAppName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.appName;
  }

  /// 包名
  static Future<String> getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  /// 版本名
  static Future<String> getVersionName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  /// 版本号
  static Future<String> getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }
}
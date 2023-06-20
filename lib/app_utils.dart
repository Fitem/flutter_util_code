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

  /// 获取App构建签名
  /// 在 iOS 上为空字符串，在 Android 上为密钥签名(十六进制)
  static Future<String> getBuildSignature() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildSignature;
  }

  /// 获取App安装商店
  /// 若是通过应用商店安装的应用，返回应用商店的名称，否则返回空字符串
  static Future<String> getInstallerStore() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.installerStore ?? '';
  }
}
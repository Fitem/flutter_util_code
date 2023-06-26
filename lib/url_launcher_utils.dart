import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_util_code/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

///  Name: URL跳转工具类
///  基于 [url_launcher](https://pub.dev/packages/url_launcher)
///  *注意使用此功能需要添加权限*
///  在Android上，需要在AndroidManifest.xml中添加：<uses-permission android:name="android.permission.QUERY_ALL_PACKAGES" />
///  在iOS上，需要在Info.plist中添加：<key>LSApplicationQueriesSchemes</key> <array><string>sms</string><string>tel</string></array>
///  Created by Fitem on 2023/6/19
class UrlLauncherUtils {
  /// 浏览器打开url
  /// [url] 跳转的url  https://flutter.dev
  /// 若不支持浏览器则返回false
  static Future<bool> launchInBrowser(String url) async {
    // 是否支持浏览器打开，支持则打开，不支持则返回false
    if (!await onCanLaunchUrl(url)) return false;
    return await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  /// 非浏览器第三方应用打开url
  /// [url] 跳转的url  https://flutter.dev
  /// 若不支持非浏览器第三方应用则返回false
  static Future<bool> launchInNonBrowser(String url) async {
    // 是否支持浏览器打开，支持则打开，不支持则抛出异常
    if (!await onCanLaunchUrl(url)) return false;
    return await launchUrlString(url, mode: LaunchMode.externalNonBrowserApplication);
  }

  /// WebView打开url
  /// [url] 跳转的url  https://flutter.dev
  /// 若不支持WebView则返回false
  static Future<bool> launchInApp(String url) async {
    // 是否支持浏览器打开，支持则打开，不支持则抛出异常
    if (!await onCanLaunchUrl(url)) return false;
    return await launchUrlString(url, mode: LaunchMode.inAppWebView);
  }

  /// 关闭WebView
  static Future<void> onCloseInAppWebView() async {
    return await closeInAppWebView();
  }

  /// 打电话
  /// [phoneNumber] 电话号码  10086
  /// 若不支持打电话则返回false
  static Future<bool> makePhoneCall(String phoneNumber) async {
    Uri uri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await onCanLaunchUrl(uri.toString())) return false;
    return await launchUrl(uri);
  }

  /// 发短信
  /// [phoneNumber] 电话号码  10086
  /// 若不支持发短信则返回false
  static Future<bool> sendSMS(String phoneNumber, {String content = ''}) async {
    Uri uri = Uri(scheme: 'sms', path: phoneNumber, queryParameters: {'body': content});
    if (!await onCanLaunchUrl(uri.toString())) return false;
    return await launchUrl(uri);
  }

  /// 发送邮件
  /// [mailAddress] 邮箱地址  smith@example.org?subject=News&body=New%20plugin
  /// 若不支持发邮件则返回false
  static Future<bool> sendEmail(
    String mailAddress, {
    String subject = '',
    String content = '',
  }) async {
    Uri uri = Uri(scheme: 'mailto', path: mailAddress, queryParameters: {'subject': subject, 'body': content});
    if (!await onCanLaunchUrl(uri.toString())) return false;
    return await launchUrl(uri);
  }

  /// 打开文件
  /// [filePath] 文件路径   /storage/emulated/0/Download/xxx.pdf
  /// 若不支持打开文件则返回false
  /// 由于Android 7.0 以上版本的限制，无法直接通过file://的方式来打开文件，需要通过FileProvider来打开
  static Future<bool> openFile(String filePath) async {
    LogUtils.println('filePath: $filePath');
    if (!File(filePath).existsSync()) {
      LogUtils.println('文件不存在');
      return false;
    }
    Uri uri = Uri(scheme: 'file', path: filePath);
    // 由于Android 7.0 以上版本的限制，无法直接通过file://的方式来打开文件，需要通过FileProvider来打开
    if (!kIsWeb && Platform.isAndroid && int.parse(await DeviceUtils.getSystemVersion()) >= 24) return false;
    if (!await onCanLaunchUrl(uri.toString())) return false;
    return await launchUrl(uri);
  }

  /// 是否支持该url打开
  /// [url] 跳转的url
  static Future<bool> onCanLaunchUrl(String url) async {
    LogUtils.println('url: $url');
    return await canLaunchUrlString(url);
  }
}

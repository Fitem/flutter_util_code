import 'package:flutter_util_code_example/function/app_page.dart';
import 'package:flutter_util_code_example/function/device_page.dart';
import 'package:flutter_util_code_example/function/encrypted_page.dart';
import 'package:flutter_util_code_example/function/home_page.dart';
import 'package:flutter_util_code_example/function/log_page.dart';
import 'package:flutter_util_code_example/function/path_page.dart';
import 'package:flutter_util_code_example/function/shared_prefs/shared_prefs_page.dart';
import 'package:flutter_util_code_example/function/toast_page.dart';
import 'package:flutter_util_code_example/function/url_launcher_page.dart';
import 'package:flutter_util_code_example/function/uuid_page.dart';
import 'package:flutter_util_code_example/router/router_name.dart';
import 'package:get/get.dart';

///  Name: 路由页面
///  Created by Fitem on 2023/5/31

class RouterPage {
  static final pages = [
    /// 首页
    GetPage(
      name: RouterName.home,
      page: () => HomePage(),
    ),

    /// 日志工具类页
    GetPage(
      name: RouterName.log,
      page: () => const LogPage(),
    ),

    /// SharedPreference工具类页
    GetPage(
      name: RouterName.sharedPreference,
      page: () => const SharedPrefsPage(),
    ),

    /// Toast工具类页
    GetPage(
      name: RouterName.toast,
      page: () => const ToastPage(),
    ),
    /// UUID工具类页
    GetPage(
      name: RouterName.uuid,
      page: () => const UuidPage(),
    ),
    /// 设备Device工具类页
    GetPage(
      name: RouterName.device,
      page: () => DevicePage(),
    ),
    /// App工具类页
    GetPage(
      name: RouterName.app,
      page: () => const AppPage(),
    ),
    /// Path工具类页
    GetPage(
      name: RouterName.path,
      page: () => const PathPage(),
    ),
    /// Encrypt工具类页
    GetPage(
      name: RouterName.encrypt,
      page: () => const EncryptPage(),
    ),
    /// UrlLauncher工具类页
    GetPage(
      name: RouterName.urlLauncher,
      page: () => const UrlLauncherPage(),
    ),
  ];
}

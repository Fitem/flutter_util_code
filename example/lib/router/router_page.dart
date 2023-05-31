import 'package:flutter_util_code_example/function/home_page.dart';
import 'package:flutter_util_code_example/function/log_page.dart';
import 'package:flutter_util_code_example/function/shared_prefs/shared_prefs_page.dart';
import 'package:flutter_util_code_example/router/router_name.dart';
import 'package:get/get.dart';

///  Name: 路由页面
///  Created by Fitem on 2023/5/31

class RouterPage {
  static final pages = [
    /// 首页
    GetPage(
      name: RouterName.home,
      page: () => const HomePage(),
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
  ];
}

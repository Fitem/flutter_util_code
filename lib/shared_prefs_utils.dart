import 'package:flutter_util_code/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

///  Name: SP工具类
///  基于 [shared_preferences](https://pub.dev/packages/shared_preferences)
///  Created by Fitem on 2023/5/31
class SharedPrefsUtil {

  /// 添加String类型数据
  /// [key] 键
  /// [value] 值
  static Future<void> putString(String key, String value) async {
    _println('putString', key, value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  /// 添加int类型数据
  /// [key] 键
  /// [value] 值
  static Future<void> putInt(String key, int value) async {
    _println('putInt', key, value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

  /// 添加bool类型数据
  /// [key] 键
  /// [value] 值
  static Future<void> putBool(String key, bool value) async {
    _println('putBool', key, value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  /// 添加double类型数据
  /// [key] 键
  /// [value] 值
  static Future<void> putDouble(String key, double value) async {
    _println('putDouble', key, value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setDouble(key, value);
  }

  /// 添加List<String>类型数据
  /// [key] 键
  /// [value] 值
  static Future<void> putStringList(String key, List<String> value) async {
    _println('putStringList', key, value);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }

  /// 获取String类型数据
  /// [key] 键
  /// [defValue] 默认值
  static Future<String?> getString(String key, [String? defValue]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? value = prefs.getString(key) ?? defValue;
    _println('getString', key, value);
    return value;
  }

  /// 获取int类型数据，如果没有则返回默认值
  /// [key] 键
  /// [defValue] 默认值
  static Future<int?> getInt(String key, [int? defValue]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? value = prefs.getInt(key) ?? defValue;
    _println('getInt', key, value);
    return value;
  }

  /// 获取double类型数据，如果没有则返回默认值
  /// [key] 键
  /// [defValue] 默认值
  static Future<double?> getDouble(String key, [double? defValue]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? value = prefs.getDouble(key) ?? defValue;
    _println('getDouble', key, value);
    return value;
  }

  /// 获取bool类型数据，如果没有则返回默认值
  /// [key] 键
  /// [defValue] 默认值
  static Future<bool?> getBool(String key, [bool? defValue]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? value = prefs.getBool(key) ?? defValue;
    _println('getBool', key, value);
    return value;
  }

  /// 获取List<String>类型数据，如果没有则返回默认值
  /// [key] 键
  /// [defValue] 默认值
  static Future<List<String>?> getStringList(String key, [List<String>? defValue]) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? value = prefs.getStringList(key) ?? defValue;
    _println('getStringList', key, value);
    return value;
  }

  /// 打印日志
  static void _println(String methodName, String key, dynamic value) {
    LogUtil.println('''SharedPref $methodName:
    key: $key 
    value: $value''');
  }
}

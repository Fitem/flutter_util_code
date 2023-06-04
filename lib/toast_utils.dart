import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

///  Name: 吐司工具类
///  基于 [fluttertoast](https://pub.dev/packages/fluttertoast)
///  Created by Fitem on 2023/6/1
class ToastUtils {
  /// 背景色
  static Color toastBgColor = const Color(0x80000000);

  /// Text颜色
  static Color toastTextColor = Colors.white;

  /// 字体大小
  static double toastFontSize = 16.0;

  /// 初始化 Toast
  /// [bgColor] 背景色
  /// [textColor] Text颜色
  /// [fontSize] 字体大小
  static void init({Color? bgColor, Color? textColor, double? fontSize}) {
    toastBgColor = bgColor ?? toastBgColor;
    toastTextColor = textColor ?? toastTextColor;
    toastFontSize = fontSize ?? toastFontSize;
  }

  /// 显示中间的Toast
  /// [msg] 显示的内容
  static void showCenter(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      backgroundColor: toastBgColor,
      textColor: toastTextColor,
      fontSize: 16.0,
    );
  }

  /// 显示底部的Toast
  /// [msg] 显示的内容
  static void show(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: toastBgColor,
      textColor: toastTextColor,
      fontSize: 16.0,
    );
  }

  /// 显示的Toast
  /// [msg] 显示的内容
  /// [toast] 显示的时间
  /// [gravity] 显示的位置
  /// [bgColor] 背景色
  /// [textColor] Text颜色
  /// [fontSize] 字体大小
  static void showToast(
    String msg, {
    FToast toast = FToast.lengthShort,
    FToastGravity gravity = FToastGravity.bottom,
    Color? bgColor,
    Color? textColor,
    double? fontSize,
  }) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: _getToastLength(toast),
      gravity: _getToastGravity(gravity),
      backgroundColor: bgColor ?? toastBgColor,
      textColor: textColor ?? toastTextColor,
      fontSize: fontSize ?? toastFontSize,
    );
  }

  /// 获取Toast显示时间
  static _getToastLength(FToast toast) {
    switch (toast) {
      case FToast.lengthShort:
        return Toast.LENGTH_SHORT;
      case FToast.lengthLong:
        return Toast.LENGTH_LONG;
    }
  }

  /// 获取Toast显示位置
  static _getToastGravity(FToastGravity gravity) {
    switch (gravity) {
      case FToastGravity.top:
        return ToastGravity.TOP;
      case FToastGravity.bottom:
        return ToastGravity.BOTTOM;
      case FToastGravity.center:
        return ToastGravity.CENTER;
      case FToastGravity.topLeft:
        return ToastGravity.TOP_LEFT;
      case FToastGravity.topRight:
        return ToastGravity.TOP_RIGHT;
      case FToastGravity.bottomLeft:
        return ToastGravity.BOTTOM_LEFT;
      case FToastGravity.bottomRight:
        return ToastGravity.BOTTOM_RIGHT;
      case FToastGravity.centerLeft:
        return ToastGravity.CENTER_LEFT;
      case FToastGravity.centerRight:
        return ToastGravity.CENTER_RIGHT;
      case FToastGravity.snackBar:
        return ToastGravity.SNACKBAR;
      case FToastGravity.none:
        return ToastGravity.NONE;
    }
  }
}

/// Toast显示位置
enum FToastGravity {
  top,
  bottom,
  center,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight,
  centerLeft,
  centerRight,
  snackBar,
  none
}

/// Toast显示时间
/// 两种模式：[lengthShort] 显示时长 1秒钟、[lengthLong] 显示时长 5秒钟
/// Only for Android Platform
enum FToast {
  /// Show Short toast for 1 sec
  lengthShort,

  /// Show Long toast for 5 sec
  lengthLong
}
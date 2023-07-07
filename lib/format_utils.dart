import 'package:intl/intl.dart';

///  Name: 格式化工具类
///  基于 [intl](https://pub.dev/packages/intl)
///  Created by Fitem on 2023/7/7
class FormatUtils {
  /// 货币数字格式化-整数
  static const String moneyIntPattern = ',###';

  /// 货币数字格式化-小数点后2位
  static const String moneyPointPattern = '.00';

  /// 货币数字格式化
  static const String moneyPattern = moneyIntPattern + moneyPointPattern;

  /// 解析货币数字
  /// [num] 数字
  /// [pattern] 格式化规则
  /// [locale] 地域
  /// 解析结果：1000000 -> 1,000,000.00
  static String formatMoney(
    num num, [
    String pattern = moneyPattern,
    String locale = 'en_US',
  ]) {
    return NumberFormat(pattern, locale).format(num);
  }

  /// 解析小数点，默认保留两位小数
  /// [num] 数字
  /// [digit] 保留小数位数，默认保留2位小数
  /// 解析结果：1.234 -> 1.23
  static String formatPoint(
    num num, [
    int digit = 2,
    String locale = 'en_US',
  ]) {
    String pattern = '.${'0' * digit}';
    NumberFormat format = NumberFormat(pattern, locale);
    return format.format(num);
  }

  /// 解析小数点，做多保留两位小数，若尾数为0，则去掉
  /// [num] 数字
  /// [digit] 保留小数位数，默认保留2位小数
  /// [locale] 地域
  /// 解析结果：1.20 -> 1.0
  static String formatPointMax(
    num num, [
    int digit = 2,
    String locale = 'en_US',
  ]) {
    String pattern = '.${'#' * digit}';
    NumberFormat format = NumberFormat(pattern, locale);
    return format.format(num);
  }

  /// 解析数字，转化为两位数，不足补0
  /// [num] 数字
  /// [digit] 保留位数，默认保留2位数
  /// [locale] 地域
  /// 解析结果：1 -> 01
  static String formatInt(
    int num, [
    int digit = 2,
    String locale = 'en_US',
  ]) {
    String pattern = '0' * digit;
    NumberFormat format = NumberFormat(pattern, locale);
    return format.format(num);
  }

  /// 解析数字，转化为百分比
  /// [num] 数字
  /// [locale] 地域
  /// 解析结果：0.1234 -> 12.34%
  static String formatPercent(num num, [String locale = 'en_US']) {
    String pattern = '#.##%';
    NumberFormat format = NumberFormat(pattern, locale);
    return format.format(num);
  }

  /// 解析数字，转化为千分比
  /// [num] 数字
  /// [locale] 地域
  /// 解析结果：0.1234 -> 123.4‰
  static String formatPermillage(num num, [String locale = 'en_US']) {
    String pattern = '#.##‰';
    NumberFormat format = NumberFormat(pattern, locale);
    return format.format(num);
  }
}

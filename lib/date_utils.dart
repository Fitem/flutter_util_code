import 'package:intl/intl.dart';

///  Name: 日期时间工具类
///  Created by Fitem on 2023/7/17
class DateUtils {
  /// 时间计算
  static const int oneSecond = 1000;
  static const int oneMinute = 60 * oneSecond;
  static const int oneHour = 60 * oneMinute;
  static const int oneDay = 24 * oneHour;
  static const int oneWeek = 7 * oneDay;
  static const int oneMonth = 30 * oneDay;
  static const int oneYear = 365 * oneDay;

  /// 日期格式化
  static const String dateTimeFormat = '$dateFormat $timeFormat';
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateFormat2 = 'yyyy/MM/dd';
  static const String dateFormat3 = 'MM-dd';
  static const String timeFormat = 'HH:mm:ss';
  static const String timeFormat2 = 'HH:mm';

  /// 星期名称列表
  static const List<String> weekList = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];

  /// 相差时间名称列表
  static const List<String> timeRangeList = ['一分钟内', '一小时内', '一天内', '一周内', '一个月内', '一年内', '一年以上'];

  /// 日期时间格式化
  /// [timestamp] 时间戳
  /// [format] 格式化字符串 默认为 [dateTimeFormat]
  /// 默认返回：2021-07-17 15:30:00
  static String formatDateTime(DateTime timestamp, [String format = dateTimeFormat]) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(timestamp);
  }

  /// 日期格式化
  /// [timestamp] 时间戳
  /// [format] 格式化字符串 默认为 [dateFormat]
  /// 默认返回：2021-07-17
  static String formatDate(DateTime timestamp, [String format = dateFormat]) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(timestamp);
  }

  /// 时间格式化
  /// [timestamp] 时间戳
  /// [format] 格式化字符串 默认为 [timeFormat]
  /// 默认返回：15:30:00
  static String formatTime(DateTime timestamp, [String format = timeFormat]) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(timestamp);
  }

  /// 时分格式化
  /// [timestamp] 时间戳
  /// [format] 格式化字符串 默认为 [timeFormat2]
  /// 默认返回：15:30
  static String formatHHmm(DateTime timestamp, [String format = timeFormat2]) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(timestamp);
  }

  /// 解析日期时间
  /// [time] 时间字符串
  /// [format] 格式化字符串 默认为 [dateTimeFormat]
  /// [utc] 是否使用utc时间 默认为 false
  static DateTime parseDateTime(String time, [String format = dateTimeFormat, bool utc = false]) {
    DateFormat dateFormat = DateFormat(format);
    return dateFormat.parse(time, utc);
  }

  /// 获取星期几
  /// [time] 时间字符串
  /// 从周一开始，周日为6
  static int getWeekIndex(DateTime timestamp) {
    return timestamp.weekday - 1;
  }

  /// 获取星期名称
  /// [time] 时间字符串
  /// [weekList] 星期名称列表 默认为 [weekList]
  static String getWeekName(DateTime timestamp, [List<String> weekList = weekList]) {
    return weekList[timestamp.weekday - 1];
  }

  /// 计算两个时间的时间差
  /// [start] 开始时间
  /// [end] 结束时间
  /// 返回值：毫秒数
  /// 若为负值，则表示 [end] 在 [start] 之前
  static int diff(DateTime start, DateTime end) {
    return end.millisecondsSinceEpoch - start.millisecondsSinceEpoch;
  }

  /// 计算两个时间的差值范围等级
  /// [start] 开始时间
  /// [end] 结束时间
  /// 返回值：0 - 6 对应 1分钟内、1小时内、1天内、1周内、1月内、1年内、1年以上
  static int diffRangeLevel(DateTime start, DateTime end) {
    // 相差时间，单位毫秒，取绝对值
    int duration = diff(start, end).abs();
    if (duration <= oneMinute) {
      return 0;
    } else if (duration <= oneHour) {
      return 1;
    } else if (duration <= oneDay) {
      return 2;
    } else if (duration <= oneWeek) {
      return 3;
    } else if (duration <= oneMonth) {
      return 4;
    } else if (duration <= oneYear) {
      return 5;
    } else {
      return 6;
    }
  }

  /// 相差时间范围说明
  /// [start] 开始时间
  /// [end] 结束时间
  /// [timeRangeList] 相差时间名称列表 默认为 [timeRangeList]
  static String diffRangeName(DateTime start, DateTime end, [List<String> timeRangeList = timeRangeList]) {
    int rangeClass = diffRangeLevel(start, end);
    return timeRangeList[rangeClass];
  }
}

/// [int]转化[DateTime]工具类
extension DateTimeUtils on int {
  /// 时间戳转日期时间
  /// [isUtc] 是否使用utc时间 默认为 false
  /// 单位：毫秒
  DateTime toDateTime([bool isUtc = false]) => DateTime.fromMillisecondsSinceEpoch(this, isUtc: isUtc);
}

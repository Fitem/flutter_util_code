///  Name: 空安全工具类
///  Created by Fitem on 2023/6/27

/// String空安全扩展
extension StringNullSafety on String? {
  /// 转化为非空字符串，如果为空则返回''
  String get toNonNull => this ?? '';

  /// 判断字符串是否为空
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// 判断字符串是否不为空
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// 判断字符串是否为空，如果为空则返回默认值
  String toNonNullString([String def = '']) => isNullOrEmpty ? def : this!;
}

/// int空安全扩展
extension IntNullSafety on int? {
  /// 转化为非空整型，如果为空则返回0
  int get toNonNull => this ?? 0;

  /// 判断是否为空
  bool get isNull => this == null;

  /// 判断是否不为空
  bool get isNotNull => !isNull;

  /// 判断是否为null，如果为null则返回默认值
  int toNonNullInt([int def = 0]) => isNull ? def : this!;
}

/// double空安全扩展
extension DoubleNullSafety on double? {
  /// 转化为非空浮点型，如果为空则返回0.0
  double get toNonNull => this ?? 0.0;

  /// 判断是否为空
  bool get isNull => this == null;

  /// 判断是否不为空
  bool get isNotNull => !isNull;

  /// 判断是否为null，如果为null则返回默认值
  double toNonNullDouble([double def = 0.0]) => isNull ? def : this!;
}

/// bool空安全扩展
extension BoolNullSafety on bool? {
  /// 转化为非空布尔型，如果为空则返回false
  bool get toNonNull => this ?? false;

  /// 判断是否为空
  bool get isNull => this == null;

  /// 判断是否不为空
  bool get isNotNull => !isNull;

  /// 判断是否为null，如果为null则返回默认值
  bool toNonNullBool([bool def = false]) => isNull ? def : this!;
}

/// List空安全扩展
extension ListNullSafety on List? {
  /// 转化为非空数组，如果为空则返回[]
  List get toNonNull => this ?? [];

  /// 判断是否为空
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  /// 判断是否不为空
  bool get isNotNullOrEmpty => !isNullOrEmpty;

  /// 判断是否为空，如果为空则返回默认值
  List toNonNullList([List def = const []]) => isNullOrEmpty ? def : this!;
}

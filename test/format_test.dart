import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_util_code/utils.dart';

///  Name: 格式化工具类测试
///  Created by Fitem on 2023/7/7
void main() {
  group('FormatUtils', () {
    /// 解析货币数字
    test('formatMoney', () {
      expect(FormatUtils.formatMoney(1000000), '1,000,000.00');
      expect(FormatUtils.formatMoney(1000000, FormatUtils.moneyIntPattern), '1,000,000');
      expect(FormatUtils.formatMoney(1000000, FormatUtils.moneyPattern, 'zh_CN'), '1,000,000.00');
    });

    /// 解析小数点
    test('formatPoint', () {
      expect(FormatUtils.formatPoint(1.234), '1.23');
      expect(FormatUtils.formatPoint(1.234, 1), '1.2');
      expect(FormatUtils.formatPoint(1.23456, 3, 'zh_CN'), '1.235');
    });

    /// 解析小数点，做多保留两位小数，若尾数为0，则去掉
    test('formatPointMax', () {
      expect(FormatUtils.formatPointMax(1.20), '1.2');
      expect(FormatUtils.formatPointMax(1.230, 3), '1.23');
      expect(FormatUtils.formatPointMax(1.230, 3, 'zh_CN'), '1.23');
    });

    /// 解析整数，转化为两位数，不足补0
    test('formatInt', () {
      expect(FormatUtils.formatInt(1), '01');
      expect(FormatUtils.formatInt(1, 3), '001');
      expect(FormatUtils.formatInt(1, 3, 'zh_CN'), '001');
    });

    /// 解析数字，转化为百分比
    test('formatPercent', () {
      expect(FormatUtils.formatPercent(0.1234), '12.34%');
      expect(FormatUtils.formatPercent(0.1), '10%');
      expect(FormatUtils.formatPercent(0.1, 'zh_CN'), '10%');
    });

    /// 解析数字，转化为千分比
    test('formatPermillage', () {
      expect(FormatUtils.formatPermillage(0.1234), '123.4‰');
      expect(FormatUtils.formatPermillage(0.1), '100‰');
      expect(FormatUtils.formatPermillage(0.1, 'zh_CN'), '100‰');
    });
  });
}

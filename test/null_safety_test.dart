import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_util_code/utils.dart';

///  Name: 空安全工具类测试
///  Created by Fitem on 2023/6/27
void main() {
  group('NullSafety', () {
    // 字符串空安全校验
    test('StringNullSafety', () {
      String? str;
      expect(str.toNonNull, '');
      expect(str.isNullOrEmpty, true);
      expect(str.isNotNullOrEmpty, false);
      expect(str.toNonNullString('test'), 'test');
    });
    // int空安全校验
    test('IntNullSafety', () {
      int? num;
      expect(num.toNonNull, 0);
      expect(num.isNull, true);
      expect(num.isNotNull, false);
      expect(num.toNonNullInt(1), 1);
    });
    // double空安全校验
    test('DoubleNullSafety', () {
      double? num;
      expect(num.toNonNull, 0.0);
      expect(num.isNull, true);
      expect(num.isNotNull, false);
      expect(num.toNonNullDouble(1.0), 1.0);
    });
    // bool空安全校验
    test('BoolNullSafety', () {
      bool? num;
      expect(num.toNonNull, false);
      expect(num.isNull, true);
      expect(num.isNotNull, false);
      expect(num.toNonNullBool(true), true);
    });
    // List空安全校验
    test('ListNullSafety', () {
      List<int>? list;
      expect(list.toNonNull, []);
      expect(list.isNullOrEmpty, true);
      expect(list.isNotNullOrEmpty, false);
      expect(list.toNonNullList([1]), [1]);
    });
  });
}

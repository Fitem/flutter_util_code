import 'package:uuid/uuid.dart';

///  Name: UUID工具类
///  基于 [uuid](https://pub.dev/packages/uuid)
///  Created by Fitem on 2023/6/4
class UuidUtils {

  /// 获取uuid
  /// 基于uuid v1 + uuid v4 内容通过 getUuidV5 生成的uuid
  /// 例如：c4a760a8-dbcf-5254-a0d9-6a4474bd1b62
  static String getUuid(){
    return getUuidV5(getUuidV1() + getUuidV4());
  }

  /// 获取uuid v1
  /// 基于当前时间生成的uuid
  /// 例如：6c84fb90-12c4-11e1-840d-7b25c5ee775a
  static String getUuidV1() {
    var uuid = const Uuid();
    var v1 = uuid.v1();
    return v1;
  }

  /// 获取uuid v4
  /// 基于mathRNG随机数生成的uuid
  /// 例如：110ec58a-a0f2-4ac4-8393-c866d813b8d1
  static String getUuidV4() {
    var uuid = const Uuid();
    var v4 = uuid.v4();
    return v4;
  }

  /// 获取uuid v5
  /// 基于 namespace + 内容 生成的uuid
  /// 例如：c4a760a8-dbcf-5254-a0d9-6a4474bd1b62
  static String getUuidV5(String content) {
    var uuid = const Uuid();
    var v5 = uuid.v5(Uuid.NAMESPACE_URL, content);
    return v5;
  }
}
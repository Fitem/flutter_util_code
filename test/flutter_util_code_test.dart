import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_util_code/flutter_util_code.dart';
import 'package:flutter_util_code/flutter_util_code_platform_interface.dart';
import 'package:flutter_util_code/flutter_util_code_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterUtilCodePlatform
    with MockPlatformInterfaceMixin
    implements FlutterUtilCodePlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterUtilCodePlatform initialPlatform = FlutterUtilCodePlatform.instance;

  test('$MethodChannelFlutterUtilCode is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterUtilCode>());
  });

  test('getPlatformVersion', () async {
    FlutterUtilCode flutterUtilCodePlugin = FlutterUtilCode();
    MockFlutterUtilCodePlatform fakePlatform = MockFlutterUtilCodePlatform();
    FlutterUtilCodePlatform.instance = fakePlatform;

    expect(await flutterUtilCodePlugin.getPlatformVersion(), '42');
  });
}

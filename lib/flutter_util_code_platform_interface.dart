import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_util_code_method_channel.dart';

abstract class FlutterUtilCodePlatform extends PlatformInterface {
  /// Constructs a FlutterUtilCodePlatform.
  FlutterUtilCodePlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterUtilCodePlatform _instance = MethodChannelFlutterUtilCode();

  /// The default instance of [FlutterUtilCodePlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterUtilCode].
  static FlutterUtilCodePlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterUtilCodePlatform] when
  /// they register themselves.
  static set instance(FlutterUtilCodePlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

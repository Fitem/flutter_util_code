
import 'flutter_util_code_platform_interface.dart';

class FlutterUtilCode {
  Future<String?> getPlatformVersion() {
    return FlutterUtilCodePlatform.instance.getPlatformVersion();
  }
}

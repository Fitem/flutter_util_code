#ifndef FLUTTER_PLUGIN_FLUTTER_UTIL_CODE_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_UTIL_CODE_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_util_code {

class FlutterUtilCodePlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterUtilCodePlugin();

  virtual ~FlutterUtilCodePlugin();

  // Disallow copy and assign.
  FlutterUtilCodePlugin(const FlutterUtilCodePlugin&) = delete;
  FlutterUtilCodePlugin& operator=(const FlutterUtilCodePlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_util_code

#endif  // FLUTTER_PLUGIN_FLUTTER_UTIL_CODE_PLUGIN_H_

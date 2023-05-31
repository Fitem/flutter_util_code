#include "include/flutter_util_code/flutter_util_code_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_util_code_plugin.h"

void FlutterUtilCodePluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_util_code::FlutterUtilCodePlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}

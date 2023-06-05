import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_util_code/constants/sp_constants.dart';
import 'package:flutter_util_code/utils.dart';

///  Name: 设备工具类
///  基于 [device_info_plus](https://pub.dev/packages/device_info_plus)
///  目前仅支持 iOS 和 Android，其他平台返回空字符串
///  Created by Fitem on 2023/6/2
class DeviceUtils {
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  static Map<String, dynamic>? _deviceData;
  static const _androidIdPlugin = AndroidId();
  static String? _deviceId;

  /// 获取唯一设备 ID
  /// 若没有从设备获取到，则生成一个 UUID 作为设备 ID
  static Future<String> getDeviceId() async {
    // 如果已经获取过设备ID，则直接返回
    if (_deviceId != null && _deviceId!.isNotEmpty) {
      return _deviceId!;
    }
    // 从本地获取设备ID
    String? deviceId = await SharedPrefsUtil.getString(SPConstants.deviceId);
    if (deviceId != null && deviceId.isNotEmpty) {
      _deviceId = deviceId;
      return _deviceId!;
    }
    // 获取设备ID
    Map<String, dynamic> deviceData = await getDeviceData();
    if (kIsWeb) {
      _deviceId = '';
    } else {
      _deviceId = switch (defaultTargetPlatform) {
        TargetPlatform.android => await _getAndroidId(),
        TargetPlatform.iOS => deviceData['identifierForVendor'],
        TargetPlatform.linux => '',
        TargetPlatform.windows => '',
        TargetPlatform.macOS => '',
        TargetPlatform.fuchsia => '',
      };
    }
    // 如果获取不到，则生成一个UUID
    _deviceId = _getUniqueDeviceId(_deviceId);
    // 保存到本地
    SharedPrefsUtil.putString(SPConstants.deviceId, _deviceId!);
    return _deviceId!;
  }

  /// 获取设备型号
  static Future<String> getModel() async {
    Map<String, dynamic> deviceData = await getDeviceData();
    return deviceData['model'] ?? '';
  }

  /// 获取设备系统版本号
  static Future<String> getSystemVersion() async {
    Map<String, dynamic> deviceData = await getDeviceData();
    if (kIsWeb) {
      return '';
    } else {
      return switch (defaultTargetPlatform) {
        TargetPlatform.android => '${deviceData['version.sdkInt']}',
        TargetPlatform.iOS => '${deviceData['systemVersion']}',
        TargetPlatform.linux => '',
        TargetPlatform.windows => '',
        TargetPlatform.macOS => '',
        TargetPlatform.fuchsia => '',
      };
    }
  }

  /// 获取设备系统名称
  static Future<String> getSystemName() async {
    Map<String, dynamic> deviceData = await getDeviceData();
    if (kIsWeb) {
      return deviceData['browserName'];
    } else {
      return switch (defaultTargetPlatform) {
        TargetPlatform.android => deviceData['display'],
        TargetPlatform.iOS => deviceData['systemName'],
        TargetPlatform.linux => '',
        TargetPlatform.windows => '',
        TargetPlatform.macOS => '',
        TargetPlatform.fuchsia => '',
      };
    }
  }

  /// 设备品牌
  static Future<String> getBrand() async {
    Map<String, dynamic> deviceData = await getDeviceData();
    if (kIsWeb) {
      return '';
    } else {
      return switch (defaultTargetPlatform) {
        TargetPlatform.android => deviceData['brand'],
        TargetPlatform.iOS => deviceData['name'],
        TargetPlatform.linux => '',
        TargetPlatform.windows => '',
        TargetPlatform.macOS => '',
        TargetPlatform.fuchsia => '',
      };
    }
  }

  /// 获取 AndroidId
  static Future<String?> _getAndroidId() async {
    String? androidId = await _androidIdPlugin.getId();
    if ("9774d56d682e549c" == androidId) return null;
    // 根据 AndroidId 生成 UUID
    if (androidId != null && androidId.isNotEmpty) {
      return UuidUtils.getUuidV5(androidId);
    }
    return null;
  }

  /// 获取 设备唯一 ID
  static String _getUniqueDeviceId(String? deviceId) {
    if (deviceId == null || deviceId.isEmpty) {
      return UuidUtils.getUuid();
    } else {
      return deviceId;
    }
  }

  /// 获取设备信息
  static Future<Map<String, dynamic>> getDeviceData() async {
    if (_deviceData != null) {
      return _deviceData!;
    }
    if (kIsWeb) {
      _deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
    } else {
      _deviceData = switch (defaultTargetPlatform) {
        TargetPlatform.android => _readAndroidDeviceInfo(await deviceInfoPlugin.androidInfo),
        TargetPlatform.iOS => _readIosDeviceInfo(await deviceInfoPlugin.iosInfo),
        TargetPlatform.linux => _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo),
        TargetPlatform.windows => _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo),
        TargetPlatform.macOS => _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo),
        TargetPlatform.fuchsia => <String, dynamic>{'Error:': 'Fuchsia platform isn\'t supported'},
      };
    }
    return _deviceData!;
  }

  static Map<String, dynamic> _readAndroidDeviceInfo(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches': ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
      'serialNumber': build.serialNumber,
    };
  }

  static Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  static Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'version': data.version,
      'id': data.id,
      'idLike': data.idLike,
      'versionCodename': data.versionCodename,
      'versionId': data.versionId,
      'prettyName': data.prettyName,
      'buildId': data.buildId,
      'variant': data.variant,
      'variantId': data.variantId,
      'machineId': data.machineId,
    };
  }

  static Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
    return <String, dynamic>{
      'browserName': describeEnum(data.browserName),
      'appCodeName': data.appCodeName,
      'appName': data.appName,
      'appVersion': data.appVersion,
      'deviceMemory': data.deviceMemory,
      'language': data.language,
      'languages': data.languages,
      'platform': data.platform,
      'product': data.product,
      'productSub': data.productSub,
      'userAgent': data.userAgent,
      'vendor': data.vendor,
      'vendorSub': data.vendorSub,
      'hardwareConcurrency': data.hardwareConcurrency,
      'maxTouchPoints': data.maxTouchPoints,
    };
  }

  static Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return <String, dynamic>{
      'computerName': data.computerName,
      'hostName': data.hostName,
      'arch': data.arch,
      'model': data.model,
      'kernelVersion': data.kernelVersion,
      'majorVersion': data.majorVersion,
      'minorVersion': data.minorVersion,
      'patchVersion': data.patchVersion,
      'osRelease': data.osRelease,
      'activeCPUs': data.activeCPUs,
      'memorySize': data.memorySize,
      'cpuFrequency': data.cpuFrequency,
      'systemGUID': data.systemGUID,
    };
  }

  static Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return <String, dynamic>{
      'numberOfCores': data.numberOfCores,
      'computerName': data.computerName,
      'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
      'userName': data.userName,
      'majorVersion': data.majorVersion,
      'minorVersion': data.minorVersion,
      'buildNumber': data.buildNumber,
      'platformId': data.platformId,
      'csdVersion': data.csdVersion,
      'servicePackMajor': data.servicePackMajor,
      'servicePackMinor': data.servicePackMinor,
      'suitMask': data.suitMask,
      'productType': data.productType,
      'reserved': data.reserved,
      'buildLab': data.buildLab,
      'buildLabEx': data.buildLabEx,
      'digitalProductId': data.digitalProductId,
      'displayVersion': data.displayVersion,
      'editionId': data.editionId,
      'installDate': data.installDate,
      'productId': data.productId,
      'productName': data.productName,
      'registeredOwner': data.registeredOwner,
      'releaseId': data.releaseId,
      'deviceId': data.deviceId,
    };
  }
}

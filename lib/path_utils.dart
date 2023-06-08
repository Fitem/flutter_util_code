import 'dart:io';
import 'package:path_provider/path_provider.dart';

///  Name: Path工具类
///  Created by Fitem on 2023/6/8
class PathUtils {
  /// App缓存路径
  /// - `NSCachesDirectory` on iOS and macOS.
  /// - `Context.getCacheDir` on Android.
  static Future<String> getAppCachePath() async {
    Directory directory = await getTemporaryDirectory();
    String path = directory.path;
    return path;
  }

  /// App支持的存储路径
  /// - `NSApplicationSupportDirectory` on iOS and macOS.
  /// - The Flutter engine's `PathUtils.getFilesDir` API on Android.
  static Future<String> getAppSupportPath() async {
    Directory directory = await getApplicationSupportDirectory();
    return directory.path;
  }

  /// App文档路径
  /// - `NSDocumentDirectory` on iOS and macOS.
  /// - The Flutter engine's `PathUtils.getDataDirectory` API on Android.
  static Future<String> getAppDocPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// 系统下载文件所在目录的路径
  static Future<String> getDownloadPath() async {
    Directory? directory = await getDownloadsDirectory();
    return directory?.path ?? '';
  }

  /// Android外部存储路径
  /// - `getExternalFilesDir(null)` on Android.
  static Future<String> getAndroidStoragePath() async {
    Directory? directory = await getExternalStorageDirectory();
    return directory?.path ?? '';
  }

  /// Android外部存储缓存的所有路径
  /// - Context.getExternalCacheDirs() on Android (or
  ///   Context.getExternalCacheDir() on API levels below 19).
  static Future<List<String>> getAndroidExternalCachePaths() async {
    List<Directory>? list = await getExternalCacheDirectories();
    return list?.map((d) => d.path).toList() ?? [];
  }

  /// Android外部存储-特定类型文件的路径
  static Future<List<String>> getAppExternalStoragePaths({StorageDirectoryType? type}) async {
    List<Directory>? list = await getExternalStorageDirectories(type: _transformDirectoryType(type));
    return list?.map((d) => d.path).toList() ?? [];
  }

  /// 获取Android外部存储-图片类型文件的路径
  static Future<List<String>> getAndroidPicturePaths() async =>
      await getAppExternalStoragePaths(type: StorageDirectoryType.pictures);

  /// 获取Android外部存储-视频类型文件的路径
  static Future<List<String>> getAndroidMoviePaths() async =>
      await getAppExternalStoragePaths(type: StorageDirectoryType.movies);

  /// 获取AndroidApp外部存储-音频类型文件的路径
  static Future<List<String>> getAndroidMusicPaths() async =>
      await getAppExternalStoragePaths(type: StorageDirectoryType.music);

  /// 获取Android外部存储-相机目录下的文件的路径
  static Future<List<String>> getAndroidDCIMPaths() async =>
      await getAppExternalStoragePaths(type: StorageDirectoryType.dcim);

  /// 获取Android外部存储-下载类型文件的路径
  static Future<List<String>> getAndroidDownloadPaths() async =>
      await getAppExternalStoragePaths(type: StorageDirectoryType.downloads);

  /// 获取Android外部存储-文档类型文件的路径
  static Future<List<String>> getAndroidDocumentPaths() async =>
      await getAppExternalStoragePaths(type: StorageDirectoryType.documents);

  /// 转化为StorageDirectory
  static StorageDirectory? _transformDirectoryType(StorageDirectoryType? type) {
    switch (type) {
      case StorageDirectoryType.music:
        return StorageDirectory.music;
      case StorageDirectoryType.podcasts:
        return StorageDirectory.podcasts;
      case StorageDirectoryType.ringtones:
        return StorageDirectory.ringtones;
      case StorageDirectoryType.alarms:
        return StorageDirectory.alarms;
      case StorageDirectoryType.notifications:
        return StorageDirectory.notifications;
      case StorageDirectoryType.pictures:
        return StorageDirectory.pictures;
      case StorageDirectoryType.movies:
        return StorageDirectory.movies;
      case StorageDirectoryType.downloads:
        return StorageDirectory.downloads;
      case StorageDirectoryType.dcim:
        return StorageDirectory.dcim;
      case StorageDirectoryType.documents:
        return StorageDirectory.documents;
      default:
        return null;
    }
  }
}

enum StorageDirectoryType {
  /// 音乐
  /// See https://developer.android.com/reference/android/os/Environment.html#DIRECTORY_MUSIC.
  music,

  /// podcasts 的音频文件
  /// See https://developer.android.com/reference/android/os/Environment.html#DIRECTORY_PODCASTS.
  podcasts,

  /// 手机铃声
  /// See https://developer.android.com/reference/android/os/Environment.html#DIRECTORY_RINGTONES.
  ringtones,

  /// 闹钟铃声
  /// See https://developer.android.com/reference/android/os/Environment.html#DIRECTORY_ALARMS.
  alarms,

  /// 通知铃声
  /// See https://developer.android.com/reference/android/os/Environment.html#DIRECTORY_NOTIFICATIONS.
  notifications,

  /// 图片
  /// See https://developer.android.com/reference/android/os/Environment.html#DIRECTORY_PICTURES.
  pictures,

  /// 视频
  /// See https://developer.android.com/reference/android/os/Environment.html#DIRECTORY_MOVIES.
  movies,

  /// 下载
  /// See https://developer.android.com/reference/android/os/Environment.html#DIRECTORY_DOWNLOADS.
  downloads,

  /// 当设备文件系统被视为相机文件系统时，用于同时保存图片和视频。
  /// See https://developer.android.com/reference/android/os/Environment.html#DIRECTORY_DCIM.
  dcim,

  /// 文档
  /// See https://developer.android.com/reference/android/os/Environment.html#DIRECTORY_DOCUMENTS.
  documents,
}

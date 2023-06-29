import 'dart:typed_data';

import 'package:share_plus/share_plus.dart';

///  Name: 分享工具类
///  基于 [share_plus](https://pub.dev/packages/share_plus)
///  Created by Fitem on 2023/6/28
class ShareUtils {
  /// 分享文本
  /// [text]分享内容
  /// [subject]分享主题
  static Future<bool> shareText(
    String text, {
    String? subject,
  }) async {
    ShareResult result = await Share.shareWithResult(text, subject: subject);
    return result.status == ShareResultStatus.success;
  }

  /// 分享图片
  /// [path] 与 [bytes] + [mineType] 二选一，不符合则抛出 [FormatException] 异常
  /// [name]图片名称
  /// [path]图片路径
  /// [bytes]图片字节
  /// [mineType]图片类型
  /// [text]分享内容
  /// [subject]分享主题
  static Future<bool> shareImage({
    String? name,
    String? path,
    Uint8List? bytes,
    String? mineType,
    String? text,
    String? subject,
  }) async {
    XFile file = _createFile(name, path, bytes, mineType);
    final files = <XFile>[file];
    ShareResult result = await Share.shareXFiles(files, text: text, subject: subject);
    return result.status == ShareResultStatus.success;
  }

  /// 分享多张图片
  /// [images]图片列表
  /// [text]分享内容
  /// [subject]分享主题
  static Future<bool> shareImages(
    List<ShareFile> images, {
    String? text,
    String? subject,
  }) async {
    final files = <XFile>[];
    for (var i = 0; i < images.length; i++) {
      files.add(_createFile(images[i].name, images[i].path, images[i].bytes, images[i].mineType));
    }
    ShareResult result = await Share.shareXFiles(files, text: text, subject: subject);
    return result.status == ShareResultStatus.success;
  }

  /// 分享文件
  /// [path] 与 [bytes] + [mineType] 二选一，不符合则抛出 [FormatException] 异常
  /// [name]文件名称
  /// [path]文件路径
  /// [bytes]文件字节
  /// [mineType]文件类型
  /// [mineType]文件类型
  static Future<bool> shareFile({
    String? name,
    String? path,
    Uint8List? bytes,
    String? mineType,
    String? text,
    String? subject,
  }) async {
    XFile file = _createFile(name, path, bytes, mineType);
    final files = <XFile>[file];
    ShareResult result = await Share.shareXFiles(files, text: text, subject: subject);
    return result.status == ShareResultStatus.success;
  }

  /// 分享多个文件
  /// [shareFiles]文件列表
  /// [name]文件名称
  /// [mineType]文件类型
  static Future<bool> shareFiles(
    List<ShareFile> shareFiles, {
    String? text,
    String? subject,
  }) async {
    final files = <XFile>[];
    for (var i = 0; i < shareFiles.length; i++) {
      files.add(_createFile(shareFiles[i].name, shareFiles[i].path, shareFiles[i].bytes, shareFiles[i].mineType));
    }
    ShareResult result = await Share.shareXFiles(files, text: text, subject: subject);
    return result.status == ShareResultStatus.success;
  }

  /// 创建XFile文件
  /// [path] 与 [bytes] + [mineType] 二选一，不符合则抛出 [FormatException] 异常
  /// [name]文件名称
  /// [path]文件路径
  /// [bytes]文件字节
  /// [mineType]文件类型
  static XFile _createFile(String? name, String? path, Uint8List? bytes, String? mineType) {
    if (path != null) {
      return XFile(path, name: name);
    } else if (bytes != null) {
      if (mineType != null) {
        return XFile.fromData(bytes, name: name, mimeType: mineType);
      } else {
        throw const FormatException('mineType must be not null');
      }
    } else {
      throw const FormatException('path or bytes must be not null');
    }
  }
}

/// 分享文件对象
class ShareFile {
  String? path; // 文件路径
  Uint8List? bytes; // 文件bytes
  String? mineType; // 文件类型
  String? name; // 文件名称

  ShareFile({
    this.path,
    this.bytes,
    this.mineType,
    this.name,
  });
}

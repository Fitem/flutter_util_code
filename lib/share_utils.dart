import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_util_code/utils.dart';
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
  /// [path] 与 [bytes] 二选一，不符合则抛出 [FormatException] 异常
  /// [name]图片名称
  /// [path]图片路径
  /// [bytes]图片字节
  /// [text]分享内容
  /// [subject]分享主题
  static Future<bool> shareImage({
    required String name,
    String? path,
    Uint8List? bytes,
    String? text,
    String? subject,
  }) async {
    XFile file = await _createFile(name, path, bytes);
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
      files.add(await _createFile(images[i].name, images[i].path, images[i].bytes));
    }
    ShareResult result = await Share.shareXFiles(files, text: text, subject: subject);
    return result.status == ShareResultStatus.success;
  }

  /// 分享文件
  /// [path] 与 [bytes] 二选一，不符合则抛出 [FormatException] 异常
  /// [name]文件名称
  /// [path]文件路径
  /// [bytes]文件字节
  /// [text]分享内容
  /// [subject]分享主题
  static Future<bool> shareFile({
    required String name,
    String? path,
    Uint8List? bytes,
    String? text,
    String? subject,
  }) async {
    XFile file = await _createFile(name, path, bytes);
    final files = <XFile>[file];
    ShareResult result = await Share.shareXFiles(files, text: text, subject: subject);
    return result.status == ShareResultStatus.success;
  }

  /// 分享多个文件
  /// [files]文件列表
  /// [text]分享内容
  /// [subject]分享主题
  static Future<bool> shareFiles(
    List<ShareFile> files, {
    String? text,
    String? subject,
  }) async {
    final list = <XFile>[];
    for (var i = 0; i < files.length; i++) {
      list.add(await _createFile(files[i].name, files[i].path, files[i].bytes));
    }
    ShareResult result = await Share.shareXFiles(list, text: text, subject: subject);
    return result.status == ShareResultStatus.success;
  }

  /// 创建XFile文件
  /// [path] 与 [bytes] 二选一，不符合则抛出 [FormatException] 异常
  /// [name]文件名称
  /// [path]文件路径
  /// [bytes]文件字节
  static Future<XFile> _createFile(String name, String? path, Uint8List? bytes) async {
    if (path != null) {
      return XFile(path, name: name);
    } else if (bytes != null) {
      // 获取缓存目录
      final String tempFilePath = await PathUtils.getAppCachePath();
      final String path = '$tempFilePath/$name';
      // 写入文件
      final file = File(path);
      await file.writeAsBytes(bytes);
      // 根据文件路径创建XFile
      return XFile(path, name: name);
    } else {
      throw const FormatException('path or bytes must be not null');
    }
  }
}

/// 分享文件对象
class ShareFile {
  String name; // 文件名称
  String? path; // 文件路径
  Uint8List? bytes; // 文件bytes

  ShareFile({
    required this.name,
    this.path,
    this.bytes,
  });
}

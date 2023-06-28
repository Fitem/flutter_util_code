import 'package:share_plus/share_plus.dart';

///  Name: 分享工具类
///  基于 [share_plus](https://pub.dev/packages/share_plus)
///  Created by Fitem on 2023/6/28
class ShareUtil {
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
  /// [images]图片路径
  /// [text]分享内容
  /// [subject]分享主题
  static Future<bool> shareImage(
    List<ShareFile> images, {
    String? text,
    String? subject,
  }) async {
    final files = <XFile>[];
    for (var i = 0; i < images.length; i++) {
      files.add(XFile(images[i].path, name: images[i].name));
    }
    ShareResult result = await Share.shareXFiles(files, text: text, subject: subject);
    return result.status == ShareResultStatus.success;
  }

  /// 分享文件
  /// [path]文件路径
  /// [name]文件名称
  /// [mineType]文件类型
  static Future<bool> shareFiles(
    List<ShareFile> shareFiles, {
    String? text,
    String? subject,
  }) async {
    final files = <XFile>[];
    for (var i = 0; i < shareFiles.length; i++) {
      files.add(XFile(shareFiles[i].path, name: shareFiles[i].name));
    }
    ShareResult result = await Share.shareXFiles(files, text: text, subject: subject);
    return result.status == ShareResultStatus.success;
  }
}

/// 分享文件对象
class ShareFile {
  String path;
  String? name;

  ShareFile({
    required this.path,
    this.name,
  });
}

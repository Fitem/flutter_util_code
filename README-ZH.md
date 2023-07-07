# flutter_util_code

[![Pub](https://img.shields.io/pub/v/flutter_util_code.svg)](https://pub.dev/packages/flutter_util_code)

一个 Flutter 工具类集合插件，封装了常用的工具类，方便开发者调用。

Language: [English](README.md) | 简体中文

### FlutterUtilCode 的引入

在 pubspec.yaml 中添加依赖：

~~~yaml
dependencies：
  flutter_util_code: ^latest_version
~~~

### 支持环境
- sdk: ">=2.18.0 <4.0.0"
- flutter: ">=3.3.0"

### APIs

- 日志相关 ->  [LogUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/log_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/log_page.dart)

~~~
isOpenLog : 是否开启日志，默认Debug模式下开启
println   : 打印日志
logger    : 用于网络请求等长内容日志
~~~

- SharedPreference -> [SharedPresUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/shared_preference_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/shared_prefs/shared_prefs_page.dart)

~~~
putString     : 添加String类型数据
putInt        : 添加int类型数据
putBool       : 添加bool类型数据
putDouble     : 添加double类型数据
putStringList :	添加List<String>类型数据
getString     : 获取String类型数据
getInt        : 获取int类型数据，如果没有则返回默认值
getDouble     : 获取double类型数据，如果没有则返回默认值
getBool       : 获取bool类型数据，如果没有则返回默认值
getStringList : 获取List<String>类型数据，如果没有则返回默认值
~~~

- 吐司相关 -> [ToastUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/toast_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/toast_page.dart)

~~~
init			 : 初始化Toast
showCenter : 显示中间的Toast
show			 : 显示底部的Toast
showToast	 : 显示Toast支持属性FToastGravity、FToast
~~~

- UUID相关 -> [UuidUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/uuid_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/uuid_page.dart)

~~~
getUuid		: 获取uuid（v1 + v4 通过 getUuidV5 生成的uuid）
getUuidV1	: 获取uuid v1
getUuidV4	:	获取uuid v4
getUuidV5	: 获取uuid v5
~~~

- 设备相关 -> [DeviceUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/device_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/device_page.dart)

~~~
getDeviceId			 : 获取唯一设备ID
getModel				 : 获取设备型号
getSystemVersion : 获取操作系统版本号
getSystemName		 : 获取设备系统名称
getBrand				 : 设备品牌
~~~

- App应用相关 -> [AppUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/app_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/app_page.dart)

~~~
getAppName		 	  : App名称
getPackageName 	  : 包名称
getVersionName    : 版本名称
getVersionNumber  : 版本号
getBuildSignature : 获取App构建签名
getInstallerStore : 获取App安装商店
~~~

- 文件路径相关 -> [PathUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/path_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/path_page.dart)

~~~
getAppCachePath       			 : App缓存路径
getAppSupportPath     			 : App支持的存储路径
getAppDocPath         			 : App文档路径
getDownloadPath       		 	 : 应用程序的下载目录路径，仅在 iOS/macOS 上支持
getAndroidStoragePath        : Android外部存储路径
getAndroidExternalCachePaths : Android外部存储缓存的所有路径
getAppExternalStoragePaths   : Android外部存储-特定类型文件的路径
getAndroidPicturePaths 			 : 获取Android外部存储-图片类型文件的路径
getAndroidMoviePaths 				 : 获取Android外部存储-视频类型文件的路径
getAndroidMusicPaths 				 : 获取Android外部存储-音频类型文件的路径
getAndroidDCIMPaths     		 : 获取Android外部存储-相机目录下的文件的路径
getAndroidDownloadPaths 		 : 获取Android外部存储-下载类型文件的路径
getAndroidDocumentPaths 		 : 获取Android外部存储-文档类型文件的路径
~~~

- 加密相关 -> [EncryptUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/encrypt_utils.dart) -> [Test](https://github.com/Fitem/flutter_util_code/blob/master/test/encrypt_test.dart)

~~~
md5Encrypt 					: MD5加密
rc4Encrypt 					: RC4加密
rc4Decrypt 					: RC4解密
aesEncrypt 					: AES加密
aesDecrypt 					: AES解密
rsaEncrypt 					: RSA加密
rsaDecrypt 					: RSA解密
sha256withRSASign 	: SHA256withRSA签名，秘钥格式为[pkcs8]
sha256withRSAVerify : SHA256withRSA验签，秘钥格式为[pkcs8]
md5withRSASign 			: MD5withRSA签名，秘钥格式为[pkcs8]
md5withRSAVerify 		: MD5withRSA验签，秘钥格式为[pkcs8]
~~~

- URL跳转相关 -> [UrlLauncherUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/url_launcher_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/url_launcher_page.dart)

~~~
launchInBrowser 		: 浏览器打开url
launchInNonBrowser  : 非浏览器第三方应用打开url
launchInApp 				: WebView打开url
onCloseInAppWebView : 关闭WebView
onCall 							: 打电话
sendSMS 						: 发短信
sendEmail 					: 发送邮件
openFile 						: 打开文件
onCanLaunchUrl 			: 是否支持该url打开
~~~

- 空安全相关 -> [NullSafetyUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/null_safety_utils.dart) -> [Test](https://github.com/Fitem/flutter_util_code/blob/master/test/null_safety_test.dart)

~~~
String空安全扩展
toNonNull 			 : 转化为非空字符串，如果为空则返回''
isNullOrEmpty 	 : 判断字符串是否为空
isNotNullOrEmpty : 判断字符串是否不为空
toNonNullString  :  判断字符串是否为空，如果为空则返回默认值
~~~

~~~
int空安全扩展
toNonNull 	 : 转化为非空整型，如果为空则返回0
isNull 			 : 判断是否为空
isNotNull 	 : 判断是否不为空
toNonNullInt : 判断是否为null，如果为null则返回默认值
~~~

~~~
double空安全扩展
toNonNull 			: 转化为非空浮点型，如果为空则返回0.0
isNull 				 	: 判断是否为空
isNotNull       : 判断是否不为空
toNonNullDouble : 判断是否为null，如果为null则返回默认值
~~~

~~~
bool空安全扩展
toNonNull			: 转化为非空布尔型，如果为空则返回false
isNull 				: 判断是否为空
isNotNull 		: 判断是否不为空
toNonNullBool : 判断是否为null，如果为null则返回默认值
~~~

~~~
List空安全扩展
toNonNull 			 : 转化为非空数组，如果为空则返回[]
isNullOrEmpty 	 : 判断是否为空
isNotNullOrEmpty : 判断是否不为空
toNonNullList 	 : 判断是否为空，如果为空则返回默认值[]
~~~

- 分享相关 -> [ShareUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/share_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/share_page.dart)

~~~
shareText 	: 分享文本
shareImage  : 分享图片
shareImages : 分享多张图片
shareFile 	: 分享文件
shareFiles 	: 分享多个文件
~~~

- 网络状态相关 -> [NetworkUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/connectivity_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/connectivity_page.dart)

~~~
getInstance 			: 获取单例
checkConnectivity : 检查当前网络状态
listen 						: 监听网络状态
off 							: 取消订阅
dispose 					: 取消网络监听
~~~

- 权限相关 -> [PermissionUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/permission_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/permission_page.dart)

~~~
getPermissionStatus : 获取权限状态
requestPermission  	: 请求单个权限
requestPermissions 	: 请求多个权限
~~~
### 工具类整理（后续持续更新中...）
- [x] [LogUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/log_utils.dart)  : 日志工具类
- [x] [SharedPresUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/shared_preference_utils.dart) : SharedPreferences工具类
- [x] [ToastUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/toast_utils.dart) :Toast工具类
- [x] [UuidUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/uuid_utils.dart) : UUID工具类
- [x] [DeviceUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/device_utils.dart) : 设备工具类
- [x] [AppUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/app_utils.dart) : App工具类
- [x] [PathUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/path_utils.dart) : Path工具类
- [x] [EncryptUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/encrypt_utils.dart) : 加密工具类
- [x] [UrlLauncherUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/url_launcher_utils.dart) : URL跳转工具类
- [x] [NullSafetyUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/null_safety_utils.dart) : 空安全工具类
- [x] [ShareUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/share_utils.dart) : 分享工具类
- [x] [ConnectivityUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/connectivity_utils.dart) : 网络监听工具类
- [x] [PermissionUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/permission_utils.dart) : 权限工具类
- [ ] FormatUtils : 数字解析工具类
- [ ] LocationUtils : 定位工具类

### 相关文章

掘金专栏 : [Flutter工具类库整理专栏](https://juejin.cn/column/7239585610863296571)


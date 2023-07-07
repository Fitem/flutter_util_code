# flutter_util_code

[![Pub](https://img.shields.io/pub/v/flutter_util_code.svg)](https://pub.dev/packages/flutter_util_code)

A Flutter utility class collection library that includes some commonly used functions and encapsulated system API calls to improve development efficiency.

Language: English | [简体中文](README-ZH.md)

## NativeBridge dependency

Add dependencies in pubspec.yaml:

~~~yaml
dependencies：
  flutter_util_code: ^latest_version
~~~

### Support Environment
- sdk: ">=2.18.0 <4.0.0"
- flutter: ">=3.3.0"

## APIs

- **About Log ->  [LogUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/log_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/log_page.dart)**

~~~
isOpenLog 
println   
logger 		
~~~

- **About SharedPreference -> [SharedPresUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/shared_preference_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/shared_prefs/shared_prefs_page.dart)**

~~~
putString 		
putInt				
putBool				
putDouble			
putStringList	
getString			
getInt				
getDouble			
getBool				
getStringList	
~~~

- **About Toast -> [ToastUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/toast_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/toast_page.dart)**

~~~
init			 
showCenter 
show			 
showToast	 
~~~

- **About UUID -> [UuidUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/uuid_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/uuid_page.dart)**

~~~
getUuid		
getUuidV1	
getUuidV4	
getUuidV5	
~~~

- **About Device -> [DeviceUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/device_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/device_page.dart)**

~~~
getDeviceId			 
getModel				 
getSystemVersion 
getSystemName		 
getBrand				 
~~~

- **About App -> [AppUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/app_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/app_page.dart)**

~~~
getAppName		 	  
getPackageName 	  
getVersionName    
getVersionNumber  
getBuildSignature 
getInstallerStore 
~~~

- **About File Path -> [PathUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/path_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/path_page.dart)**

~~~
getAppCachePath       			 
getAppSupportPath     			 
getAppDocPath         			 
getDownloadPath       		 	 
getAndroidStoragePath        
getAndroidExternalCachePaths 
getAppExternalStoragePaths   
getAndroidPicturePaths 			 
getAndroidMoviePaths 				 
getAndroidMusicPaths 				 
getAndroidDCIMPaths     		 
getAndroidDownloadPaths 		 
getAndroidDocumentPaths 		 
~~~

- **About Encrypt -> [EncryptUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/encrypt_utils.dart) -> [Test](https://github.com/Fitem/flutter_util_code/blob/master/test/encrypt_test.dart)**

~~~
md5Encrypt 					
rc4Encrypt 					
rc4Decrypt 					
aesEncrypt 					
aesDecrypt 					
rsaEncrypt 					
rsaDecrypt 					
sha256withRSASign 	
sha256withRSAVerify 
md5withRSASign 			
md5withRSAVerify 		
~~~

- **About URL Launcher -> [UrlLauncherUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/url_launcher_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/url_launcher_page.dart)**

~~~
launchInBrowser 		
launchInNonBrowser  
launchInApp 				
onCloseInAppWebView 
onCall 							
sendSMS 						
sendEmail 					
openFile 						
onCanLaunchUrl 			
~~~

- **About Null Safe -> [NullSafetyUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/null_safety_utils.dart) -> [Test](https://github.com/Fitem/flutter_util_code/blob/master/test/null_safety_test.dart)**

~~~
String
toNonNull 			 
isNullOrEmpty 	 
isNotNullOrEmpty 
toNonNullString  
~~~

~~~
int
toNonNull 	 
isNull 			 
isNotNull 	 
toNonNullInt 
~~~

~~~
double
toNonNull 			
isNull 				 	
isNotNull       
toNonNullDouble 
~~~

~~~
bool
toNonNull			
isNull 				
isNotNull 		
toNonNullBool 
~~~

~~~
List
toNonNull 			 
isNullOrEmpty 	 
isNotNullOrEmpty 
toNonNullList 	 
~~~

- **About Share -> [ShareUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/share_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/share_page.dart)**

~~~
shareText 	
shareImage  
shareImages 
shareFile 	
shareFiles 	
~~~

- **About Network -> [NetworkUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/connectivity_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/connectivity_page.dart)**

~~~
getInstance 			
checkConnectivity 
listen 						
off 							
dispose 					
~~~

- **About Permission -> [PermissionUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/permission_utils.dart) -> [Demo](https://github.com/Fitem/flutter_util_code/blob/master/example/lib/function/permission_page.dart)**

~~~
getPermissionStatus 
requestPermission  	
requestPermissions 	
~~~

## Utils（Continue to update later...）
- [x] [LogUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/log_utils.dart) : Logging utility class
- [x] [SharedPresUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/shared_preference_utils.dart) : SharedPreferences utility class
- [x] [ToastUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/toast_utils.dart) : Toast utility class
- [x] [UuidUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/uuid_utils.dart) : UUID utility class
- [x] [DeviceUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/device_utils.dart) : Device utility class
- [x] [AppUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/app_utils.dart) : App utility class
- [x] [PathUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/path_utils.dart) : Path utility class
- [x] [EncryptUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/encrypt_utils.dart) : Encryption utility class
- [x] [UrlLauncherUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/url_launcher_utils.dart) : URL jump utility class
- [x] [NullSafetyUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/null_safety_utils.dart) : Null safety utility class
- [x] [ShareUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/share_utils.dart) : Share utility class
- [x] [ConnectivityUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/connectivity_utils.dart) : Network monitoring utility class
- [x] [PermissionUtils](https://github.com/Fitem/flutter_util_code/blob/master/lib/permission_utils.dart) : Permission utility class
- [ ] FormatUtils : Num format utility class
- [ ] LocationUtils：Location utility class
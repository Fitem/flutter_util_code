import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'router/router.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // 强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      onGenerateTitle: (context) => 'FlutterUtilCode',
      initialRoute: RouterName.home,
      getPages: RouterPage.pages,
    );
  }
}

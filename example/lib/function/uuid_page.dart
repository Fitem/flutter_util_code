import 'package:flutter/material.dart';
import 'package:flutter_util_code/utils.dart';
import 'package:flutter_util_code_example/widget/display_screen.dart';

///  Name: UUID工具页
///  Created by Fitem on 2023/6/5
class UuidPage extends StatefulWidget {
  const UuidPage({Key? key}) : super(key: key);

  @override
  UuidPageState createState() => UuidPageState();
}

class UuidPageState<UuidPage> extends State {

  final GlobalKey<DisplayScreenState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UUID工具类'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ElevatedButton(onPressed: ()=> addContent('uuid: ${UuidUtils.getUuid()}'), child: const Text('UuidUtils.getUuid()')),
            ElevatedButton(onPressed: ()=> addContent('uuidV1: ${UuidUtils.getUuidV1()}'), child: const Text('UuidUtils.getUuidV1()')),
            ElevatedButton(onPressed: ()=> addContent('uuidV4: ${UuidUtils.getUuidV4()}'), child: const Text('UuidUtils.getUuidV4()')),
            ElevatedButton(onPressed: ()=> addContent('uuidV5: ${UuidUtils.getUuidV5('uuid')}'), child: const Text('UuidUtils.getUuidV5()')),
            const Spacer(),
            Expanded(
              flex: 2,
              child: DisplayScreen(key: globalKey)
            ),
          ],
        ),
      ),
    );
  }

  /// 添加内容
  void addContent(String content) {
    globalKey.currentState?.addContent(content);
  }

}

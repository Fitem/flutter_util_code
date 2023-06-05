import 'package:flutter/material.dart';
import 'package:flutter_util_code/utils.dart';

///  Name: UUID工具页
///  Created by Fitem on 2023/6/5
class UuidPage extends StatefulWidget {
  const UuidPage({Key? key}) : super(key: key);

  @override
  UuidPageState createState() => UuidPageState();
}

class UuidPageState<UuidPage> extends State {
  String content = '';

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
            ElevatedButton(onPressed: _handleUuid, child: const Text('UuidUtils.getUuid()')),
            ElevatedButton(onPressed: _handleUuidV1, child: const Text('UuidUtils.getUuidV1()')),
            ElevatedButton(onPressed: _handleUuidV4, child: const Text('UuidUtils.getUuidV4()')),
            ElevatedButton(onPressed: _handleUuidV5, child: const Text('UuidUtils.getUuidV5()')),
            const Spacer(),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.grey[200],
                padding: const EdgeInsets.all(16),
                child: ListView(
                  children: [Text(content, style: const TextStyle(fontSize: 14, color: Colors.black54))],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleUuid() {
    setState(() {
      content += 'uuid: ${UuidUtils.getUuid()}\n';
    });
  }

  void _handleUuidV1() {
    setState(() {
      content += 'uuidV1: ${UuidUtils.getUuidV1()}\n';
    });
  }

  void _handleUuidV4() {
    setState(() {
      content += 'uuidV4: ${UuidUtils.getUuidV4()}\n';
    });
  }

  void _handleUuidV5() {
    setState(() {
      content += 'uuidV5: ${UuidUtils.getUuidV5('uuid')}\n';
    });
  }
}

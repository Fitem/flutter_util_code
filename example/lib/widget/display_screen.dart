import 'package:flutter/material.dart';

///  Name: 显示屏Widget
///  Created by Fitem on 2023/6/5
class DisplayScreen extends StatefulWidget{

  const DisplayScreen({Key? key}) : super(key: key);

  @override
  DisplayScreenState createState() => DisplayScreenState();
}

class DisplayScreenState extends State<DisplayScreen>{

  String content = '';
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [Text(content, style: const TextStyle(fontSize: 14, color: Colors.black54, height: 1.5))],
      ),
    );
  }

  void addContent(String str){
    setState(() {
      content += '$str\n';
    });
  }
}
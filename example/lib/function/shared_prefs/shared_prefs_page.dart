import 'package:flutter/material.dart';
import 'package:flutter_util_code/utils.dart';
import 'package:flutter_util_code_example/function/shared_prefs/sp_constants.dart';

///  Name: SharedPreferenceUtil 页面
///  Created by Fitem on 2023/5/31
class SharedPrefsPage extends StatefulWidget {
  const SharedPrefsPage({Key? key}) : super(key: key);

  @override
  SharedPrefsPageState createState() => SharedPrefsPageState();
}

class SharedPrefsPageState<SharedPreferencePage> extends State {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SharedPreference工具类'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ElevatedButton(onPressed: _handlePut, child: const Text('添加数据')),
            ElevatedButton(onPressed: _handleGet, child: const Text('获取数据')),
          ],
        ),
      ),
    );
  }

  /// 添加数据
  void _handlePut() {
    SharedPrefsUtil.putString(SPConstants.name, '小明');
    SharedPrefsUtil.putInt(SPConstants.age, 18);
    SharedPrefsUtil.putDouble(SPConstants.height, 175.5);
    SharedPrefsUtil.putBool(SPConstants.gender, true);
    SharedPrefsUtil.putStringList(SPConstants.family, ['爸爸', '妈妈', '哥哥', '弟弟']);
  }

  /// 获取数据
  Future<void> _handleGet() async {
    var name = await SharedPrefsUtil.getString(SPConstants.name, '');
    var age = await SharedPrefsUtil.getInt(SPConstants.age, 0);
    var height = await SharedPrefsUtil.getDouble(SPConstants.height, 0.0);
    var gender = await SharedPrefsUtil.getBool(SPConstants.gender, false);
    var family = await SharedPrefsUtil.getStringList(SPConstants.family, []);
  }
}

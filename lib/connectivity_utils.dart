import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

/// 订阅者回调网络状态
typedef ConnectivityResultCallBack = void Function(ConnectivityResult result);

///  Name: 网络监听工具类
///  基于 [基于connectivity_plus](https://pub.dev/packages/connectivity_plus)
///  Created by Fitem on 2023/7/2
class ConnectivityUtils {
  /// 保存单例，被标记为 late 的变量 _instance 的初始化操作将会延迟到字段首次被访问时执行，而不是在类加载时就初始化
  static final ConnectivityUtils _instance = ConnectivityUtils._internal();

  /// 网络监听相关类
  final Connectivity _connectivity = Connectivity();

  /// 当前网络状态，默认为无网络
  ConnectivityResult connectionStatus = ConnectivityResult.none;

  /// 网络监听订阅
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;

  /// 监听回调集合
  final List<ConnectivityResultCallBack> _callBackList = [];

  /// 私有构造函数
  ConnectivityUtils._internal() {
    _initConnectivity();
  }

  /// 获取单例方法
  static getInstance() => _instance;

  /// 初始化网络监听
  void _initConnectivity() {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((result) {
      if (connectionStatus != result) {
        connectionStatus = result;
        emit();
      }
    });
  }

  /// 获取当前网络状态
  Future<ConnectivityResult> checkConnectivity() async {
    ConnectivityResult result = await _connectivity.checkConnectivity();
    connectionStatus = result;
    return result;
  }

  /// 监听网络状态
  void listen(ConnectivityResultCallBack c) {
    _callBackList.add(c);
    // 如果网络监听订阅为空，则初始化网络监听
    if (_connectivitySubscription == null) {
      _initConnectivity();
    }
  }

  /// 取消订阅
  void off(ConnectivityResultCallBack? c) {
    if (c != null) {
      _callBackList.remove(c);
    }
  }

  /// 取消网络监听
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
    _callBackList.clear();
  }

  /// 发送通知
  void emit() {
    var len = _callBackList.length - 1;
    // 反向遍历，防止订阅者在回调中移除自身带来的下标错位
    for (var i = len; i > -1; --i) {
      _callBackList[i](connectionStatus);
    }
  }
}

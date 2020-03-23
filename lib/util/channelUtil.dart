/**
 * Flutter/(Android、iOS)通信方式 Channel
 * 1: BasicMessageChannel 实现二者双向通信
 * 2: MethodChannel 实现二者双向通信
 * 3: EventChannel 实现原生向Flutter发送消息，单向传递，无返回值
 */

import 'package:flutter/services.dart';
import 'dart:async';

const basicMessageChannel =
    const BasicMessageChannel('xxxxxx', StandardMessageCodec());

const methodChannel = const MethodChannel('xxxxxx');

const eventChannel = const EventChannel('xxxxxx');

Future<Map> toolsBasicChannelMethodWithParams(Map arguments) async {
  var result;

  try {
    result = await basicMessageChannel.send(arguments);
  } catch (e) {
    result = {'Failed': e.message};
  }

  return result;
}

Future<Map> toolsMethodChannelMethodWithParams(String methodName,
    [Map params]) async {
  var res;
  try {
    res = await methodChannel.invokeMethod('$methodName', params);
  } catch (e) {
    res = {'Failed': e.message};
  }
}

toolsEventChannelMethod(Function result) {
  eventChannel.receiveBroadcastStream().listen(result);
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

const MethodChannel _channel = MethodChannel('fl_baidu_mob_stat');

/// 设置 apiKey
Future<bool> setApiKeyWithMobStat(
    {required String androidKey, required String iosKey}) async {
  if (!_supportPlatform) return false;
  bool? state = false;
  String? key;
  if (_isAndroid) key = androidKey;
  if (_isIOS) key = iosKey;
  if (key != null) state = await _channel.invokeMethod<bool?>('setApiKey', key);
  return state ?? false;
}

/// 是否开启 debug
/// 默认 false
Future<bool> setDebugWithMobStat(bool enableDebugOn) async {
  if (!_supportPlatform) return false;
  final bool? state =
      await _channel.invokeMethod<bool?>('setDebug', enableDebugOn);
  return state ?? false;
}

/// 设置通道
Future<bool> setAppChannelOnWithMobStat(String channel) async {
  if (!_supportPlatform) return false;
  final bool? state =
      await _channel.invokeMethod<bool?>('setAppChannel', channel);
  return state ?? false;
}

/// 设置App版本
Future<bool> setAppVersionNameWithMobStat(String versionName) async {
  if (!_supportPlatform) return false;
  final bool? state =
      await _channel.invokeMethod<bool?>('setAppVersionName', versionName);
  return state ?? false;
}

/// 记录一次事件的点击。
///
/// [eventId] 自定义事件ID，请提前在网站上创建，未创建的evenId记录将无效。
/// [attributes] 事件属性，对应的key需要在网站上创建，未创建的key记录将无效。
Future<bool> mobStatLogEvent(
    {required String eventId, Map<String, String>? attributes}) async {
  if (!_supportPlatform) return false;
  final bool? state = await _channel.invokeMethod<bool?>('logEvent',
      <String, dynamic>{'eventId': eventId, 'attributes': attributes});
  return state ?? false;
}

/// 记录一次事件的时长。
///
/// [eventId] 自定义事件ID，请提前在网站上创建，未创建的evenId记录将无效。
/// [duration] 已知的自定义事件时长，单位为毫秒（ms）。
/// [label] 事件标签，附加参数，不能为空字符串。
/// [attributes] 事件属性，对应的key需要在网站上创建，未创建的key记录将无效。
Future<bool> mobStatLogDurationEvent(
    {required String eventId,
    required int duration,
    required String label,
    Map<String, String>? attributes}) async {
  if (!_supportPlatform) return false;
  assert(label.isNotEmpty, 'eventLabel 事件标签，附加参数，不能为空字符串');
  final bool? state =
      await _channel.invokeMethod<bool?>('logDurationEvent', <String, dynamic>{
    'eventId': eventId,
    'label': label,
    'duration': duration,
    'attributes': attributes
  });
  return state ?? false;
}

/// 记录一次事件的开始。
///
/// [eventId] 自定义事件ID，请提前在网站上创建，未创建的evenId记录将无效。
/// [label] 自定义事件标签。
Future<bool> mobStatEventStart(
    {required String eventId, String label = ''}) async {
  if (!_supportPlatform) return false;
  final bool? state = await _channel.invokeMethod<bool?>(
      'eventStart', <String, String>{'eventId': eventId, 'label': label});
  return state ?? false;
}

/// 记录一次事件的结束。
///
/// [eventId] 自定义事件ID，请提前在网站上创建，未创建的evenId记录将无效。
/// [label] 自定义事件标签。
/// [attributes] 事件属性，对应的key需要在网站上创建，未创建的key记录将无效。
Future<bool> mobStatEventEnd(
    {required String eventId,
    String label = '',
    Map<String, String>? attributes}) async {
  if (!_supportPlatform) return false;
  final bool? state = await _channel.invokeMethod<bool?>(
      'eventEnd', <String, dynamic>{
    'eventId': eventId,
    'label': label,
    'attributes': attributes
  });
  return state ?? false;
}

/// 记录某个页面访问的开始。
///
/// [name] 页面名称
Future<bool> mobStatPageStart(String name) async {
  if (!_supportPlatform) return false;
  final bool? state = await _channel.invokeMethod<bool?>('pageStart', name);
  return state ?? false;
}

/// 记录某个页面访问的结束。
///
/// [name] 页面名称
Future<bool> mobStatPageEnd(String name) async {
  if (!_supportPlatform) return false;
  final bool? state = await _channel.invokeMethod<bool?>('pageEnd', name);
  return state ?? false;
}

/// 获取SDK生成的设备的cuId
/// android 上获取为空字符串
Future<String?> getDeviceCuIdWithMobStat() async {
  if (!_supportPlatform) return null;
  return await _channel.invokeMethod<String?>('getDeviceCuId');
}

/// 获取SDK生成的设备的测试ID
Future<String?> getTestDeviceIdWithMobStat() async {
  if (!_supportPlatform) return null;
  return await _channel.invokeMethod<String?>('getTestDeviceId');
}

bool get _supportPlatform {
  if (!kIsWeb && (_isAndroid || _isIOS)) return true;
  print('Not support platform for $defaultTargetPlatform');
  return false;
}

bool get _isAndroid => defaultTargetPlatform == TargetPlatform.android;

bool get _isIOS => defaultTargetPlatform == TargetPlatform.iOS;

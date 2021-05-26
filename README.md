# fl_baidu_mob_stat

百度移动统计Flutter插件

[运行 Example 查看 事例](./example)

[查看全部API](./lib/fl_baidu_mob_stat.dart)

## 开始使用

- 注册key
```dart
Future<void> fun() async {
  final bool key = await setApiKeyWithMobStat(
      androidKey: 'androidKey', iosKey: 'iosKey');
     print('初始化是否成功：$key');
}

```

- 设置channel (可选)
```dart
Future<void> fun() async {
   final bool channel = await setAppChannelOnWithMobStat(channelName);
   print('设置channel：$channelName = $channel');
}

```

- 设置version (可选)
```dart
Future<void> fun() async {
    final bool version = await setAppVersionNameWithMobStat('1.0.0');
    print('设置version name：$version');
}

```
- 是否开启debug模式 (可选)
```dart
Future<void> fun() async {
     final bool debug = await setDebugWithMobStat(true);
     print('设置是否开启debug模式：$debug');
}

```

- 获取SDK生成的设备的测试ID
```dart
Future<void> fun()async{
   final String? id = await getTestDeviceIdWithMobStat();
}
```

- 获取SDK生成的设备的cuId  （android 上获取为空字符串）
```dart
Future<void> fun()async{
   final String? id = await getDeviceCuIdWithMobStat();
}
```

- 记录一次事件的点击。
```dart
Future<void> fun()async{
   final bool state = await mobStatLogEvent(
                       eventId: 'Event1',
                       attributes: <String, String>{'k1': 'v1', 'k2': 'v2'});
}
```

- 记录一次事件的时长。
```dart
Future<void> fun()async{
   final bool state = await mobStatLogDurationEvent(
                     eventId: 'Event2',
                     duration: 3000,
                     label: 'event',
                     attributes: <String, String>{'k1': 'v1'});
}
```

- 记录一次事件的开始。
```dart
Future<void> fun()async{
   final bool state = await mobStatEventStart(eventId: 'Event3');
}
```

- 记录一次事件的结束。
```dart
Future<void> fun()async{
   final bool state = await mobStatEventEnd(
                       eventId: 'Event3',
                       attributes: <String, String>{'k1': 'v1'});
}
```

- 记录某个页面访问的开始。
```dart
Future<void> fun()async{
   final bool state = await mobStatPageStart('AnotherPage');
}
```

- 记录某个页面访问的结束。
```dart
Future<void> fun()async{
   final bool state = await mobStatPageEnd('AnotherPage');
}
```
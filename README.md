# fl_baidu_mob_stat

百度移动统计Flutter插件

[运行 Example 查看 事例](https://github.com/Wayaer/fl_baidu_mob_stat/tree/main/example)

[查看全部API](https://github.com/Wayaer/fl_baidu_mob_stat/blob/main/lib/fl_baidu_mob_stat.dart)

## 开始使用

- 注册key
```dart
Future<void> fun() async {
  final bool key = await FLBaiduMobStat.instance.setApiKey(
      androidKey: 'androidKey', iosKey: 'iosKey');
     print('初始化是否成功：$key');
}

```

- 设置channel (可选)
```dart
Future<void> fun() async {
   final bool channel = await FLBaiduMobStat.instance.setAppChannel(channelName);
   print('设置channel：$channelName = $channel');
}

```

- 设置version (可选)
```dart
Future<void> fun() async {
    final bool version = await FLBaiduMobStat.instance.setAppVersionName('1.0.0');
    print('设置version name：$version');
}

```
- 是否开启debug模式 (可选)
```dart
Future<void> fun() async {
     final bool debug = await FLBaiduMobStat.instance.setDebug(true);
     print('设置是否开启debug模式：$debug');
}

```

- 获取SDK生成的设备的测试ID
```dart
Future<void> fun()async{
   final String? id = await FLBaiduMobStat.instance.getTestDeviceId();
}
```

- 获取SDK生成的设备的cuId  （android 上获取为空字符串）
```dart
Future<void> fun()async{
   final String? id = await  FLBaiduMobStat.instance.getDeviceCuId();
}
```

- 记录一次事件的点击。
```dart
Future<void> fun()async{
   final bool state = await FLBaiduMobStat.instance.logEvent(
                       eventId: 'Event1',
                       attributes: <String, String>{'k1': 'v1', 'k2': 'v2'});
}
```

- 记录一次事件的时长。
```dart
Future<void> fun()async{
   final bool state = await FLBaiduMobStat.instance.logDurationEvent(
                     eventId: 'Event2',
                     duration: 3000,
                     label: 'event',
                     attributes: <String, String>{'k1': 'v1'});
}
```

- 记录一次事件的开始。
```dart
Future<void> fun()async{
   final bool state = await FLBaiduMobStat.instance.eventStart(eventId: 'Event3');
}
```

- 记录一次事件的结束。
```dart
Future<void> fun()async{
   final bool state = await FLBaiduMobStat.instance.eventEnd(
                       eventId: 'Event3',
                       attributes: <String, String>{'k1': 'v1'});
}
```

- 记录某个页面访问的开始。
```dart
Future<void> fun()async{
   final bool state = await FLBaiduMobStat.instance.pageStart('AnotherPage');
}
```

- 记录某个页面访问的结束。
```dart
Future<void> fun()async{
   final bool state = await FLBaiduMobStat.instance.pageEnd('AnotherPage');
}
```
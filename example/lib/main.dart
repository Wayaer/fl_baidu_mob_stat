import 'dart:async';
import 'dart:io';

import 'package:fl_baidu_mob_stat/fl_baidu_mob_stat.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bool key =
      await setApiKeyWithMobStat(androidKey: 'androidKey', iosKey: 'iosKey');
  print('初始化是否成功：$key');

  String channelName = 'flutter';
  if (Platform.isAndroid) channelName += '- Android';
  if (Platform.isIOS) channelName += '- IOS';

  final bool channel = await setAppChannelOnWithMobStat(channelName);
  print('设置channel：$channelName = $channel');

  final bool version = await setAppVersionNameWithMobStat('1.0.0');
  print('设置version name：$version');

  final bool debug = await setDebugWithMobStat(true);
  print('设置是否开启debug模式：$debug');

  runApp(MaterialApp(
    home: _MyApp(),
    debugShowCheckedModeBanner: false,
    title: 'FLBaiduMobStat',
  ));
}

class _MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  bool _eventStartEndButtonSelected = false;
  String text = '';

  Future<void> _getDeviceCuId() async {
    final String? cuId = await getDeviceCuIdWithMobStat();
    if (cuId == null) return;
    text = 'CuId:\n' + cuId;
    setState(() {});
  }

  Future<void> _getTestDeviceId() async {
    final String? id = await getTestDeviceIdWithMobStat();
    if (id == null) return;
    text = 'TestId\n' + id;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FLBaiduMobStat Example')),
      body: Center(
        child: Column(children: <Widget>[
          Container(
              height: 100, child: Text(text), alignment: Alignment.center),
          ElevatedButton(
              child: const Text('mobStatLogEvent'),
              onPressed: () async {
                final bool state = await mobStatLogEvent(
                    eventId: 'Event1',
                    attributes: <String, String>{'k1': 'v1', 'k2': 'v2'});
                text = 'mobStatLogEvent: $state';
                setState(() {});
              }),
          ElevatedButton(
              child: const Text('mobStatLogDurationEvent'),
              onPressed: () async {
                final bool state = await mobStatLogDurationEvent(
                    eventId: 'Event2',
                    duration: 3000,
                    label: 'event',
                    attributes: <String, String>{'k1': 'v1'});
                text = 'mobStatLogDurationEvent: $state';
                setState(() {});
              }),
          ElevatedButton(
              child: Text(_eventStartEndButtonSelected
                  ? 'mobStatEventEnd'
                  : 'mobStatEventStart'),
              onPressed: () async {
                _eventStartEndButtonSelected = !_eventStartEndButtonSelected;
                if (_eventStartEndButtonSelected) {
                  final bool state = await mobStatEventStart(eventId: 'Event3');
                  text = 'mobStatEventStart: $state';
                } else {
                  final bool state = await mobStatEventEnd(
                      eventId: 'Event3',
                      attributes: <String, String>{'k1': 'v1'});
                  text = 'mobStatEventEnd: $state';
                }
                setState(() {});
              }),
          ElevatedButton(
              child: const Text('Open new page'),
              onPressed: () async {
                final bool state = await mobStatPageStart('AnotherPage');
                text = 'mobStatPageStart: $state';
                setState(() {});
              }),
          ElevatedButton(
              child: const Text('Close new page'),
              onPressed: () async {
                final bool state = await mobStatPageEnd('AnotherPage');
                text = 'mobStatPageEnd: $state';
                setState(() {});
              }),
          ElevatedButton(
              child: const Text('getDeviceCuId'), onPressed: _getDeviceCuId),
          ElevatedButton(
              child: const Text('getTestDeviceId'),
              onPressed: _getTestDeviceId),
        ]),
      ),
    );
  }
}

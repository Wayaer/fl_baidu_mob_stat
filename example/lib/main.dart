import 'dart:async';
import 'dart:io';

import 'package:fl_baidu_mob_stat/fl_baidu_mob_stat.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final bool key = await FlBaiduMobStat()
      .setApiKey(androidKey: 'androidKey', iosKey: 'iosKey');
  debugPrint('初始化是否成功：$key');

  String channelName = 'flutter';
  if (Platform.isAndroid) channelName += '- Android';
  if (Platform.isIOS) channelName += '- IOS';

  final bool channel = await FlBaiduMobStat().setAppChannel(channelName);
  debugPrint('设置channel：$channelName  result : $channel');

  final bool version = await FlBaiduMobStat().setAppVersionName('1.0.0');
  debugPrint('设置version name：$version');

  final bool debug = await FlBaiduMobStat().setDebug(true);
  debugPrint('设置是否开启debug模式：$debug');

  runApp(MaterialApp(
    home: _App(),
    debugShowCheckedModeBanner: false,
    title: 'FlBaiduMobStat',
  ));
}

class _App extends StatefulWidget {
  @override
  State<_App> createState() => _AppState();
}

class _AppState extends State<_App> {
  bool _eventStartEndButtonSelected = false;
  String text = '';

  Future<void> _getDeviceCuId() async {
    final String? cuId = await FlBaiduMobStat().getDeviceCuId();
    if (cuId == null) return;
    text = 'CuId:\n$cuId';
    setState(() {});
  }

  Future<void> _getTestDeviceId() async {
    final String? id = await FlBaiduMobStat().getTestDeviceId();
    if (id == null) return;
    text = 'TestId\n$id';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('FlBaiduMobStat Example')),
        body: Center(
          child: Column(children: <Widget>[
            Container(
                height: 100, alignment: Alignment.center, child: Text(text)),
            ElevatedButton(
                child: const Text('logEvent'),
                onPressed: () async {
                  final bool state = await FlBaiduMobStat().logEvent(
                      eventId: 'Event1',
                      attributes: <String, String>{'k1': 'v1', 'k2': 'v2'});
                  text = 'logEvent: $state';
                  setState(() {});
                }),
            ElevatedButton(
                child: const Text('logDurationEvent'),
                onPressed: () async {
                  final bool state = await FlBaiduMobStat().logDurationEvent(
                      eventId: 'Event2',
                      duration: 3000,
                      label: 'event',
                      attributes: <String, String>{'k1': 'v1'});
                  text = 'logDurationEvent: $state';
                  setState(() {});
                }),
            ElevatedButton(
                child: Text(
                    _eventStartEndButtonSelected ? 'eventEnd' : 'eventStart'),
                onPressed: () async {
                  _eventStartEndButtonSelected = !_eventStartEndButtonSelected;
                  if (_eventStartEndButtonSelected) {
                    final bool state =
                        await FlBaiduMobStat().eventStart(eventId: 'Event3');
                    text = 'eventStart: $state';
                  } else {
                    final bool state = await FlBaiduMobStat().eventEnd(
                        eventId: 'Event3',
                        attributes: <String, String>{'k1': 'v1'});
                    text = 'eventEnd: $state';
                  }
                  setState(() {});
                }),
            ElevatedButton(
                child: const Text('open page'),
                onPressed: () async {
                  final bool state =
                      await FlBaiduMobStat().pageStart('AnotherPage');
                  text = 'pageStart: $state';
                  setState(() {});
                }),
            ElevatedButton(
                child: const Text('close page'),
                onPressed: () async {
                  final bool state =
                      await FlBaiduMobStat().pageEnd('AnotherPage');
                  text = 'pageEnd: $state';
                  setState(() {});
                }),
            ElevatedButton(
                onPressed: _getDeviceCuId, child: const Text('getDeviceCuId')),
            ElevatedButton(
                onPressed: _getTestDeviceId,
                child: const Text('getTestDeviceId')),
          ]),
        ));
  }
}

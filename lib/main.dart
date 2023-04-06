import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wakelock/wakelock.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Timer30Min(),
    );
  }
}

class Timer30Min extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => Timer30MinState();
}

class Timer30MinState extends State<Timer30Min> {
  late Timer _timer;
  int _time = 0;
  int speed = 0;
  String description = "";
  String leftTime = "";
  Color backColor = Colors.green;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: backColor,
          body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: Stack(alignment: Alignment.center, children: [
                SizedBox(
                  height: 300,
                  width: 300,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    color: Colors.blueGrey,
                    value: _time / 1800,
                    strokeWidth: 20,
                  ),
                ),
                Text(
                  formatedTime(_time),
                  style: TextStyle(fontSize: 80),
                ),
              ]),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text("${speed}km/h", style: TextStyle(fontSize: 50)),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text("${description}", style: TextStyle(fontSize: 30)),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text("${leftTime}", style: TextStyle(fontSize: 20)),
            )
          ])),
    );
  }

  formatedTime(int secd) {
    int sec = secd % 60;
    int min = (secd / 60).truncate();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  void start() {
    _timer = Timer.periodic(const Duration(milliseconds: 1000), (timer) {
      setState(() {
        _time = timer.tick;
        if (_time >= 1800) {
          stop();
        }
        _getSpeed(_time);
      });
    });
  }

  void stop() {
    _timer.cancel();
  }

  void _getSpeed(int time) {
    var minute = (time / 60).truncate();
    setState(() {
      switch (minute) {
        case 0:
          speed = 4;
          description = "워밍업!";
          break;
        case 1:
          speed = 5;
          description = "워밍업!";
          break;
        case 2:
          speed = 6;
          description = "워밍업!";
          break;
        case 3:
          speed = 8;
          leftTime = "5분 까지";
          description = "뛰기 시작!!";
          backColor = Colors.red[200]!;
          break;
        case 5:
          speed = 6;
          leftTime = "6분 까지";
          description = "쉬기";
          backColor = Colors.green;
          break;
        case 6:
          speed = 8;
          leftTime = "8분 까지";
          description = "뛰기!!";
          backColor = Colors.red[200]!;
          break;
        case 8:
          speed = 6;
          leftTime = "9분 까지";
          description = "쉬기";
          backColor = Colors.green;
          break;
        case 9:
          speed = 8;
          leftTime = "11분 까지";
          description = "뛰기";
          backColor = Colors.red[200]!;
          break;
        case 11:
          speed = 6;
          description = "쉬기";
          leftTime = "12분 까지";
          backColor = Colors.green;
          break;
        case 12:
          speed = 9;
          leftTime = "15분 까지";
          description = "좀 더 빠르게 뛰기";
          backColor = Colors.red[200]!;
          break;
        case 15:
          speed = 6;
          description = "쉬기";
          leftTime = "16분 까지";
          backColor = Colors.green;
          break;
        case 16:
          speed = 9;
          leftTime = "19분 까지";
          description = "뛰어!";
          backColor = Colors.red[200]!;
          break;
        case 19:
          speed = 6;
          leftTime = "20분 까지";
          description = "쉬기";
          backColor = Colors.green;
          break;
        case 20:
          speed = 9;
          leftTime = "23분 까지";
          description = "뛰어!!";
          backColor = Colors.red[200]!;
          break;
        case 23:
          speed = 6;
          leftTime = "24분 까지";
          description = "쉬기";
          backColor = Colors.green;
          break;
        case 24:
          speed = 10;
          leftTime = "26분 까지";
          description = "더 빨리 뛰어";
          backColor = Colors.red[300]!;
          break;
        case 26:
          speed = 11;
          leftTime = "27분 까지";
          description = "더더 빨리 뛰어";
          backColor = Colors.red[400]!;
          break;
        case 27:
          speed = 12;
          leftTime = "28분 까지";
          description = "더더더 빨리 뛰어";
          backColor = Colors.red;
          break;
        case 28:
          speed = 12;
          leftTime = "👍";
          description = "Cool Down";
          backColor = Colors.blue;
          break;
        case 30:
          speed = 0;
          leftTime = "👍";
          description = "런닝 끝";
          backColor = Colors.blue;
          break;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    start();
    Wakelock.enable();
  }

  @override
  void dispose() {
    super.dispose();
    stop();
    Wakelock.disable();
  }
}

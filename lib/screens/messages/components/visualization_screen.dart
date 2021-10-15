import 'dart:math';

import 'package:chat/components/menu_items.dart';
import 'package:chat/models/menu_item.dart';
import 'package:chat/screens/chats/components/pop_up_menu.dart';
import 'package:chat/screens/signinOrSignUp/signin_or_signup_screen.dart';
import 'package:chat/screens/messages/message_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../../constants.dart';

class ScatterChartSample1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScatterChartSample1State();
}

class _ScatterChartSample1State extends State {
  final maxX = 50.0;
  final maxY = 50.0;
  final radius = 8.0;

  Color blue1 = const Color(0xFF0D47A1);
  Color blue2 = const Color(0xFF42A5F5).withOpacity(0.8);

  bool showFlutter = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      extendBodyBehindAppBar: true, // App Bar を透過させるために必要
      body: Stack(children: <Widget>[
        new Container(
          // 背景画像表示. Stack の最初に配置.
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: new AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          // for centering the image
          child: Column(children: <Widget>[
            //Spacer(flex: 1), // For App bar
            Padding(padding: EdgeInsets.only(top: 72)), // For App bar
            //Expanded(child: buildGesture()),
            Expanded(child: Image.asset('assets/images/wordmap_example.png')),
          ]),
        ),
      ]),
    );
  }

  GestureDetector buildGesture() {
    return GestureDetector(
      onTap: () {
        setState(() {
          showFlutter = !showFlutter;
        });
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: Card(
          color: const Color(0xffffffff),
          elevation: 6,
          child: ScatterChart(
            ScatterChartData(
              scatterSpots: showFlutter ? flutterLogoData() : randomData(),
              minX: 0,
              maxX: maxX,
              minY: 0,
              maxY: maxY,
              borderData: FlBorderData(
                show: false,
              ),
              gridData: FlGridData(
                show: false,
              ),
              titlesData: FlTitlesData(
                show: false,
              ),
              scatterTouchData: ScatterTouchData(
                enabled: false,
              ),
            ),
            swapAnimationDuration: const Duration(milliseconds: 600),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0, // App Bar を透過させるために必要
      backgroundColor: Colors.transparent, // App Bar を透過させるために必要
      brightness: Brightness.dark, // change the status bar color
      automaticallyImplyLeading: false, // デフォルトの back ボタンを削除
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, // 両端寄せ
        children: <Widget>[
          Container(width: 40.0, height: 0.0),
          IconButton(
              icon: Image.asset('assets/images/chatroom_green.png'),
              onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => MessagesScreen()))),
          SizedBox(
            height: 32.0,
            width: 32.0,
            child: IconButton(
              icon: Image.asset('assets/images/logout.png'),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => SigninOrSignupScreen())),
            ),
          )
        ],
      ),
    );
  }

  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
        value: item,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                item.menuItemName,
                style: TextStyle(fontSize: 14),
              ),
              item.menuIcon,
            ],
          ),
        ),
      );

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemVisualisation:
        Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ScatterChartSample1()));
        break;

      case MenuItems.itemLogout:
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => SigninOrSignupScreen()),
          (route) => false,
        );
        break;
    }
  }

  List<ScatterSpot> flutterLogoData() {
    return [
      /// section 1
      ScatterSpot(20, 14.5, color: blue1, radius: radius),
      ScatterSpot(22, 16.5, color: blue1, radius: radius),
      ScatterSpot(24, 18.5, color: blue1, radius: radius),

      ScatterSpot(22, 12.5, color: blue1, radius: radius),
      ScatterSpot(24, 14.5, color: blue1, radius: radius),
      ScatterSpot(26, 16.5, color: blue1, radius: radius),

      ScatterSpot(24, 10.5, color: blue1, radius: radius),
      ScatterSpot(26, 12.5, color: blue1, radius: radius),
      ScatterSpot(28, 14.5, color: blue1, radius: radius),

      ScatterSpot(26, 8.5, color: blue1, radius: radius),
      ScatterSpot(28, 10.5, color: blue1, radius: radius),
      ScatterSpot(30, 12.5, color: blue1, radius: radius),

      ScatterSpot(28, 6.5, color: blue1, radius: radius),
      ScatterSpot(30, 8.5, color: blue1, radius: radius),
      ScatterSpot(32, 10.5, color: blue1, radius: radius),

      ScatterSpot(30, 4.5, color: blue1, radius: radius),
      ScatterSpot(32, 6.5, color: blue1, radius: radius),
      ScatterSpot(34, 8.5, color: blue1, radius: radius),

      ScatterSpot(34, 4.5, color: blue1, radius: radius),
      ScatterSpot(36, 6.5, color: blue1, radius: radius),

      ScatterSpot(38, 4.5, color: blue1, radius: radius),

      /// section 2
      ScatterSpot(20, 14.5, color: blue2, radius: radius),
      ScatterSpot(22, 12.5, color: blue2, radius: radius),
      ScatterSpot(24, 10.5, color: blue2, radius: radius),

      ScatterSpot(22, 16.5, color: blue2, radius: radius),
      ScatterSpot(24, 14.5, color: blue2, radius: radius),
      ScatterSpot(26, 12.5, color: blue2, radius: radius),

      ScatterSpot(24, 18.5, color: blue2, radius: radius),
      ScatterSpot(26, 16.5, color: blue2, radius: radius),
      ScatterSpot(28, 14.5, color: blue2, radius: radius),

      ScatterSpot(26, 20.5, color: blue2, radius: radius),
      ScatterSpot(28, 18.5, color: blue2, radius: radius),
      ScatterSpot(30, 16.5, color: blue2, radius: radius),

      ScatterSpot(28, 22.5, color: blue2, radius: radius),
      ScatterSpot(30, 20.5, color: blue2, radius: radius),
      ScatterSpot(32, 18.5, color: blue2, radius: radius),

      ScatterSpot(30, 24.5, color: blue2, radius: radius),
      ScatterSpot(32, 22.5, color: blue2, radius: radius),
      ScatterSpot(34, 20.5, color: blue2, radius: radius),

      ScatterSpot(34, 24.5, color: blue2, radius: radius),
      ScatterSpot(36, 22.5, color: blue2, radius: radius),

      ScatterSpot(38, 24.5, color: blue2, radius: radius),

      /// section 3
      ScatterSpot(10, 25, color: blue2, radius: radius),
      ScatterSpot(12, 23, color: blue2, radius: radius),
      ScatterSpot(14, 21, color: blue2, radius: radius),

      ScatterSpot(12, 27, color: blue2, radius: radius),
      ScatterSpot(14, 25, color: blue2, radius: radius),
      ScatterSpot(16, 23, color: blue2, radius: radius),

      ScatterSpot(14, 29, color: blue2, radius: radius),
      ScatterSpot(16, 27, color: blue2, radius: radius),
      ScatterSpot(18, 25, color: blue2, radius: radius),

      ScatterSpot(16, 31, color: blue2, radius: radius),
      ScatterSpot(18, 29, color: blue2, radius: radius),
      ScatterSpot(20, 27, color: blue2, radius: radius),

      ScatterSpot(18, 33, color: blue2, radius: radius),
      ScatterSpot(20, 31, color: blue2, radius: radius),
      ScatterSpot(22, 29, color: blue2, radius: radius),

      ScatterSpot(20, 35, color: blue2, radius: radius),
      ScatterSpot(22, 33, color: blue2, radius: radius),
      ScatterSpot(24, 31, color: blue2, radius: radius),

      ScatterSpot(22, 37, color: blue2, radius: radius),
      ScatterSpot(24, 35, color: blue2, radius: radius),
      ScatterSpot(26, 33, color: blue2, radius: radius),

      ScatterSpot(24, 39, color: blue2, radius: radius),
      ScatterSpot(26, 37, color: blue2, radius: radius),
      ScatterSpot(28, 35, color: blue2, radius: radius),

      ScatterSpot(26, 41, color: blue2, radius: radius),
      ScatterSpot(28, 39, color: blue2, radius: radius),
      ScatterSpot(30, 37, color: blue2, radius: radius),

      ScatterSpot(28, 43, color: blue2, radius: radius),
      ScatterSpot(30, 41, color: blue2, radius: radius),
      ScatterSpot(32, 39, color: blue2, radius: radius),

      ScatterSpot(30, 45, color: blue2, radius: radius),
      ScatterSpot(32, 43, color: blue2, radius: radius),
      ScatterSpot(34, 41, color: blue2, radius: radius),

      ScatterSpot(34, 45, color: blue2, radius: radius),
      ScatterSpot(36, 43, color: blue2, radius: radius),

      ScatterSpot(38, 45, color: blue2, radius: radius),
    ];
  }

  List<ScatterSpot> randomData() {
    const blue1Count = 21;
    const blue2Count = 57;
    return List.generate(blue1Count + blue2Count, (i) {
      Color color;
      if (i < blue1Count) {
        color = blue1;
      } else {
        color = blue2;
      }

      return ScatterSpot(
        (Random().nextDouble() * (maxX - 8)) + 4,
        (Random().nextDouble() * (maxY - 8)) + 4,
        color: color,
        radius: (Random().nextDouble() * 16) + 4,
      );
    });
  }
}

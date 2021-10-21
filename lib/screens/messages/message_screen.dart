//import 'dart:js';

//import 'dart:js';
//import 'package:path/path.dart' as Path;
import 'package:chat/components/menu_items.dart';
import 'package:chat/constants.dart';
import 'package:chat/models/menu_item.dart';
import 'package:chat/screens/chats/components/pop_up_menu.dart';
import 'package:chat/screens/messages/components/visualization_screen.dart';
import 'package:chat/screens/signinOrSignUp/signin_or_signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/body.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      extendBodyBehindAppBar: true, // App Bar を透過させるために必要
      body: Body(),
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
              icon: Image.asset('assets/images/connectdevelop.png'),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScatterChartSample1()))),
          SizedBox(
            height: 32.0,
            width: 32.0,
            child: IconButton(
                icon: Image.asset('assets/images/logout.png'),
                onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) => SigninOrSignupScreen()),
                      (route) => false,
                    )),
          ),
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

  //Text(item.menuItemName),)
}

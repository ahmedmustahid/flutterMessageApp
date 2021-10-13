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
      //appBar: buildAppBar(context),// App Bar を透過させるために必要.
      appBar: AppBar(
          elevation: 0, // App Bar を透過させるために必要.
          backgroundColor: Colors.transparent, // App Bar を透過させるために必要.
          brightness: Brightness.dark // change the status bar color
          ),
      extendBodyBehindAppBar: true, // App Bar を透過させるために必要.
      body: Body(),
      //backgroundColor: Colors.grey,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          //BackButton(),
          CircleAvatar(
              // "z" の丸アイコン
              //backgroundImage: AssetImage("assets/images/user_2.png"),
              radius: 14,
              backgroundColor: Colors.brown.shade800,
              child: const Text('Z')),
          SizedBox(width: kDefaultPadding * 0.75),

          Column(
            // "z" の丸アイコンの右側にあるテキスト表示
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Zai",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
          /*
          Center(
              child: IconButton(
                icon: Image.asset('assets/images/connectdevelop.png'),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ScatterChartSample1())),
          )),
          */
          /*
          IconButton(
              icon: Image.asset('assets/images/connectdevelop.png'),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => ScatterChartSample1()))),
          IconButton(
            icon: Image.asset('assets/images/logout_small.png'),
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => SigninOrSignupScreen())),
          ),
          */
        ],
      ),
      /*
      leading: IconButton(
          icon: Image.asset('assets/images/connectdevelop.png'),
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => ScatterChartSample1()))),
      actions: <Widget>[
        IconButton(
          icon: Image.asset('assets/images/logout_small.png'),
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => SigninOrSignupScreen())),
        ),
      ],
      */
      actions: <Widget>[
        //PopUpMenu(),
        PopupMenuButton<MenuItem>(
            onSelected: (item) => onSelected(context, item),
            itemBuilder: (context) => [
                  ...MenuItems.itemsFirst.map(buildItem).toList(),
                ]),
      ],

      //IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
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

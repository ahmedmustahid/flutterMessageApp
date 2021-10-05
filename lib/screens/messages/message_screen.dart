//import 'dart:js';

//import 'dart:js';
//import 'package:path/path.dart' as Path;
import 'package:chat/components/menu_items.dart';
import 'package:chat/constants.dart';
import 'package:chat/models/chat_model.dart';
import 'package:chat/models/menu_item.dart';
import 'package:chat/notifiers/chat_data_notifier.dart';
import 'package:chat/notifiers/providers.dart';
import 'package:chat/screens/chats/components/body.dart';
import 'package:chat/screens/chats/components/pop_up_menu.dart';
import 'package:chat/screens/messages/components/visualization_screen.dart';
import 'package:chat/screens/signinOrSignUp/signin_or_signup_screen.dart';
import 'package:chat/services/format_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          //BackButton(),
          CircleAvatar(
              //backgroundImage: AssetImage("assets/images/user_2.png"),
              radius: 14,
              backgroundColor: Colors.brown.shade800,
              child: const Text('Z')),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Zai",
                style: TextStyle(fontSize: 16),
              ),
            ],
          )
        ],
      ),
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

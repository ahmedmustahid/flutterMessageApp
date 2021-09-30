import 'package:chat/constants.dart';
import 'package:chat/screens/messages/components/body.dart';
import 'package:chat/screens/messages/components/visualization_screen.dart';
import 'package:chat/screens/messages/message_screen.dart';
import 'package:chat/screens/signinOrSignUp/signin_or_signup_screen.dart';
import 'package:chat/screens/welcome/welcome_screen.dart';
import 'package:flutter/material.dart';

/// This is the stateful widget that the main application instantiates.
class PopUpMenu extends StatefulWidget {
  const PopUpMenu({Key? key}) : super(key: key);

  @override
  State<PopUpMenu> createState() => _PopUpMenuState();
}

/// This is the private State class that goes with PopUpMenu.
class _PopUpMenuState extends State<PopUpMenu> {
  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Visualize',
                  style: TextStyle(fontSize: 14),
                ),
                Icon(
                  Icons.scatter_plot_sharp,
                  color: Colors.black,
                )
              ],
            ),
          ),
          value: 1,
        ),
        PopupMenuItem(
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'Logout',
                  style: TextStyle(fontSize: 14),
                ),
                Icon(
                  Icons.logout,
                  color: Colors.black,
                )
              ],
            ),
          ),
          value: 2,
        )
      ],
      onSelected: (result) {
        if (result == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ScatterChartSample1()),
          );
        }
        if (result == 2) {
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => WelcomeScreen()),
            (route) => false,
          );
        }
      },
    );
  }
}

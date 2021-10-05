import 'package:chat/components/primary_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/screens/chats/chats_screen.dart';
import 'package:chat/screens/messages/components/message_page.dart';
import 'package:chat/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SigninOrSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            children: [
              Spacer(flex: 2),
              Lottie.asset("assets/images/76432-floating-orange-robot.json"),
              // Image.asset(
              //   MediaQuery.of(context).platformBrightness == Brightness.light
              //       ? "assets/images/.png"
              //       : "assets/images/Logo_dark.png",
              //   height: 146,
              // ),
              Spacer(),
              PrimaryButton(
                text: "Sign In",
                color: Colors.blue,
                press: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MessagePage()),
                  (route) => false,
                ),
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MessagesScreen(),
                //     //builder: (context) => ChatsScreen(),
                //   ),
                // ),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              PrimaryButton(
                color: Theme.of(context).colorScheme.secondary,
                text: "Sign Up",
                press: () {},
              ),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

//import 'package:chat/constants.dart';
//import 'package:chat/models/ChatMessage.dart';
import 'package:chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'chat_input_field.dart';
//import 'message.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: Stack(
        children: <Widget>[
          Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: kDefaultPadding,
                  vertical: kDefaultPadding / 2,
                ),
                //padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                height: 60,
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: TextStyle(color: Colors.black54),
                            border: InputBorder.none),
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 18,
                      ),
                      backgroundColor: kPrimaryColor,
                      elevation: 0,
                    ),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

//import 'package:chat/constants.dart';
//import 'package:chat/models/ChatMessage.dart';
import 'dart:async';

import 'package:chat/constants.dart';
import 'package:chat/models/message_model.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
//import 'dart:math' as math;
//import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'chat_input_field.dart';
//import 'message.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _scrollcontroller = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  void _printLatestValue() {
    print('text field: ${_textEditingController.text}');
  }

  _addMessage() {
    // ChatMessage newMessage = ChatMessage(
    //     messageContent: _textEditingController.text.trim(),
    //     messageType: "sender");
    var uuid = Uuid();
    var messageId = uuid.v1();
    String dateTimeNow = DateTime.now().toIso8601String();

    MessageModel newMessage = MessageModel(
        id: messageId,
        userId: "1",
        isMe: true,
        message: _textEditingController.text.trim(),
        createdAt: dateTimeNow);

    setState(() {
      //messages.add(newMessage);
      if (newMessage.message.isNotEmpty) {
        messages = [...messages, newMessage];
      }
      Timer(
          Duration(milliseconds: 30),
          () => _scrollcontroller
              .jumpTo(_scrollcontroller.position.maxScrollExtent));
    });

    print(newMessage.toJson().toString());
    _textEditingController.clear();
    FocusScope.of(context).unfocus();
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _textEditingController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    _textEditingController.dispose();
    super.dispose();
  }

  List<MessageModel> messages = [];

  @override
  Widget build(BuildContext context) {
    return Stack(
      //fit: StackFit.passthrough,
      children: <Widget>[
        ListView.builder(
          controller: _scrollcontroller,
          itemCount: messages.length,
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          //physics: (),
          //physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return Container(
              padding:
                  EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
              child: Align(
                alignment: (messages[index].isMe == false
                    ? Alignment.topLeft
                    : Alignment.topRight),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: (messages[index].isMe == false
                        ? Colors.grey.shade200
                        : Colors.blue[200]),
                  ),
                  padding: EdgeInsets.all(16),
                  child: Text(
                    messages[index].message,
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ),
            );
          },
        ),
        Padding(padding: EdgeInsets.all(16)),
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
                      autocorrect: true,
                      enableSuggestions: true,
                      //onSubmitted: _addMessage(),
                      controller: _textEditingController,
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      _addMessage();
                    },
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
    );
  }
}

// class CustomSimulation extends Simulation {
//   final double initPosition;
//   final double velocity;

//   CustomSimulation({required this.initPosition, required this.velocity});

//   @override
//   double x(double time) {
//     var max =
//         math.max(math.min(initPosition, 0.0), initPosition + velocity * time);
//     print(max.toString());
//     return max;
//   }

//   @override
//   double dx(double time) {
//     print(velocity.toString());
//     return velocity;
//   }

//   @override
//   bool isDone(double time) {
//     return false;
//   }
// }

// class CustomScrollPhysics extends ScrollPhysics {
//   @override
//   ScrollPhysics applyTo(ScrollPhysics? ancestor) {
//     return CustomScrollPhysics();
//   }

//   @override
//   Simulation createBallisticSimulation(
//       ScrollMetrics position, double velocity) {
//     return CustomSimulation(
//       initPosition: position.pixels,
//       velocity: velocity * 20,
//     );
//   }
// }

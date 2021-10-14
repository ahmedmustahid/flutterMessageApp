import 'dart:async';
import 'package:chat/constants.dart';
import 'package:chat/models/message_model.dart';
import 'package:chat/services/api_service/post_method_service.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _scrollcontroller = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  List<MessageModel> messages = [];
  bool _receivedReply = false;

  void _printLatestValue() {
    print('text field: ${_textEditingController.text}');
  }

  MessageModel _addMessage() {
    var messageId = Uuid().v1();
    var userId = "1";
    var sessionId = "1";
    String dateTimeNow = DateTime.now().toIso8601String();

    MessageModel newMessage = MessageModel(
        id: messageId,
        userId: userId,
        sessionId: sessionId,
        isMe: true,
        messageContent: _textEditingController.text.trim(),
        createdAt: dateTimeNow);

    setState(() {
      if (newMessage.messageContent.isNotEmpty) {
        messages = [...messages, newMessage];
      }
      Timer(
          Duration(milliseconds: 30),
          () => _scrollcontroller
              .jumpTo(_scrollcontroller.position.maxScrollExtent));
    });

    print(newMessage.toString());
    _textEditingController.clear();
    FocusScope.of(context).unfocus();
    return newMessage;
  }

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    _textEditingController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

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
                    messages[index].messageContent,
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
                    onPressed: () async {
                      var senderMessage = _addMessage();
                      var replyMessage = await postApi(senderMessage);
                      setState(() {
                        _receivedReply = true;
                        if (replyMessage!.messageContent.isNotEmpty) {
                          messages = [...messages, replyMessage];
                        }
                      });
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

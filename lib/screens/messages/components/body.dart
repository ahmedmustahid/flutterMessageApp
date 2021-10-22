import 'dart:async';
import 'dart:convert';
import 'package:amplify_api/amplify_api.dart';
import 'package:chat/constants.dart';
import 'package:chat/globals.dart';
import 'package:chat/models/message_model.dart';
import 'package:chat/repositories/auth_repository.dart';
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
  //int _counter = 0;

  List<MessageModel> messages = [];
  bool _receivedReply = false;
  bool _isTextFieldEnabled = true;
  String _sessionId = "-1";
  String _flowId = "START";

  void _printLatestValue() {
    print('text field: ${_textEditingController.text}');
  }

  Future<MessageModel> _addMessage(
      {String sessionId = "-1", String flowId = "START"}) async {
    var messageId = Uuid().v1();
    var userId = await AuthRepositoryClass().getUserIdFromAttributes();
    //var sessionId = "1";
    //var flowId = "START";
    String dateTimeNow = DateTime.now().toIso8601String();

    MessageModel newMessage = MessageModel(
        id: messageId,
        userId: userId,
        sessionId: sessionId,
        flowId: flowId,
        isMe: true,
        messageContent: _textEditingController.text.trim(),
        createdAt: dateTimeNow);

    userIdForImage = newMessage.userId;

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
    Future(() async {
      var senderMessage =
          await _addMessage(sessionId: this._sessionId, flowId: this._flowId);

      var replyMessage = await postApi(senderMessage);

      this._receivedReply = true;
      this._flowId = replyMessage.flowId;
      this._sessionId = replyMessage.sessionId;

      setState(() {
        if (replyMessage.messageContent.isNotEmpty) {
          messages = [...messages, replyMessage];
        }
      });

      print('globalCounter value $globalCounter');
      globalCounter++;
    });
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
    return this._receivedReply
        ? Stack(
            //fit: StackFit.passthrough,
            children: <Widget>[
              new Container(
                // 背景画像表示. Stack の最初に配置.
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new AssetImage('assets/images/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 72)), // For App bar

                  Expanded(
                    child: new Container(
                      //color: Color.fromRGBO(70, 82, 97, 1), // 背景をグレーで塗りつぶし
                      color: Colors.transparent, // 背景を透明色で塗りつぶし
                      child: ListView.builder(
                        controller: _scrollcontroller,
                        itemCount: messages.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(top: 0, bottom: 0),
                        scrollDirection: Axis.vertical,
                        physics:
                            ClampingScrollPhysics(), // lock the over scroll
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Align(
                              alignment: (messages[index].isMe == false
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (messages[index].isMe == false
                                      ? Colors.grey.shade200
                                      : Color.fromRGBO(84, 131, 128, 1)),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  messages[index].messageContent,
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: (messages[index].isMe == false
                                        ? Colors.black
                                        : Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  //Padding(padding: EdgeInsets.all(16)),
                  Align(
                      alignment: Alignment.bottomLeft,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10, //kDefaultPadding,
                          vertical: kDefaultPadding / 2,
                        ),

                        //padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
                        height: 60,
                        width: double.infinity,
                        //color: Colors.grey, // 下部テキストボックスの色
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                enabled: _isTextFieldEnabled,
                                autocorrect: true,
                                enableSuggestions: true,
                                //onSubmitted: _addMessage(),
                                controller: _textEditingController,
                                style:
                                    TextStyle(color: Colors.white), // 入力テキストの色
                                decoration: InputDecoration(
                                  fillColor: Color.fromRGBO(35, 46, 60, 0.8),
                                  hintText: "", //"  テキストを入力して下さい",
                                  hintStyle: TextStyle(color: Colors.white),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 2, horizontal: 4), // 上下中央揃え
                                  enabledBorder: new OutlineInputBorder(
                                    //borderRadius: new BorderRadius.circular(25.0),
                                    borderSide: BorderSide(
                                      color: Colors.white, // テキストボックスの縁の色
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 0, // テキストボックス右側の余白サイズ
                            ),
                            SizedBox(
                              height: 48.0,
                              width: 48.0,
                              child: IconButton(
                                  icon: Image.asset(
                                    'assets/images/send.png',
                                  ),
                                  onPressed: () async {
                                    var senderMessage = await _addMessage(
                                        sessionId: this._sessionId,
                                        flowId: this._flowId);

                                    if (this._flowId.compareTo("END") == 0) {
                                      setState(
                                          () => _isTextFieldEnabled = false);
                                    }

                                    if (senderMessage
                                        .messageContent.isNotEmpty) {
                                      var replyMessage =
                                          await postApi(senderMessage);
                                      setState(() {
                                        this._flowId = replyMessage.flowId;
                                        this._sessionId =
                                            replyMessage.sessionId;

                                        if (replyMessage
                                            .messageContent.isNotEmpty) {
                                          messages = [
                                            ...messages,
                                            replyMessage
                                          ];
                                        }
                                        Timer(
                                            Duration(milliseconds: 30),
                                            () => _scrollcontroller.jumpTo(
                                                _scrollcontroller
                                                    .position.maxScrollExtent));
                                      });
                                    }
                                  }),
                            ),
                          ],
                        ),
                      ))
                ],
              ),
            ],
          )
        : Center(
            child: CircularProgressIndicator(),
          );
  }
}

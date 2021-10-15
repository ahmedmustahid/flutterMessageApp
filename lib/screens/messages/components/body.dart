import 'dart:async';
import 'package:chat/constants.dart';
import 'package:chat/models/message_model.dart';
import 'package:chat/services/api_service/post_method_service.dart';
import 'package:flutter/material.dart';
//<<<<<<< HEAD
import 'package:uuid/uuid.dart';
//=======
// import 'package:chat/screens/messages/components/visualization_screen.dart';
// import 'package:chat/screens/signinOrSignUp/signin_or_signup_screen.dart';
//import 'dart:math' as math;
//import 'package:flutter_riverpod/flutter_riverpod.dart';

//import 'chat_input_field.dart';
//import 'message.dart';

// class ChatMessage {
//   String messageContent;
//   String messageType;
//   ChatMessage({required this.messageContent, required this.messageType});
// }
// >>>>>>> hotfix-chat-display

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ScrollController _scrollcontroller = ScrollController();
  final TextEditingController _textEditingController = TextEditingController();

  List<MessageModel> messages = [];
  bool _receivedReply = false;
  bool _isTextFieldEnabled = true;

  void _printLatestValue() {
    print('text field: ${_textEditingController.text}');
  }

  MessageModel _addMessage() {
    var messageId = Uuid().v1();
    var userId = "1";
    var sessionId = "1";
    var flowId = "START";
    String dateTimeNow = DateTime.now().toIso8601String();

    MessageModel newMessage = MessageModel(
        id: messageId,
        userId: userId,
        sessionId: sessionId,
        flowId: flowId,
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
// <<<<<<< HEAD
//         ListView.builder(
//           controller: _scrollcontroller,
//           itemCount: messages.length,
//           shrinkWrap: true,
//           padding: EdgeInsets.only(top: 10, bottom: 10),
//           scrollDirection: Axis.vertical,
//           physics: BouncingScrollPhysics(),
//           //physics: (),
//           //physics: NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             return Container(
//               padding:
//                   EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
//               child: Align(
//                 alignment: (messages[index].isMe == false
//                     ? Alignment.topLeft
//                     : Alignment.topRight),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: (messages[index].isMe == false
//                         ? Colors.grey.shade200
//                         : Colors.blue[200]),
//                   ),
//                   padding: EdgeInsets.all(16),
//                   child: Text(
//                     messages[index].messageContent,
//                     style: TextStyle(fontSize: 15),
// =======
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
            /*
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 両端寄せ
              children: <Widget>[
                Container(width: 40.0, height: 0.0),
                IconButton(
                    icon: Image.asset('assets/images/connectdevelop.png'),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => ScatterChartSample1()))),
                SizedBox(
                  height: 32.0,
                  width: 32.0,
                  child: IconButton(
                    icon: Image.asset('assets/images/logout.png'),
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => SigninOrSignupScreen())),
>>>>>>> hotfix-chat-display
                  ),
                )
              ],
            ),
            */
            Expanded(
              child: new Container(
                color: Color.fromRGBO(70, 82, 97, 1),
                child: ListView.builder(
                  controller: _scrollcontroller,
                  itemCount: messages.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 0, bottom: 0),
                  scrollDirection: Axis.vertical,
                  physics: ClampingScrollPhysics(), // lock the over scroll
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
// <<<<<<< HEAD
//                   FloatingActionButton(
//                     onPressed: () async {
//                       var senderMessage = _addMessage();
//                       var replyMessage = await postApi(senderMessage);
//                       setState(() {
//                         _receivedReply = true;
//                         if (replyMessage!.messageContent.isNotEmpty) {
//                           messages = [...messages, replyMessage];
//                         }
//                       });
//                     },
//                     child: Icon(
//                       Icons.send,
//                       color: Colors.white,
//                       size: 18,
//                     ),
//                     backgroundColor: kPrimaryColor,
//                     elevation: 0,
// =======
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
                          style: TextStyle(color: Colors.white), // 入力テキストの色
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
                              var senderMessage = _addMessage();
                              var replyMessage = await postApi(senderMessage);
                              setState(() {
                                _receivedReply = true;
                                if (replyMessage.messageContent.isNotEmpty) {
                                  messages = [...messages, replyMessage];
                                }
                                _textEditingController.dispose();
                                //setState(() => _isTextFieldEnabled = false);
                                if (replyMessage.flowId.compareTo("END") == 0) {
                                  setState(() => _isTextFieldEnabled = false);
                                }
                              });
                            }),
                      ),
                    ],
//>>>>>>> hotfix-chat-display
                  ),
                ))
          ],
        ),
      ],
    );
  }
}

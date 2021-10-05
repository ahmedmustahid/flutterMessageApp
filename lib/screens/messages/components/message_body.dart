import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:bubble/bubble.dart';
import 'package:chat/components/menu_items.dart';
import 'package:chat/constants.dart';
import 'package:chat/models/ChatMessage.dart';
import 'package:chat/models/chat_model.dart';
import 'package:chat/models/menu_item.dart';
import 'package:chat/notifiers/chat_data_notifier.dart';
import 'package:chat/notifiers/providers.dart';
import 'package:chat/screens/messages/components/visualization_screen.dart';
import 'package:chat/screens/signinOrSignUp/signin_or_signup_screen.dart';
import 'package:chat/services/api_service/queries.dart';
import 'package:chat/services/format_date.dart';
import 'package:chat/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chat_input_field.dart';
import 'message.dart';

class MessagePageBody extends StatefulWidget {
  final String name;
  final String chatId;

  const MessagePageBody({
    Key? key,
    required this.name,
    required this.chatId,
  }) : super(key: key);
  @override
  _MessagePageBodyState createState() => _MessagePageBodyState();
}

class _MessagePageBodyState extends State<MessagePageBody> {
  TextEditingController messageCtrl = TextEditingController();
  late GraphQLSubscriptionOperation<dynamic> createOperation;
  late GraphQLSubscriptionOperation<dynamic> updateOperation;
  late GraphQLSubscriptionOperation<dynamic> deleteOperation;

  bool inSelectMode = false;
  List<String> selectedChats = [];

  @override
  void initState() {
    super.initState();
    context.read(chatDataProvider).getChatData(widget.chatId);
    onCreateChat();
    //onUpdateChat();
    //onDeleteChat();
  }

  @override
  void dispose() {
    createOperation.cancel();
    updateOperation.cancel();
    deleteOperation.cancel();
    super.dispose();
  }

  onCreateChat() {
    createOperation = Amplify.API.subscribe(
      request: GraphQLRequest(document: Queries.onCreateChatData),
      onData: (event) {
        context.read(chatDataProvider).getChatData(widget.chatId);
      },
      onEstablished: () {
        print('Subscription established');
      },
      onError: (e) {
        print('Subscription failed with error: $e');
      },
      onDone: () {
        print('Subscription has been closed successfully');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: buildAppBar(context),
        body: getMessagePageBody(context),
        // body: getBody(),
      ),
    );
  }

  Widget getMessagePageBody(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/bg_chat.jpg"), fit: BoxFit.cover),
      ),
      child: Consumer(
        builder: (_, watch, __) {
          final state = watch(chatDataProvider); //removed .state
          if (state is ChatDataSuccess)
            return buildChatList(context, chatData: state.chatData);
          return Container();
        },
      ),
    );
  }

  Widget buildChatList(BuildContext context,
      {required List<ChatModel> chatData}) {
    return ListView(
      reverse: true,
      padding: EdgeInsets.only(top: 20, bottom: 80),
      children: List.generate(
        chatData.length,
        (index) {
          return buildChatBubble(
            message: chatData[index].message,
            isMe: chatData[index].senderId == context.read(currUserProvider).id,
            time: formatDate(chatData[index].createdAt),
            messageId: chatData[index].id,
          );
        },
      ),
    );
  }

  Widget buildChatBubble({
    Key? key,
    required bool isMe,
    required String message,
    required String time,
    required String messageId,
  }) {
    if (isMe) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: 2),
        child: Container(
          // color: inSelectMode && selectedChats.contains(messageId)
          //     ? chatBoxMe.withOpacity(0.4)
          //     : null,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 20,
                      right: 14,
                      bottom: 2,
                      top: 2,
                    ),
                    child: Bubble(
                      nip: BubbleNip.rightTop,
                      color: chatBoxMe,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            message,
                            style: TextStyle(fontSize: 16, color: white),
                          ),
                          SizedBox(
                            width: 12,
                          ),
                          Text(
                            time,
                            style: TextStyle(
                                fontSize: 12, color: white.withOpacity(0.4)),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.done_all_outlined,
                            size: 20,
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    )),
              )
            ],
          ),
        ),
      );
    } else {
      return Row(
        children: [
          Flexible(
            child: Padding(
                padding: const EdgeInsets.only(right: 20, left: 14, bottom: 10),
                child: Bubble(
                  nip: BubbleNip.leftTop,
                  color: chatBoxOther,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        message,
                        style: TextStyle(fontSize: 16, color: white),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 11,
                          color: white.withOpacity(0.4),
                        ),
                      ),
                    ],
                  ),
                )),
          )
        ],
      );
    }
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
}

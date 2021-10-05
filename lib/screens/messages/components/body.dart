import 'package:chat/constants.dart';
import 'package:chat/models/ChatMessage.dart';
import 'package:chat/models/chat_model.dart';
import 'package:chat/notifiers/chat_data_notifier.dart';
import 'package:chat/notifiers/providers.dart';
import 'package:chat/services/format_date.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'chat_input_field.dart';
import 'message.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            //the following code may cause error
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            // child: ListView.builder(
            //   itemCount: demeChatMessages.length,
            //   itemBuilder: (context, index) =>
            //       Message(message: demeChatMessages[index]),
            // ),
          ),
        ),
        ChatInputField(),
      ],
    );
  }

  Widget getBody() {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/images/bg_chat.jpg"), fit: BoxFit.cover),
      ),
      child: Consumer(
        builder: (_, watch, __) {
          final state = watch(chatDataProvider); //removed .state
          if (state is ChatDataSuccess)
            return buildChatList(chatData: state.chatData);
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
        child: GestureDetector(
          onLongPress: () {
            if (!inSelectMode)
              setState(() {
                inSelectMode = true;
                addToSelectedChats(messageId);
              });
            else
              setState(() {
                addToSelectedChats(messageId);
              });
          },
          onTapUp: (TapUpDetails tapUpDetails) {
            if (inSelectMode)
              setState(() {
                addToSelectedChats(messageId);
              });
          },
          child: Container(
            color: inSelectMode && selectedChats.contains(messageId)
                ? chatBoxMe.withOpacity(0.4)
                : null,
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
}

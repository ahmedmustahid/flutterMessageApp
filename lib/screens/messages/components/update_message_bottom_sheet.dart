import 'package:chat/services/get_it_service.dart';
import 'package:chat/services/navigation_service.dart';
import 'package:chat/services/size_config.dart';
import 'package:chat/themes/colors.dart';
import 'package:flutter/material.dart';

updateMessageBottomSheet(
  BuildContext context,
  String message,
  String messageId,
  String chatRoomId,
  int currVersion,
  Function closeSelectionModel,
) {
  TextEditingController messageCtrl = TextEditingController(text: message);

  NavigationService _navigationService =
      get_it_instance_const<NavigationService>();
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: bgColor,
    builder: (context) {
      return Container(
        height: 300.toHeight,
        width: SizeConfig.screenWidth,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          border: Border.all(color: Colors.white.withOpacity(0.1), width: 3),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Update message",
                style: CustomTextStyle.loginTitleStyle.copyWith(
                  fontSize: 23.toFont,
                ),
              ),
              SizedBox(height: 24.toHeight),
              TextArea(ctrl: messageCtrl),
              SizedBox(height: 24.toHeight),
              PrimaryButton(
                text: "Continue",
                onPress: () async {
                  if (messageCtrl.text == "") return;
                  context.read(chatDataProvider).updateChatData(
                        messageId,
                        messageCtrl.text,
                        currVersion,
                        chatRoomId,
                      );
                  closeSelectionModel();
                  if (Navigator.canPop(context)) _navigationService.goBack();
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}

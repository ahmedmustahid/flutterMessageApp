import 'package:chat/themes/colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:flutter/material.dart';

Widget getChatDetailsAppBar({
  required BuildContext context,
  //required String img,
  required String name,
  required bool inSelectMode,
  required int selectedChatCount,
  required Function closeSelectionModel,
  required Function deleteSelectedChats,
  //required Function openUpdateMessageSheet,
}) {
  return AppBar(
    //brightness: Brightness.dark,
    backgroundColor: greyColor,
    title: inSelectMode
        ? Container(child: Text(selectedChatCount.toString()))
        : Container(
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/user_placeholder.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 150,
                  child: Text(
                    name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
    leading: inSelectMode
        ? GestureDetector(
            onTap: () {
              closeSelectionModel();
            },
            child: Icon(
              Icons.cancel_outlined,
            ),
          )
        : GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
            ),
          ),
    actions: inSelectMode
        ? [
            // IconButton(
            //     icon: Icon(Icons.edit, size: 30),
            //     onPressed: () async {
            //       await openUpdateMessageSheet();
            //     }),
            // SizedBox(width: 20),
            IconButton(
                icon: Icon(Icons.delete, size: 30),
                onPressed: () async {
                  await deleteSelectedChats();
                }),
            SizedBox(width: 20),
            IconButton(
              icon: Icon(Icons.more_vert, size: 30),
              onPressed: () async {},
            ),
            SizedBox(width: 20),
          ]
        : [
            Icon(LineIcons.phone, size: 30),
            SizedBox(width: 20),
            Icon(Icons.more_vert, size: 30),
            SizedBox(width: 20),
          ],
  );
}

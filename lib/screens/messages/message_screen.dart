import 'package:chat/constants.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Body(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(),
          CircleAvatar(
              //backgroundImage: AssetImage("assets/images/user_2.png"),
              radius: 14,
              backgroundColor: Colors.brown.shade800,
              child: const Text('S')),
          SizedBox(width: kDefaultPadding * 0.75),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Sanzai",
                style: TextStyle(fontSize: 16),
              ),
              //Text(
              //  "Active 3m ago",
              //  style: TextStyle(fontSize: 12),
              //)
            ],
          )
        ],
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined))
        // IconButton(
        //   icon: Icon(Icons.local_phone),
        //   onPressed: () {},
        // ),
        // IconButton(
        //   icon: Icon(Icons.videocam),
        //   onPressed: () {},
        // ),
        // SizedBox(width: kDefaultPadding / 2),
      ],
    );
  }
}

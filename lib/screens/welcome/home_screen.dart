import 'package:chat/notifiers/providers.dart';
import 'package:chat/screens/messages/components/message_page.dart';
import 'package:chat/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/src/provider.dart';
import 'package:line_icons/line_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int pageIndex = 0;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    await context.read(userRepositoryProvider).getCurrUser();
    await context.read(userRepositoryProvider).getAllOtherUser();

    if (mounted) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: isLoading ? Center(child: CircularProgressIndicator()) : getBody(),
      bottomNavigationBar: getFooter(),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: [
        MessagePage(),
        // StatusPage(),
        // SettingsPage(),
      ],
    );
  }

  Widget getFooter() {
    List iconItems = [
      LineIcons.circle,
      LineIcons.comment,
      Icons.settings,
    ];
    List textItems = ["Chats", "Status", "Settings"];
    return Container(
      height: 90,
      width: double.infinity,
      decoration: BoxDecoration(color: greyColor),
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
            textItems.length,
            (index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    pageIndex = index;
                  });
                },
                child: Column(
                  children: [
                    Icon(
                      iconItems[index],
                      color:
                          pageIndex == index ? primary : white.withOpacity(0.5),
                      size: 29,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      textItems[index],
                      style: TextStyle(
                        fontSize: 12,
                        color: pageIndex == index
                            ? primary
                            : white.withOpacity(0.5).withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

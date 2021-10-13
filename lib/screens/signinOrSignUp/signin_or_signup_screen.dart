//import 'package:chat/components/primary_button.dart';
import 'package:chat/constants.dart';
import 'package:chat/screens/chats/chats_screen.dart';
import 'package:chat/screens/messages/message_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SigninOrSignupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      extendBodyBehindAppBar: true, // App Bar を透過させるために必要
      body: Stack(
        children: [
          new Container(
            // 背景画像表示. Stack の最初に配置.
            decoration: new BoxDecoration(
              image: new DecorationImage(
                image: new AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 48, bottom: 24, left: 40, right: 40),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(
                        top: 128)), // the distance of between TextFileds
                TextFormField(
                  //onChanged:
                  style: TextStyle(color: Color.fromRGBO(135, 202, 198, 1)),
                  decoration: InputDecoration(
                    // Username 入力
                    labelText: '  ユーザーID',
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color.fromRGBO(135, 202, 198, 1)),
                    fillColor: Color.fromRGBO(35, 46, 60, 0.8),
                    filled:
                        true, // this should be true if you want to set color to textfield
                    //hintText: "  ユーザIDを入力してください。",
                    hintStyle: TextStyle(
                        fontSize: 10, color: Color.fromRGBO(135, 202, 198, 1)),
                    contentPadding: EdgeInsets.symmetric(vertical: 2), // 上下中央揃え
                    enabledBorder: new OutlineInputBorder(
                      //borderRadius: new BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(135, 202, 198, 1), // テキストボックスの縁の色
                      ),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: 64)), // the distance of between TextFileds
                /*
                Text(
                  "パスワード",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 14, color: Color.fromRGBO(135, 202, 198, 1)),
                ),
                */
                TextFormField(
                  // Password 入力
                  //onChanged:
                  style: TextStyle(color: Color.fromRGBO(135, 202, 198, 1)),
                  decoration: InputDecoration(
                    fillColor: Color.fromRGBO(35, 46, 60, 0.8),
                    filled:
                        true, // this should be true if you want to set color to textfield
                    labelText: '  パスワード',
                    labelStyle: TextStyle(
                        fontSize: 14, color: Color.fromRGBO(135, 202, 198, 1)),
                    //hintText: "  パスワードを入力してください。",
                    hintStyle: TextStyle(
                        fontSize: 10, color: Color.fromRGBO(135, 202, 198, 1)),
                    contentPadding: EdgeInsets.symmetric(vertical: 2), // 上下中央揃え
                    enabledBorder: new OutlineInputBorder(
                      //borderRadius: new BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(135, 202, 198, 1), // テキストボックスの縁の色
                      ),
                    ),
                  ),
                  obscureText: true,
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: 100)), // the distance of between TextFileds
                Center(
                  child: OutlinedButton(
                    child: Text(
                      'ログイン',
                      style: new TextStyle(
                        fontSize: 14,
                        color: Color.fromRGBO(135, 202, 198, 1),
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: Size(150, 40),
                      backgroundColor: Color.fromRGBO(69, 111, 116, 1),
                      //primary: Color.fromRGBO(135, 202, 198, 1), // テキストカラー
                      shape: const StadiumBorder(),
                      side: const BorderSide(
                          width: 2, color: Color.fromRGBO(135, 202, 198, 1)),
                    ),
                    onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => MessagesScreen()),
                      (route) => false,
                    ),
                  ),
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
          /*
            children: [
              //Spacer(flex: 2),
              Spacer(),
              PrimaryButton(
                text: "Sign In",
                color: Colors.blue,
                press: () => Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => MessagesScreen()),
                  (route) => false,
                ),
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => MessagesScreen(),
                //     //builder: (context) => ChatsScreen(),
                //   ),
                // ),
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              PrimaryButton(
                color: Theme.of(context).colorScheme.secondary,
                text: "Sign Up",
                press: () {},
              ),
              Spacer(flex: 2),
            ],
          */
        ],
      ),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    elevation: 0, // App Bar を透過させるために必要
    backgroundColor: Colors.transparent, // App Bar を透過させるために必要
    brightness: Brightness.dark, // change the status bar color
    automaticallyImplyLeading: false, // デフォルトの back ボタンを削除
    title: Center(
      child: Text(
        "", //"Zai",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    ),
  );
}

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:chat/amplifyconfiguration.dart';
import 'package:chat/screens/messages/message_screen.dart';

import 'package:chat/screens/signinOrSignUp/signin_or_signup_screen.dart';
import 'package:chat/theme.dart';
import 'package:flutter/material.dart';

class TestName {
  TestName({
    required this.firstName,
    required this.lastName,
  });
  late final String firstName;
  late final String lastName;

  TestName.fromJson(Map<String, dynamic> json) {
    firstName = json["first_name"];
    lastName = json["last_name"];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["first_name"] = firstName;
    _data["last_name"] = lastName;
    return _data;
  }

  @override
  String toString() {
    return '{\"first_name\":\"$firstName\",\"last_name\":\"$lastName\"}';
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAmplifyConfigured = false;
  @override
  void initState() {
    super.initState();
    _configureAmplify();
  }

  Future<void> _configureAmplify() async {
    try {
      await Amplify.addPlugins([AmplifyAPI(), AmplifyAuthCognito()]);
      await Amplify.configure(amplifyconfig);

      setState(() => _isAmplifyConfigured = true);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isAmplifyConfigured) {
      //onTestApi();
      print('ontest success');
    } else {
      print('ontest failed');
    }
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightThemeData(context),
      darkTheme: darkThemeData(context),
      home: _isAmplifyConfigured
          ? MessagesScreen()
          //? SigninOrSignupScreen()
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

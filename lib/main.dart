import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:chat/amplifyconfiguration.dart';
import 'package:chat/screens/messages/message_screen.dart';
import 'package:chat/screens/welcome/welcome_screen.dart';
import 'package:chat/services/api_service/amplify_services.dart';
import 'package:chat/theme.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class TestName {
  TestName({
    required this.firstName,
    required this.lastName,
  });
  late final String firstName;
  late final String lastName;

  TestName.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['first_name'] = firstName;
    _data['last_name'] = lastName;
    return _data;
  }
}

void main() {
  // final myJson =
  //     TestName(firstName: "John_flutter", lastName: "Smith_flutter").toJson();
  // print(myJson);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isAmplifyConfigured = false;
  @override
  void initState() {
    super.initState();
    _configureAmplify();
    //AmplifyService.configureAmplify();
  }

  Future<void> _configureAmplify() async {
    // Add the following line to add API plugin to your app.
    // Auth plugin needed for IAM authorization mode, which is default for REST API.

    try {
      await Amplify.addPlugins([AmplifyAPI(), AmplifyAuthCognito()]);
      await Amplify.configure(amplifyconfig);

      setState(() => _isAmplifyConfigured = true);
    } on AmplifyAlreadyConfiguredException {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
    }
  }

  void onTestApi() async {
    // final myJson =
    //   TestName(firstName: "John_flutter", lastName: "Smith_flutter").toJson();
    final firstName = "John_flutter";
    final lastName = "Smith_flutter";
    try {
      RestOptions options = RestOptions(
          path: '/todo',
          body: Uint8List.fromList(
              '{\"first_name\":\"$firstName\",\"last_name\":\"$lastName\"}'
                  .codeUnits));
      RestOperation restOperation = Amplify.API.post(restOptions: options);
      RestResponse response = await restOperation.response;
      print('POST call succeeded');

      final responseFromREST = new String.fromCharCodes(response.data);
      final myInstanceFromJson =
          TestName.fromJson(jsonDecode(responseFromREST));
      print('String response from REST is \n $responseFromREST');

      print('firstName from JSON object ${myInstanceFromJson.firstName}');
      print('lastName from JSON object ${myInstanceFromJson.lastName}');
    } on ApiException catch (e) {
      print('POST call failed: $e');
    }
    // Edit this function with next steps.
  }

  // void _postRequest() {

  // }

  @override
  Widget build(BuildContext context) {
    if (_isAmplifyConfigured) {
      onTestApi();
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
          : Center(
              child: CircularProgressIndicator(),
            ),
      //home: MessagesScreen(),
      //home: WelcomeScreen(),
    );
  }
}

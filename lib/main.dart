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

void main() {
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
    try {
      RestOptions options = RestOptions(
          path: '/todo',
          body: Uint8List.fromList(
              '{\"first_name\":\"John_flutter\",\"last_name\":\"Smith_flutter\"}'
                  .codeUnits));
      RestOperation restOperation = Amplify.API.post(restOptions: options);
      RestResponse response = await restOperation.response;
      print('POST call succeeded');
      print(new String.fromCharCodes(response.data));
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

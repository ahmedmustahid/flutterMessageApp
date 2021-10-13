import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:chat/amplifyconfiguration.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

bool _isAmplifyConfigured = false;
void main() async {
  print('hello world');
  await _configureAmplify();
  //runApp(MyApp());
}

Future<void> _configureAmplify() async {
  // Add the following line to add API plugin to your app.
  // Auth plugin needed for IAM authorization mode, which is default for REST API.

  try {
    await Amplify.addPlugins([AmplifyAPI(), AmplifyAuthCognito()]);
    await Amplify.configure(amplifyconfig);

    _isAmplifyConfigured = true;
    //setState(() => _isAmplifyConfigured = true);
  } on AmplifyAlreadyConfiguredException {
    print(
        "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
  }
}

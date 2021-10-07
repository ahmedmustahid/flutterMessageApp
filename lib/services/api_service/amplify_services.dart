import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:chat/amplifyconfiguration.dart';

class AmplifyService {
  static Future<void> configureAmplify() async {
    // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
    AmplifyAPI apiPlugin = AmplifyAPI();
    AmplifyAuthCognito authPlugin = AmplifyAuthCognito();

    // AmplifyStorageS3 amplifyStorageS3 = AmplifyStorageS3();

    //print('added plugins');

    try {
      await Amplify.addPlugins([
        // amplifyStorageS3,
        authPlugin,
        apiPlugin,
      ]);
      await Amplify.configure(amplifyconfig);
      print('configured amplify');
    } catch (e) {
      print(
          "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");

      print(e);
    }
  }
}

//final test = AmplifyService();

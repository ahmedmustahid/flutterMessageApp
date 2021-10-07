import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:chat/routes/routes_path.dart';
import 'package:chat/services/get_it_service.dart';
import 'package:chat/services/navigation_service.dart';
import 'package:chat/services/size_config.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatefulWidget {
  Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  NavigationService _navigationService =
      get_it_instance_const<NavigationService>();
  @override
  void initState() {
    super.initState();
    handleNavigation();
  }

  // handleNavigation() async {
  //   AuthSession authSessions = await Amplify.Auth.fetchAuthSession();
  //   print('navigation handler before signed in');
  //   if (authSessions.isSignedIn) {
  //     print('is signed in');
  //     //await Amplify.Auth.signOut();
  //     // try {
  //     //   Amplify.Auth.signOut();
  //     //   print('signed out');
  //     // } on AuthException catch (e) {
  //     //   print(e.message);
  //     // }
  //     _navigationService.popAllAndReplace(RoutePath.Home);
  //   } else
  //     _navigationService.popAllAndReplace(RoutePath.Register);
  //   //_navigationService.popAllAndReplace(RoutePath.Splash);
  // }

  handleNavigation() async {
    try {
      AuthSession res = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      );
      String identityId = (res as CognitoAuthSession).identityId!;
      print('identityId: $identityId');
    } on AuthException catch (e) {
      print(e.message);
    }
    _navigationService.popAllAndReplace(RoutePath.Register);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return buildIntialPage();
  }

  Scaffold buildIntialPage() {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

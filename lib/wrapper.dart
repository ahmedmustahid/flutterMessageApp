import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:chat/services/get_it_service.dart';
import 'package:chat/services/navigation_service.dart';
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

  handleNavigation() async {
    AuthSession authSessions = await Amplify.Auth.fetchAuthSession();
    if (authSessions.isSignedIn) {
      // await Amplify.Auth.signOut();
      _navigationService.popAllAndReplace(RoutePath.Home);
    } else
      _navigationService.popAllAndReplace(RoutePath.Splash);
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

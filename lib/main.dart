import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:chat/routes/routes_generator.dart';
import 'package:chat/routes/routes_path.dart';
import 'package:chat/screens/welcome/welcome_screen.dart';
import 'package:chat/services/api_service/amplify_services.dart';
import 'package:chat/services/get_it_service.dart';
import 'package:chat/services/navigation_service.dart';
import 'package:chat/theme.dart';
import 'package:chat/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  GetItService.setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    AmplifyService.configureAmplify();
    // Future(() async {
    //   await AmplifyService.configureAmplify();
    //   await _signOut();
    // });
    //await AmplifyService.configureAmplify();
    //_signOut();
  }

  Future<void> _signOut() async {
    final isSignedIn = await _checkSession();
    print('isSignedin $isSignedIn');
    if (isSignedIn) {
      try {
        Amplify.Auth.signOut();
        print('signed out');
      } on AuthException catch (e) {
        print(e.message);
      }
    } else {
      print('not signed in');
    }
  }

  Future<bool> _checkSession() async {
    final currentSession = await _fetchSession();
    if (currentSession!.isSignedIn) {
      return true;
    } else
      return false;
  }

  // This widget is the root of your application.
  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Flutter Demo',
  //     debugShowCheckedModeBanner: false,
  //     theme: lightThemeData(context),
  //     darkTheme: darkThemeData(context),
  //     home: WelcomeScreen(),
  //     navigatorKey: get_it_instance_const<NavigationService>().navigatorKey,
  //     onGenerateRoute: generateRoute,
  //   );
  // }

  Future<AuthSession?> _fetchSession() async {
    try {
      AuthSession res = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      );
      String identityId = (res as CognitoAuthSession).identityId!;
      print('identityId: $identityId');
      return res;
    } on AuthException catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: Wrapper(),
        theme: ThemeData(
          fontFamily: 'Poppins',
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              primary: Colors.black,
              backgroundColor: Colors.white,
            ),
          ),
        ),
        navigatorKey: get_it_instance_const<NavigationService>().navigatorKey,
        onGenerateRoute: generateRoute,
        initialRoute: RoutePath.Login,
      ),
    );
  }
}

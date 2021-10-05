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
  WidgetsFlutterBinding.ensureInitialized();
  GetItService.setupLocator();
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

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
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
        initialRoute: RoutePath.Register,
      ),
    );
  }
}

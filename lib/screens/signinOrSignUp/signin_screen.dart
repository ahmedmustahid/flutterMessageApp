import 'package:chat/components/primary_button.dart';
import 'package:chat/components/show_snackbar.dart';
import 'package:chat/components/username_login_button.dart';
import 'package:chat/notifiers/login_with_username_password_notifier.dart';
import 'package:chat/notifiers/providers.dart';
import 'package:chat/routes/routes_path.dart';
import 'package:chat/screens/messages/components/login_text_field.dart';
import 'package:chat/services/get_it_service.dart';
import 'package:chat/services/navigation_service.dart';
import 'package:chat/services/size_config.dart';
import 'package:chat/services/test_styles.dart';
import 'package:chat/services/validations.dart';
import 'package:chat/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  NavigationService _navigationService =
      get_it_instance_const<NavigationService>();

  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: getBody(),
    );
  }

  Widget getBody() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 80, horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(height: 80.toHeight),
                Text(
                  "Let's sign you in.",
                  style: CustomTextStyle.loginTitleStyle,
                ),
                SizedBox(height: 10.toHeight),
                Text(
                  "Welcome back.",
                  style: CustomTextStyle.loginTitleSecondaryStyle,
                ),
                Text(
                  "You've been missed!",
                  style: CustomTextStyle.loginTitleSecondaryStyle,
                ),
                buildEmailLoginForm(),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 20.toHeight),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: CustomTextStyle.registerButtonStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        _navigationService.popAllAndReplace(RoutePath.Register);
                      },
                      child: Text(
                        "Register. 😁",
                        style: CustomTextStyle.registerButtonStyle
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.toHeight),
                ProviderListener(
                  onChange: (context, state) async {
                    if (state is LoginWithUsernameSuccess) {
                      bool hasUserName = await context
                          .read(authRepositoryProvider)
                          .hasUsername();
                      if (!hasUserName) {
                        //getNameBottomSheet(context);
                        print('no such username exists');
                      } else {
                        _navigationService.popAllAndReplace(RoutePath.Home);
                      }
                    }
                  },
                  provider: loginWithUsernameNotifierProvider.notifier,
                  child: Consumer(builder: (_, watch, __) {
                    final state =
                        watch(loginWithUsernameNotifierProvider.notifier);
                    if (state is LoginWithUsernameLoading)
                      return Center(child: CircularProgressIndicator());
                    else if (state is LoginWithUsernameInitial)
                      return UsernameButton();
                    return UsernameButton();
                  }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Form buildEmailLoginForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 45.toHeight),
          CustomLoginTextField(
            hintTextL: "Email",
            ctrl: emailCtrl,
            validation: Validations.validateEmail,
            type: TextInputType.emailAddress,
          ),
          SizedBox(height: 24.toHeight),
          CustomLoginTextField(
            hintTextL: "Password",
            ctrl: passwordCtrl,
            validation: Validations.valdiatePassword,
            obscureText: true,
            type: TextInputType.text,
          ),
          SizedBox(height: 24.toHeight),
          //ProviderListener<LoginWithUsernameNotifier>(
          //ProviderListener<LoginWithUsernameState>(
          ProviderListener(
            //replaced this with the line before
            provider: loginWithUsernameNotifierProvider,
            onChange: (context, state) {
              print('changed');
              _navigationService.popAllAndReplace(RoutePath.Home);
              if (state is LoginWithUsernameSuccess) {
                print('success');
                _navigationService.popAllAndReplace(RoutePath.Home);
              } else if (state is LoginWithUsernameError) {
                print('error');
                showSnackBar(context, state.error);
              }
            },
            child: Consumer(builder: (_, watch, __) {
              print("inside consumer");
              final state = watch(loginWithUsernameNotifierProvider.notifier);
              //return buildButton();
              if (state is LoginWithUsernameInitial)
                //if (state is LoginWithUsernameNotifier)
                return buildButton();
              else if (state is LoginWithUsernameLoading)
                return Center(child: CircularProgressIndicator());
              return buildButton();
            }),
          )
        ],
      ),
    );
  }

  PrimaryButton buildButton() {
    return PrimaryButton(
      text: "Log in",
      press: () async {
        if (!formKey.currentState!.validate()) return;
        context.read(loginWithUsernameNotifierProvider.notifier).login(
              //added .notifier to loginWithUsernameNotifierProvider
              emailCtrl.text,
              passwordCtrl.text,
            );
      },
    );
  }
}

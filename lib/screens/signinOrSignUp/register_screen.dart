import 'package:chat/components/primary_button.dart';
import 'package:chat/components/secondary_button.dart';
import 'package:chat/components/show_snackbar.dart';
import 'package:chat/notifiers/providers.dart';
import 'package:chat/notifiers/signup_with_email_password_notifier.dart';
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

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController nameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  NavigationService _navigationService =
      get_it_instance_const<NavigationService>();

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
                  "Zai",
                  style: CustomTextStyle.loginTitleStyle
                      .copyWith(fontSize: 36.toFont),
                ),
                SizedBox(height: 10.toHeight),
                Text(
                  "Welcome aboard!",
                  style: CustomTextStyle.loginTitleSecondaryStyle,
                ),
                buildEmailSignUpForm(),
                SizedBox(height: 24.toHeight),
              ],
            ),
            Column(
              children: [
                SizedBox(height: 16.toHeight),
                SecondaryButton(
                  text: "Sign In",
                  onPress: () {
                    print('pressing sign in');
                    _navigationService.popAllAndReplace(RoutePath.Login);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Form buildEmailSignUpForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: 45.toHeight),
          CustomLoginTextField(
            hintTextL: "Full Name",
            ctrl: nameCtrl,
            validation: Validations.validateFullName,
            type: TextInputType.text,
          ),
          SizedBox(height: 12.toHeight),
          CustomLoginTextField(
            //hintTextL: "Email",
            hintTextL: "Username",
            ctrl: emailCtrl,
            validation: Validations.validateEmail,
            type: TextInputType.emailAddress,
          ),
          SizedBox(height: 12.toHeight),
          CustomLoginTextField(
            hintTextL: "Password",
            ctrl: passwordCtrl,
            validation: Validations.valdiatePassword,
            obscureText: true,
          ),
          SizedBox(height: 24.toHeight),
          ProviderListener(
            onChange: (context, state) {
              if (state is SignupWithEmailError)
                showSnackBar(context, state.error);
              else if (state is SignupWithEmailSuccess)
                _navigationService.navigateTo(
                  RoutePath.Otp,
                  arguments: {
                    "email": emailCtrl.text,
                    "password": passwordCtrl.text,
                    "name": nameCtrl.text,
                  },
                );
            },
            provider: signupWithEmailNotifierProvider, //removed .state
            child: Consumer(
              builder: (_, watch, __) {
                final state =
                    watch(signupWithEmailNotifierProvider); //removed .state
                print('state $state');
                //print('statebool $(state is SignupWithEmailLoading)');
                if (state is SignupWithEmailLoading)
                  return Center(child: CircularProgressIndicator());
                else if (state is SignupWithEmailInitial)
                  return buildRegisterButton();
                return buildRegisterButton();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildRegisterButton() {
    return Container(
      width: SizeConfig.screenWidth,
      height: 50.toHeight,
      child: TextButton(
        onPressed: () async {
          if (!formKey.currentState!.validate()) return;
          context
              .read(signupWithEmailNotifierProvider.notifier)
              .signup(emailCtrl.text, passwordCtrl.text, nameCtrl.text);
        },
        child: Text(
          "Signup",
          style: TextStyle(
            fontSize: 20.toFont,
            fontWeight: FontWeight.w600,
          ),
        ),
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0.toWidth),
            ),
          ),
        ),
      ),
    );
  }

  // PrimaryButton buildRegisterButton() {
  //   return PrimaryButton(
  //     text: "Register",
  //     press: () async {
  //       if (!formKey.currentState!.validate()) return;
  //       context.read(signupWithEmailNotifierProvider).signup(
  //             emailCtrl.text,
  //             passwordCtrl.text,
  //             nameCtrl.text,
  //           );
  //     },
  //   );
  // }
}

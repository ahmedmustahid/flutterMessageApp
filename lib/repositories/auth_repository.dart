import 'dart:convert';

//import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:chat/components/show_snackbar.dart';
import 'package:flutter/widgets.dart';
//import 'package:chat/services/api_service/queries.dart';

abstract class AuthRepository {
  Future<bool> loginWithUsernamePassword(
      String username, String password, BuildContext context);
  Future<String> getUserIdFromAttributes();
  Future<void> signOut();
}

class AuthRepositoryClass implements AuthRepository {
  @override
  Future<bool> loginWithUsernamePassword(
      String username, String password, BuildContext context) async {
    try {
      AuthSession _authSessions = await Amplify.Auth.fetchAuthSession();

      if (_authSessions.isSignedIn) {
        await Amplify.Auth.signOut();
      }
      SignInResult res = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      return res.isSignedIn;
    } catch (e) {
      print(e);
      showSnackBar(context, 'ユーザーIDもしくはパスワードに誤りがあります！');
      rethrow;
    }
  }

  @override
  Future<String> getUserIdFromAttributes() async {
    try {
      final attributes = await Amplify.Auth.fetchUserAttributes();
      final userId = attributes
          .firstWhere((element) => element.userAttributeKey == 'sub')
          .value;
      return userId;
    } catch (e) {
      throw e;
    }
  }

  Future<void> signOut() async {
    await Amplify.Auth.signOut();
  }

  void _fetchSession() async {
    try {
      AuthSession res = await Amplify.Auth.fetchAuthSession(
        options: CognitoSessionOptions(getAWSCredentials: true),
      );
      String identityId = (res as CognitoAuthSession).identityId!;
      print('identityId: $identityId');
    } on AuthException catch (e) {
      print(e.message);
    }
  }
}

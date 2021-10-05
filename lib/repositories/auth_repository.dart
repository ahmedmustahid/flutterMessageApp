import 'dart:convert';

import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:chat/services/api_service/queries.dart';

abstract class AuthRepository {
  Future<bool> loginWithUsernamePassword(String username, String password);
  Future<bool> hasUsername();
  Future<dynamic> getUserFromGraphql();
  Future<bool> signupWithEmailPassword(
    String email,
    String password,
    String name,
  );
}

class AuthRepositoryClass implements AuthRepository {
  @override
  Future<bool> loginWithUsernamePassword(
    String username,
    String password,
  ) async {
    try {
      SignInResult res = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      return res.isSignedIn;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<bool> signupWithEmailPassword(
    String email,
    String password,
    String name,
  ) async {
    try {
      Map<String, String> userAttributes = {'name': name};
      await Amplify.Auth.signUp(
        username: email,
        password: password,
        options: CognitoSignUpOptions(userAttributes: userAttributes),
      );
      return true;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool> hasUsername() async {
    AuthUser authUser = await Amplify.Auth.getCurrentUser();
    var operation = Amplify.API.mutate(
      request: GraphQLRequest(
        document: Queries.hasUserName,
        variables: {"id": authUser.userId},
      ),
    );
    var response = await operation.response;
    var data = json.decode(response.data);
    if (data['getUser']['username'] != "Not Available") {
      return true;
    } else
      return false;
  }

  @override
  Future getUserFromGraphql() async {
    try {
      AuthUser authUser = await Amplify.Auth.getCurrentUser();
      var operation = Amplify.API.mutate(
        request: GraphQLRequest(
          document: Queries.getCurrUser,
          variables: {"id": authUser.userId},
        ),
      );
      var response = await operation.response;
      var data = json.decode(response.data);
      return data;
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:chat/repositories/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginWithUsernameNotifier extends StateNotifier<LoginWithUsernameState> {
  final AuthRepository _authRepository;

  LoginWithUsernameNotifier(this._authRepository)
      : super(LoginWithUsernameInitial());

  Future<void> login(String username, String password) async {
    try {
      state = LoginWithUsernameLoading();
      final bool success = await _authRepository.loginWithUsernamePassword(
        username,
        password,
      );
      if (success)
        state = LoginWithUsernameSuccess(true);
      else
        state = LoginWithUsernameError("Unknown error");
    } catch (e) {
      state = LoginWithUsernameError(e.toString());
    }
  }
}

abstract class LoginWithUsernameState {
  const LoginWithUsernameState();
}

class LoginWithUsernameInitial extends LoginWithUsernameState {
  const LoginWithUsernameInitial();
}

class LoginWithUsernameLoading extends LoginWithUsernameState {
  const LoginWithUsernameLoading();
}

class LoginWithUsernameSuccess extends LoginWithUsernameState {
  final bool success;

  LoginWithUsernameSuccess(this.success);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is LoginWithUsernameSuccess && o.success == success;
  }

  @override
  int get hashCode => success.hashCode;
}

class LoginWithUsernameError extends LoginWithUsernameState {
  final String error;

  LoginWithUsernameError(this.error);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is LoginWithUsernameError && o.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

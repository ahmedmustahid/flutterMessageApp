import 'package:chat/models/user_model.dart';
import 'package:chat/repositories/user_repository.dart';
import 'package:riverpod/riverpod.dart';

class AllOtherUserNotifier extends StateNotifier<AllOtherUserState> {
  final UserRepository _userRepository;
  AllOtherUserNotifier(this._userRepository) : super(AllOtherUserInitial());

  Future<void> getAllOtherUser() async {
    try {
      List<UserModel> allOtherUser = await _userRepository.getAllOtherUser();
      state = AllOtherUserSuccess(allOtherUser);
    } catch (e) {
      print(e.toString());
      state = AllOtherUserError(e.toString());
    }
  }
}

abstract class AllOtherUserState {
  const AllOtherUserState();
}

class AllOtherUserInitial extends AllOtherUserState {
  const AllOtherUserInitial();
}

class AllOtherUserLoading extends AllOtherUserState {
  const AllOtherUserLoading();
}

class AllOtherUserSuccess extends AllOtherUserState {
  final List<UserModel> allOtherUser;

  AllOtherUserSuccess(this.allOtherUser);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is AllOtherUserSuccess && o.allOtherUser == allOtherUser;
  }

  @override
  int get hashCode => allOtherUser.hashCode;
}

class AllOtherUserError extends AllOtherUserState {
  final String error;

  AllOtherUserError(this.error);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is AllOtherUserError && o.error == error;
  }

  @override
  int get hashCode => error.hashCode;
}

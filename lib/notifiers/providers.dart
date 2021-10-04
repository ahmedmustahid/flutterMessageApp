import 'package:chat/models/user_model.dart';
import 'package:chat/notifiers/add_user_to_chat_room_notifier.dart';
import 'package:chat/notifiers/all_other_user_notifier.dart';
import 'package:chat/notifiers/chat_data_notifier.dart';
import 'package:chat/notifiers/login_with_username_password_notifier.dart';
import 'package:chat/notifiers/update_user_data_notifier.dart';
import 'package:chat/repositories/auth_repository.dart';
import 'package:chat/repositories/chat_repository.dart';
import 'package:chat/repositories/user_repository.dart';
import 'package:riverpod/riverpod.dart';

/// Auth repository
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryClass(),
);

/// User repository
final userRepositoryProvider = Provider<UserRepository>(
  (ref) => UserRepositoryClass(),
);

/// Chat repository
final chatRepositoryProvider = Provider<ChatRepository>(
  (ref) => ChatRepositoryClass(),
);

/// Login with Username Password Provider
final loginWithUsernameNotifierProvider = StateNotifierProvider(
  (ref) => LoginWithUsernameNotifier(ref.watch(authRepositoryProvider)),
);

final updateUserDataProvider = StateNotifierProvider(
  (ref) => UpdateUserDataNotifier(ref.watch(userRepositoryProvider)),
);

final addUserToChatRoomProvider = StateNotifierProvider(
  (ref) => AddUserToChatRoomNotifier(ref.watch(userRepositoryProvider)),
);

final chatDataProvider = StateNotifierProvider(
  (ref) => ChatDataNotifier(ref.watch(chatRepositoryProvider)),
);

final allOtherUserProvider = StateNotifierProvider(
  (ref) => AllOtherUserNotifier(ref.watch(userRepositoryProvider)),
);

/// Get Current User provider
final currUserProvider = Provider<UserModel>((ref) {
  var currUser = ref.watch(userRepositoryProvider).currUser;
  return currUser;
});

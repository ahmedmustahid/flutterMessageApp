import 'package:chat/components/secondary_button.dart';
import 'package:chat/notifiers/providers.dart';
import 'package:chat/services/get_it_service.dart';
import 'package:chat/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsernameButton extends ConsumerWidget {
  NavigationService _navigationService =
      get_it_instance_const<NavigationService>();

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return SecondaryButton(
        text: "Continue with Username",
        onPress: () async {
          context.read(loginWithUsernameNotifierProvider).login();
        });
  }
}

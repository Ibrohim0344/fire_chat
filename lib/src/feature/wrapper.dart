import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../common/models/user_model.dart';
import 'auth/register.dart';
import 'chat/chat_screen.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel?>();
    debugPrint(user.toString());
    return user == null ? const Register() : const ChatScreen();
  }
}

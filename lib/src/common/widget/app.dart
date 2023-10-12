import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../feature/auth/components/loading.dart';
import '../../feature/auth/register.dart';

import '../service/auth_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatProvider>(
      create: (context) => ChatProvider(),
      builder: (context, child) {
        return MaterialApp(
          home: StreamBuilder(
            stream: AuthService.user,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return const ChatScreen();
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Loading();
              }
              return const Register();
            },
          ),
        );
      },
    );
  }
}

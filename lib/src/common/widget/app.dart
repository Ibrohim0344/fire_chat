import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../feature/auth/components/loading.dart';
import '../../feature/auth/register.dart';
import '../../feature/chat/chat_screen.dart';
import '../../feature/chat/controller/chat_provider.dart';
import '../models/user_model.dart';
import '../service/auth_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatProvider>(
      create: (context) => ChatProvider(),
      builder: (context, child) {
        return StreamProvider.value(
          initialData: null,
          value: AuthService.user,
          child: MaterialApp(
            title: "Fire chat",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              splashFactory: NoSplash.splashFactory,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: StreamBuilder<UserModel?>(
              stream: AuthService.user,
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return const ChatScreen();
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Loading();
                }
                return const Register();
              },
            ),
          ),
        );
      },
    );
  }
}

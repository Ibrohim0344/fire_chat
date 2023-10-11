import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../feature/chat/controller/chat_provider.dart';
import '../../feature/wrapper.dart';
import '../service/auth_service.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatProvider>(
      create: (context) => ChatProvider(),
      builder: (context, child) {
        return StreamProvider.value(
          value: AuthService.user,
          initialData: null,
          child: MaterialApp(
            title: "Fire chat",
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              splashFactory: NoSplash.splashFactory,
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: const Wrapper(),
          ),
        );
      },
    );
  }
}

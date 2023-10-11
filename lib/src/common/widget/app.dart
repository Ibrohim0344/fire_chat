import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../feature/chat/chat_screen.dart';
import '../../feature/chat/controller/chat_provider.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatProvider>(
      create: (context) => ChatProvider(),
      builder: (context, child) {
        return MaterialApp(
          title: "Fire chat",
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            splashFactory: NoSplash.splashFactory,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const ChatScreen(),
        );
      },
    );
  }
}

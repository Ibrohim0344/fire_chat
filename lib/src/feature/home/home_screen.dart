import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../common/models/user_model.dart';
import '../../common/service/auth_service.dart';
import '../chat/chat_screen.dart';
import '../chat/data/user_repository.dart';
import 'components/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final UserRepository userRepository;

  @override
  void initState() {
    userRepository = const UserRepositoryImp();
    super.initState();
  }

  void openChatScreen(String uid) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ChatScreen(uid: uid),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1, 0);
          const end = Offset(0, 0);

          final tween = Tween(begin: begin, end: end).chain(
            CurveTween(curve: Curves.linear),
          );

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size(
            double.infinity,
            50,
          ),
          child: CustomLogOutAppBar()),
      body: FirebaseAnimatedList(
        query: userRepository.queryUsers(),
        itemBuilder: (context, snapshot, animation, index) {
          final user = UserModel.fromMap(
              Map<String, Object?>.from(snapshot.value as Map));
          return ListTile(
            onTap: () => openChatScreen(
              AuthService.currentUser!.uid + user.uid,
            ),
            title: Text(
              user.username ?? "",
            ),
          );
        },
      ),
    );
  }
}

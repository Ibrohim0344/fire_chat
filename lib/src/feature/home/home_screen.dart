import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import '../../common/constants/api_constants.dart';
import '../../common/constants/app_colors.dart';
import '../../common/models/user_model.dart';
import '../../common/service/auth_service.dart';
import '../chat/chat_screen.dart';
import '../chat/data/chat_repository.dart';
import '../chat/data/user_repository.dart';
import 'components/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final ChatRepository chatRepository;
  late final UserRepository userRepository;

  @override
  void initState() {
    chatRepository = IChatRepository();
    userRepository = const UserRepositoryImp();
    super.initState();
  }

  void openChatScreen(String uid) async {
    //myUserId+newId
    String chatIdBetween = "${AuthService.currentUser!.uid}$uid";
    bool isThere =
        await chatRepository.isWrote("${ApiConsts.allMessages}/$chatIdBetween");

    print("first================$isThere");
    if (!isThere) {
      isThere = await chatRepository.isWrote(
          "${ApiConsts.allMessages}/$uid${AuthService.currentUser!.uid}");
      if (isThere) {
        chatIdBetween = "$uid${AuthService.currentUser!.uid}";
      }
    }

    if (mounted) {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return ChatScreen(uid: chatIdBetween);
          },
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size(
          double.infinity,
          50,
        ),
        child: CustomAppBar(),
      ),
      body: FirebaseAnimatedList(
        query: userRepository.queryUsers(),
        itemBuilder: (context, snapshot, animation, index) {
          final user = UserModel.fromMap(
              Map<String, Object?>.from(snapshot.value as Map));
          return Column(
            children: [
              const Divider(
                color: AppColors.secondaryColor,
                indent: 18,
                endIndent: 18,
              ),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.primaries[index],
                ),
                onTap: () => openChatScreen(user.uid),
                title: Text(
                  user.username ?? "",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

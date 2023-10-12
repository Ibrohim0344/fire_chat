import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common/models/message_model.dart';
import '../../common/service/auth_service.dart';
import 'components/custom_message.dart';
import 'controller/chat_provider.dart';
import 'mixin/chat_mixin.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with ChatMixin {
  @override
  Widget build(BuildContext context) {
    final defineChat = context.watch<ChatProvider>().defineChat;

    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text("Are you sure"),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("No"),
                          ),
                          TextButton(
                            onPressed: () {
                              AuthService.signOut();
                              Navigator.pop(context);
                            },
                            child: const Text("Yes"),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.logout,
                color: Colors.red,
              ))
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 90),
              child: FirebaseAnimatedList(
                query: repository.queryChat(),
                reverse: true,
                sort: (a, b) {
                  final aValue = MessageModel.fromJson(
                    Map<String, Object?>.from(a.value as Map),
                  );

                  final bValue = MessageModel.fromJson(
                    Map<String, Object?>.from(b.value as Map),
                  );

                  return bValue.wroteAt.compareTo(aValue.wroteAt);
                },
                itemBuilder: (context, snapshot, animation, index) {
                  final messageModel = MessageModel.fromJson(
                    Map<String, Object?>.from(snapshot.value as Map),
                  );

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2,
                      horizontal: 5,
                    ),
                    child: Align(
                      alignment: messageModel.uid == 1
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                      child: GestureDetector(
                        onLongPress: () {
                          showModalBottomSheet(
                            backgroundColor: const Color(0xFFD2E0FB),
                            context: context,
                            builder: (context) {
                              return Padding(
                                padding: const EdgeInsets.all(20),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 120,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        onTap: () =>
                                            onEditSelected(messageModel),
                                        title: const Text("Edit"),
                                        trailing: const Icon(Icons.edit),
                                      ),
                                      const Spacer(),
                                      ListTile(
                                        onTap: () =>
                                            deleteMessage(messageModel.chatId),
                                        title: const Text("Delete"),
                                        trailing: const Icon(
                                          CupertinoIcons.delete_solid,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: CustomMessage(messageModel: messageModel),
                      ),
                    ),
                  );
                },
              ),
            ),
            Column(
              children: [
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  height: 90,
                  child: ColoredBox(
                    color: const Color(0xFFD2E0FB),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        child: TextField(
                          controller: controller,
                          decoration: InputDecoration(
                            fillColor: const Color(0xFFFFFFFF),
                            filled: true,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              onPressed: defineChat != null
                                  ? updateMessage
                                  : writeMessage,
                              icon: Icon(
                                defineChat != null
                                    ? Icons.done_outline_rounded
                                    : Icons.send,
                              ),
                              color: const Color(0xFF5B729F),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

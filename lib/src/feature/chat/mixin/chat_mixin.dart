import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../common/models/message_model.dart';
import '../chat_screen.dart';
import '../controller/chat_provider.dart';
import '../data/chat_repository.dart';

mixin ChatMixin on State<ChatScreen> {
  late final TextEditingController controller;
  late final ChatRepository repository;

  @override
  void initState() {
    controller = TextEditingController();
    repository = IChatRepository();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void writeMessage() {
    final message = MessageModel(
      message: controller.text.trim(),
    );

    if (controller.text.isNotEmpty) repository.writeMessage(message);
    controller.text = "";
  }

  void onEditSelected(MessageModel messageModel) {
    context.read<ChatProvider>().uploadMessage(messageModel);
    controller.clear();
    controller.text =
        Provider.of<ChatProvider>(context, listen: false).defineChat?.message ??
            "";
    Navigator.pop(context);
  }

  void updateMessage() {
    final message = MessageModel(
      chatId:
          Provider.of<ChatProvider>(context, listen: false).defineChat!.chatId,
      message: controller.text,
      isEdited: true,
      wroteAt:
          Provider.of<ChatProvider>(context, listen: false).defineChat!.wroteAt,
    );
    repository.updateMessage(message);
    context.read<ChatProvider>().updateDefineChat();
    controller.clear();
  }

  void deleteMessage(String id) {
    repository.deleteMessage(id);
    Navigator.pop(context);
  }
}

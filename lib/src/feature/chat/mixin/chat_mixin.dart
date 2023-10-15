import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../common/models/message_model.dart';
import '../../../common/service/auth_service.dart';
import '../chat_screen.dart';
import '../controller/chat_provider.dart';
import '../data/chat_repository.dart';

mixin ChatMixin on State<ChatScreen> {
  late final TextEditingController controller;
  late final ChatRepository repository;
  File? file;

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

  void writeMessage(String chatIdBetween) {
    final message = MessageModel(
      message: controller.text.trim(),
      uid: AuthService.currentUser!.uid,
    );
    if (controller.text.isNotEmpty) {
      repository.writeMessage(
        message,
        chatIdBetween,
      );
    }
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
      uid: AuthService.currentUser!.uid,
      chatId:
          Provider.of<ChatProvider>(context, listen: false).defineChat!.chatId,
      message: controller.text,
      isEdited: true,
      wroteAt:
          Provider.of<ChatProvider>(context, listen: false).defineChat!.wroteAt,
    );
    repository.updateMessage(message: message, chatId: widget.uid);
    context.read<ChatProvider>().updateDefineChat();
    controller.clear();
  }

  void deleteMessage(String id) {
    repository.deleteMessage(id);
    Navigator.pop(context);
  }

  Future<void> getMedia(MediaSource mediaSource) async {
    final pickedImage = await ImagePicker().pickImage(
      source: mediaSource.name == "camera"
          ? ImageSource.camera
          : ImageSource.gallery,
    );

    if (pickedImage != null) file = File(pickedImage.path);
  }
}

enum MediaSource {
  camera("camera"),
  gallery("gallery");

  const MediaSource(this.mediaSource);

  final String mediaSource;
}

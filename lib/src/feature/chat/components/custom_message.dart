import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/models/message_model.dart';
import '../../../common/service/auth_service.dart';

class CustomMessage extends StatelessWidget {
  final MessageModel messageModel;

  const CustomMessage({
    required this.messageModel,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: messageModel.uid == AuthService.currentUser!.uid
            ? AppColors.leftChat
            : AppColors.rightChat,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(15),
          bottomLeft: Radius.circular(
            messageModel.uid == AuthService.currentUser!.uid ? 0 : 15,
          ),
          topRight: const Radius.circular(15),
          bottomRight: Radius.circular(
            messageModel.uid == AuthService.currentUser!.uid ? 0 : 15,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          top: 5,
          right: 10,
          bottom: 5,
        ),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              messageModel.message,
              style: const TextStyle(color: AppColors.white),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 5,
                top: 10,
              ),
              child: Row(
                children: [
                  Text(
                    messageModel.isEdited ? "edited " : "",
                    style: const TextStyle(
                      fontSize: 8,
                      color: AppColors.white,
                    ),
                  ),
                  Text(
                    "${(messageModel.wroteAt.hour).toString().padLeft(2, "0")}:${(messageModel.wroteAt.minute).toString().padLeft(2, "0")}",
                    style: const TextStyle(
                      fontSize: 8,
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

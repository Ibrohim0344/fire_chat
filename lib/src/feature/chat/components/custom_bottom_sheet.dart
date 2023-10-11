// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// import '../../../common/models/message_model.dart';
//
// class CustomBottomSheet extends StatelessWidget {
//   const CustomBottomSheet({
//     required this.onEditSelected,
//     required this.messageModel,
//     required this.deleteMessage,
//     required this.chatId,
//     super.key,
//   });
//
//   final void Function(MessageModel messageModel) onEditSelected;
//   final MessageModel messageModel;
//   final void Function(String chatId) deleteMessage;
//   final String chatId;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(20),
//       child: SizedBox(
//         width: double.infinity,
//         height: 120,
//         child: Column(
//           children: [
//             ListTile(
//               onTap:() =>  onEditSelected(),
//               title: const Text("Edit"),
//               trailing: const Icon(Icons.edit),
//             ),
//             const Spacer(),
//             ListTile(
//               onTap: () => deleteMessage(chatId),
//               title: const Text("Delete"),
//               trailing: const Icon(
//                 CupertinoIcons.delete_solid,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

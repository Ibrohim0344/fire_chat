import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../../common/constants/api_constants.dart';
import '../../../common/models/message_model.dart';
import '../../../common/service/database_service.dart';

abstract interface class ChatRepository {
  DatabaseReference queryChat(String chatIdBetween);

  Stream<MessageModel> getAllMessage();

  Future<void> writeMessage(MessageModel message, String chatIdBetween);

  Future<void> deleteMessage(String id);

  Future<void> updateMessage(
      {required MessageModel message, required String chatId});

  Future<bool> isWrote(String path);
}

class IChatRepository implements ChatRepository {
  final DatabaseService _service;

  IChatRepository() : _service = const DatabaseService();

  @override
  Future<void> writeMessage(MessageModel message, String chatIdBetween) =>
      _service.create(
        dataPath: ApiConsts.allMessages,
        json: message.toJson(),
        chatIdBetween: chatIdBetween,
      );

  @override
  Future<void> updateMessage({
    required MessageModel message,
    required String chatId,
  }) =>
      _service.update(
        dataPath: "${ApiConsts.allMessages}/$chatId",
        id: message.chatId,
        json: message.toJson(),
      );

  @override
  Future<void> deleteMessage(String id) =>
      _service.delete(dataPath: ApiConsts.allMessages, id: id);

  @override
  Stream<MessageModel> getAllMessage() =>
      _service.readAllData(ApiConsts.usersPath).transform(
        StreamTransformer<DatabaseEvent, MessageModel>.fromHandlers(
          handleData: (data, sink) {
            for (final message in (data.snapshot.value as Map).values) {
              final json =
                  MessageModel.fromJson(Map<String, Object?>.from(message));
              sink.add(json);
            }
          },
        ),
      );

  @override
  DatabaseReference queryChat(String chatIdBetween) =>
      _service.queryFromPath("${ApiConsts.allMessages}/$chatIdBetween");

  @override
  Future<bool> isWrote(String path) async {
    return await _service.checkUsers(path);
  }
}

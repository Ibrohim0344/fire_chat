import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../../common/constants/api_constants.dart';
import '../../../common/models/message_model.dart';
import '../../../common/service/database_service.dart';

abstract interface class ChatRepository {
  DatabaseReference queryChat();

  Stream<MessageModel> getAllMessage();

  Future<void> writeMessage(MessageModel message);

  Future<void> deleteMessage(String id);

  Future<void> updateMessage(MessageModel message);
}

class IChatRepository implements ChatRepository {
  final DatabaseService _service;

  IChatRepository() : _service = const DatabaseService();

  @override
  Future<void> writeMessage(MessageModel message) =>
      _service.create(dataPath: ApiConsts.usersPath, json: message.toJson());

  @override
  Future<void> updateMessage(MessageModel message) => _service.update(
        dataPath: ApiConsts.usersPath,
        id: message.chatId,
        json: message.toJson(),
      );

  @override
  Future<void> deleteMessage(String id) =>
      _service.delete(dataPath: ApiConsts.usersPath, id: id);

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
  DatabaseReference queryChat() => _service.queryFromPath(ApiConsts.usersPath);
}

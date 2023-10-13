import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../../common/constants/api_constants.dart';
import '../../../common/models/user_model.dart';
import '../../../common/service/database_service.dart';

abstract interface class UserRepository {
  Future<void> addUser(UserModel user);

  Stream<UserModel> getAllUsers();

  DatabaseReference queryUsers();
}

class UserRepositoryImp implements UserRepository {
  final DatabaseService _service;

  const UserRepositoryImp() : _service = const DatabaseService();
  @override
  Future<void> addUser(UserModel user) =>
      _service.addUser(ApiConsts.usersPath, user.toJson());

  @override
  Stream<UserModel> getAllUsers() {
    return _service.readAllUsers().transform(
      StreamTransformer<DatabaseEvent, UserModel>.fromHandlers(
        handleData: (data, sink) {
          for (final user in (data.snapshot.value as Map).values) {
            final json = UserModel.fromMap(Map<String, Object?>.from(user));
            sink.add(json);
          }
        },
      ),
    );
  }

  @override
  DatabaseReference queryUsers() => _service.queryFromPath(ApiConsts.usersPath);
}

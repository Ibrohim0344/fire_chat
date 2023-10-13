import 'package:firebase_database/firebase_database.dart';

import '../constants/api_constants.dart';

class DatabaseService {
  const DatabaseService();

  static final _database = FirebaseDatabase.instance;

  Future<void> addUser(String dataPath, Map<String, Object?> json) =>
      _database.ref(dataPath).child(json["uid"] as String).set(json);

  Stream<DatabaseEvent> readAllUsers() =>
      _database.ref(ApiConsts.usersPath).onValue.asBroadcastStream();

  Stream<DatabaseEvent> readAllData(String dataPath) =>
      _database.ref(dataPath).onValue.asBroadcastStream();

  DatabaseReference queryFromPath(String dataPath) => _database.ref(dataPath);

  Future<void> create(
      {required String dataPath, required String chatIdBetween, required Map<String, Object?> json}) async {
    final id = _database.ref("$dataPath/$chatIdBetween").push().key;
    json["chat_id"] = id;

    await _database
        .ref(dataPath)
        .child(chatIdBetween)
        .child(id!)
        .set(json);
  }

  Future<void> update({
    required String dataPath,
    required String id,
    required Map<String, Object?> json,
  }) =>
      _database.ref(dataPath).child(id).update(json);

  Future<void> delete({required String dataPath, required String id}) =>
      _database.ref(dataPath).child(id).remove();
}

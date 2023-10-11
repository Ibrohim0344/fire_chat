import 'package:firebase_database/firebase_database.dart';

class DatabaseService {
  const DatabaseService();

  static final _database = FirebaseDatabase.instance;

  Stream<DatabaseEvent> readAllData(String dataPath) =>
      _database.ref(dataPath).onValue.asBroadcastStream();

  DatabaseReference queryFromPath(String dataPath) => _database.ref(dataPath);

  Future<void> create(
      {required String dataPath, required Map<String, Object?> json}) async {
    final id = _database.ref(dataPath).push().key;
    json["chat_id"] = id;

    await _database.ref(dataPath).child(id!).set(json);
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

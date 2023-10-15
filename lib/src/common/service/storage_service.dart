import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import '../models/file_store_state.dart';

class StorageService {
  const StorageService();

  static final _storage = FirebaseStorage.instance;

  void storeImage({
    required String path,
    required String fileName,
    required File file,
    required Sink<StorageState> sink,
  }) {
    final metadata = SettableMetadata(contentType: "image/jpeg");

    final storageRef = _storage.ref();

    final uploadTask =
        storageRef.child("images/$path/$fileName").putFile(file, metadata);

    uploadTask.snapshotEvents.listen((TaskSnapshot taskSnapshot) async {
      switch (taskSnapshot.state) {
        case TaskState.running:
          final progress =
              taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;

          print("Progress: $progress");

          sink.add(StorageState.loading(progress: progress));
        case TaskState.success:
          final link = await uploadTask
              .then<String>((task) => task.ref.getDownloadURL());

          print(link);

          sink.add(StorageState.success(link: link));
        default:
          sink.add(
            const StorageState.error(
                message: "Something went wrongn\nPlease try again"),
          );
      }
    });
  }
}

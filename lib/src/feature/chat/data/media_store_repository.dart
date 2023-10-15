import 'dart:io';

import '../../../common/models/file_store_state.dart';
import '../../../common/service/storage_service.dart';

abstract interface class IMediaRepository {
  void uploadImage({
    required String fileName,
    required File file,
    required Sink<StorageState> sink,
  });
}

class MediaRepository implements IMediaRepository {
  MediaRepository() : _service = const StorageService();

  final StorageService _service;

  @override
  void uploadImage({
    required String fileName,
    required File file,
    required Sink<StorageState> sink,
  }) =>
      _service.storeImage(
        path: "${DateTime.now().year}-"
            "${DateTime.now().month.toString().padLeft(2, "0")}-"
            "${DateTime.now().day.toString().padLeft(2, "0")}",
        fileName: fileName,
        file: file,
        sink: sink,
      );
}

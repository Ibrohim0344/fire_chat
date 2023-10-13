import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  StorageService() {
    getStorageInstance();
  }
   late final SharedPreferences sharedPreferences;

  Future<void> getStorageInstance() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static const myUserId = "my_id";

  
}

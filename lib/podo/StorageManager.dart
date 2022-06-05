import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:localstorage/localstorage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  /// eg:theme
  static late SharedPreferences sharedPreferences;

  /// eg: cookie
  static late Directory temporaryDirectory;

  ///  eg:user
  static late LocalStorage localStorage;

  static init() async {
    print('Storage init');
    temporaryDirectory = await getTemporaryDirectory();
    sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage('LocalStorage');
    await localStorage.ready;
  }
}

// ignore_for_file: file_names

import 'dart:io';
import 'package:musicplatform/podo/FavouriteModel.dart';
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
    temporaryDirectory = await getTemporaryDirectory();
    sharedPreferences = await SharedPreferences.getInstance();
    localStorage = LocalStorage('LocalStorage');
    await localStorage.ready.onError((error, stackTrace) {
      localStorage.clear();
      return false;
    });
  }
}

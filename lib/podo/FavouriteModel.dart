import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/podo/StorageManager.dart';

const String kLocalStorageSearch = 'kLocalStorageSearch';
const String kFavoriteList = 'kFavoriteList';

class Favourites extends ChangeNotifier {
  List<int> favourites = [];
  List<Song> _favouriteSongs = [];
  List<Song> get favouriteSongs => _favouriteSongs;
  bool _init = false;

  setFavouriteSongs() {
    List<Song> tempList = [];
    for (var element in favourites) {
      tempList.add(getSong(element));
    }
    _favouriteSongs = tempList;
    notifyListeners();
  }

  init() {
    LocalStorage localStorage = StorageManager.localStorage;
    favourites = (localStorage.getItem(kFavoriteList) ?? []);
    _init = true;
  }

  Favourites() {
    init();
    _init = true;
  }

  collect(int id) async {
    if (!_init) {
      print('Shouldnt be empty');
    }
    if (favourites.contains(id)) {
      favourites.remove(id);
    } else {
      favourites.add(id);
    }
    saveData();
    setFavouriteSongs();
  }

  bool checkFavourite(int id) {
    if (favourites.contains(id)) {
      return true;
    } else {
      return false;
    }
  }

  saveData() {
    StorageManager.localStorage.setItem(kFavoriteList, favourites);
  }
}

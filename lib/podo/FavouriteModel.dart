// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/podo/StorageManager.dart';
import 'TempData.dart';

const String kLocalStorageSearch = 'kLocalStorageSearch';
const String kFavoriteList = 'kFavoriteList';
const String kFavoriteAlbums = 'kFavoriteAlbums';
const String kFavoritePlaylist = 'kFavoritePlaylist';
const String kFollowedArtists = 'kFollowedArtists';

class Favourites extends ChangeNotifier {
  List<int> favorites = [];
  List<int> favoriteAlbums = [];
  List<int> favoritePlaylists = [];
  List<int> followedArtists = [];
  List<Song> _favouriteSongs = [];
  List<Song> get favouriteSongs => _favouriteSongs;
  bool _init = false;

  setFavouriteSongs() {
    List<Song> tempList = [];
    for (var element in favorites) {
      Database().getSong(element).then((value) => tempList.add(value));
    }
    _favouriteSongs = tempList;
    notifyListeners();
  }

  init() {
    var localStorage = StorageManager.sharedPreferences;
    List _favourites = (localStorage.getStringList(kFavoriteList) ?? []);
    List _favoriteAlbums = (localStorage.getStringList(kFavoriteAlbums) ?? []);
    List _favoritePlaylists =
        (localStorage.getStringList(kFavoritePlaylist) ?? []);
    List _followedArtists =
        (localStorage.getStringList(kFollowedArtists) ?? []);
    _favourites.map((e) => favorites.add(int.parse(e)));
    _favoriteAlbums.map((e) => _favoriteAlbums.add(int.parse(e)));
    _favoritePlaylists.map((e) => _favoritePlaylists.add(int.parse(e)));
    _followedArtists.map((e) => _followedArtists.add(int.parse(e)));
    _init = true;
  }

  Favourites() {
    init();
    _init = true;
  }

  collect(int id) async {
    if (!_init) {
      init();
    }
    if (favorites.contains(id)) {
      favorites.remove(id);
    } else {
      favorites.add(id);
    }
    saveData();
    setFavouriteSongs();
  }

  bool checkFavourite(int id) {
    if (favorites.contains(id)) {
      return true;
    } else {
      return false;
    }
  }

  saveData() {
    List<String> _favorites =
        List.generate(favorites.length, (index) => favorites[index].toString());
    List<String> _favoriteAlbums = List.generate(
        favoriteAlbums.length, (index) => favoriteAlbums[index].toString());
    List<String> _favoritePlaylists = List.generate(favoritePlaylists.length,
        (index) => favoritePlaylists[index].toString());
    List<String> _followedArtists =
        List.generate(followedArtists.length, (index) => [index].toString());
    var localStorage = StorageManager.sharedPreferences;
    localStorage.setStringList(kFavoriteList, _favorites);
    localStorage.setStringList(
      kFavoriteAlbums,
      _favoriteAlbums,
    );
    localStorage.setStringList(kFavoritePlaylist, _favoritePlaylists);
    localStorage.setStringList(
      kFollowedArtists,
      _followedArtists,
    );
  }
}

fromStringListtoIntList(List<String> list) {
  return (list
      .map((e) => {
            'key': e,
          })
      .toList());
}

class SelfConverter {
  List<String> list;
  SelfConverter(this.list);
  List<Map<String, dynamic>> toJson() {
    return (list
        .map((e) => {
              'key': e,
            })
        .toList());
  }
}

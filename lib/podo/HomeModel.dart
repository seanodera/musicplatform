// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/podo/TempData.dart';

class HomeModel extends ChangeNotifier {
  List<Album> _albums = [];
  List<Playlist> _topPlaylist = [];
  List<Song> _forYou = [];
  List<Genre> _genres = [];
  List<Album> get albums => _albums;
  List<Song> get forYou => _forYou;
  List<Playlist> get topPlaylist => _topPlaylist;
  List<Genre> get genres => _genres;
  Database database = Database();
  HomeModel() {
    init();
  }
  init() async {
    _genres = await database.getGenres();
    _albums = await database.getTopAlbums();
    _topPlaylist = await database.getTopPlayList();
    _forYou = await database.getRecomended();
    notifyListeners();
  }
}

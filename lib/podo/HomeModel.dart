import 'package:flutter/material.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/podo/TempData.dart';

class HomeModel extends ChangeNotifier {
  List<Album> _albums = [];
  List<Playlist> _topPlaylist = [];
  List<Song> _forYou = [];
  List<Album> get albums => _albums;
  List<Song> get forYou => _forYou;
  List<Playlist> get topPlaylist => _topPlaylist;

  Database database = Database();
  HomeModel() {
    init();
  }
  init() async {
    _albums = await database.getTopAlbums();
    _topPlaylist = await database.getTopPlayList();
  }
}

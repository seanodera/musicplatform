// ignore_for_file: file_names

import 'package:musicplatform/podo/Player.dart';
import 'package:musicplatform/podo/StorageManager.dart';

import 'Models.dart';
import 'package:flutter/material.dart';

import 'TempData.dart';

class ProviderModel extends ChangeNotifier {
  int _currentPos = 0;
  late Player player = Player();

  Song _currentSong = Song(
      id: 0,
      artistId: 0,
      albumId: 0,
      artist: '',
      album: '',
      cover:
          'https://images.unsplash.com/photo-1433888104365-77d8043c9615?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2073&q=80',
      duration: const Duration(seconds: 0),
      title: '',
      url: '');

  ProviderModel() {
    var ss = StorageManager.sharedPreferences;
    List<String> _idOrder = (ss.getStringList('kLastQueueOrder') ?? []);
    int _lastPos = (ss.getInt('kLastPos') ?? 0);
    _idOrder.forEach((element) async {
      Song song = await Database().getSong(int.parse(element));
      queue.add(song);
    });
    currentPos = _lastPos;
  }

  List<Song> _queue = [];
  List<Song> _recentlyPlayed = [];
  Song get currentSong => _currentSong;

  set currentSong(Song song) {
    _currentSong = song;
  }

  int get currentPos => _currentPos;
  set currentPos(int pos) {
    _currentPos = pos;
    notifyListeners();
  }

  List<Song> addToRecents(Song song) {
    _recentlyPlayed.add(song);
    notifyListeners();
    List<String> recents = [];
    _recentlyPlayed.map((e) => recents.add(e.id.toString()));
    StorageManager.sharedPreferences.setStringList('kRecentlyPlayed', recents);
    return _recentlyPlayed;
  }

  List<Song> get recentlyPlayed => _recentlyPlayed;

  set recentlyPlayed(List<Song> recentlyPlayed) {
    _recentlyPlayed = recentlyPlayed;
    notifyListeners();
  }

  List<Song> addToQueue(Song song) {
    queue.add(song);
    notifyListeners();
    return _queue;
  }

  List<Song> get queue => _queue;

  set queue(List<Song> queue) {
    _queue = queue;
    notifyListeners();
  }
}

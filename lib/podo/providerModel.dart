import 'dart:collection';
import 'Models.dart';
import 'package:flutter/material.dart';

class ProviderModel extends ChangeNotifier {
  int _currentPos = 0;
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

  List<Song> _queue = [];
  Song get currentSong => _currentSong;

  set currentSong(Song song) {
    _currentSong = song;
    print(_currentSong.cover);
  }

  int get currentPos => _currentPos;
  set currentPos(int pos) {
    _currentPos = pos;
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

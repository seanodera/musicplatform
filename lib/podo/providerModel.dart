import 'Models.dart';
import 'package:flutter/material.dart';

class ProviderModel extends ChangeNotifier {
  Song _currentSong = Song(
      id: 0,
      artistId: 0,
      albumId: 0,
      artist: '',
      album: '',
      cover: '',
      duration: const Duration(seconds: 0),
      title: '');

  Song get currentSong => _currentSong;

  set currentSong(Song song) {
    _currentSong = song;
  }
}

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:musicplatform/podo/providerModel.dart';
import 'package:musicplatform/podo/songsModels.dart';
import 'package:provider/provider.dart';

class Player extends ChangeNotifier {
  BuildContext context;
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool paused = false;
  Player(this.context);
  void playSong(Song song) {
    ProviderModel providerModel =
        Provider.of<ProviderModel>(context, listen: false);
    providerModel.currentSong = song;
    audioPlayer.play(song.url, isLocal: false);
    notifyListeners();
  }

  pausePlayer() {
    if (paused) {
      audioPlayer.resume();
      paused = false;
    } else {
      audioPlayer.pause();
      paused = true;
    }
    notifyListeners();
  }

  void destroyPlayer() {}
  void nextSong() {
    ProviderModel providerModel = Provider.of<ProviderModel>(context);
    providerModel.currentPos = (providerModel.currentPos++);
    providerModel.currentSong =
        providerModel.queue.elementAt(providerModel.currentPos);
    audioPlayer.pause();
    audioPlayer.play(providerModel.currentSong.url, isLocal: false);
    notifyListeners();
  }
}

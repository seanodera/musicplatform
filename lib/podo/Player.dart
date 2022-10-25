import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'Models.dart';
import 'StorageManager.dart';
import 'providerModel.dart';

class Player extends ChangeNotifier {
  AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);
  bool paused = false, repeatQueu = false, repeatSong = false, shuffle = false;

  List<int> idOrder = [];
  Player() {
    var ss = StorageManager.sharedPreferences;
    repeatQueu = ss.getBool('krepeatQ') ?? false;
    repeatSong = ss.getBool('krepeatSong') ?? false;
    shuffle = ss.getBool('kshuffle') ?? false;
    (ss.getStringList('kpreShuffleIdOrder') ?? [])
        .map((e) => idOrder.add(int.parse(e)));
  }

  void destroyPlayer(ProviderModel providerModel) {
    List<String> _idOrder = [];
    List<String> idOrderStringFrom = []; // actual Order
    providerModel.queue.map((e) => _idOrder.add(e.id.toString()));
    idOrder.map((e) => idOrderStringFrom.add(e.toString()));
    var ss = StorageManager.sharedPreferences;
    ss.setInt('kLastPos', providerModel.currentPos);
    ss.setStringList('kLastQueueOrder', _idOrder);
    ss.setStringList('kpreShuffleIdOrder', idOrderStringFrom);
    ss.setBool('krepeatQ', repeatQueu);
    ss.setBool('krepeatSong', repeatSong);
    ss.setBool('kshuffle', shuffle);
    audioPlayer.dispose();
  }

  void playSong(Song song, ProviderModel providerModel) {
    audioPlayer.stop();
    providerModel.currentSong = song;
    audioPlayer.play(song.url, isLocal: false, volume: 2.0);
    providerModel.addToRecents(song);
    print(providerModel.queue);
    audioPlayer.onPlayerCompletion.listen((event) {
      audioPlayer.play(providerModel.currentSong.url,
          isLocal: false, volume: 2.0);
      if (!repeatSong) {
        // nextSong();

      }
    });
    audioPlayer.onDurationChanged.listen(
      (event) {
        if (providerModel.currentSong.duration == event && !repeatSong) {
          // nextSong();
        }
      },
    );

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

  void changeShuffle(ProviderModel providerModel) {
    if (shuffle) {
      shuffle = false;
      List<Song> currentQueue = providerModel.queue;
      int currentSongId = currentQueue[providerModel.currentPos].id;
      int newPos =
          currentQueue.indexWhere((element) => element.id == currentSongId);
      List<Song> newQueue = [];
      for (var element in idOrder) {
        newQueue.add(
            currentQueue.singleWhere((element) => element.id == currentSongId));
      }
      providerModel.currentPos = newPos;
      providerModel.queue = newQueue;
    } else {
      shuffle = true;
      setShuffle(providerModel);
    }
  }

  void setShuffle(ProviderModel providerModel) {
    if (shuffle) {
      shuffle = true;
      List<Song> currentQueue = providerModel.queue;
      List<Song> remainingQueue =
          currentQueue.sublist(providerModel.currentPos + 1);
      remainingQueue.map((e) => idOrder.add(e.id));
      List<Song> newQueue = currentQueue.sublist(0, providerModel.currentPos);
      remainingQueue.shuffle();
      newQueue.addAll(remainingQueue);
      providerModel.queue = newQueue;
    }
  }

  void previousSong(ProviderModel providerModel) {
    audioPlayer.pause();
    int currentPos = providerModel.currentPos;
    if (currentPos == 0) {
      providerModel.currentPos = providerModel.queue.length;
    }
    providerModel.currentSong =
        providerModel.queue.elementAt(providerModel.currentPos);
    audioPlayer.play(providerModel.currentSong.url, isLocal: false);
    notifyListeners();
  }

  void nextSong(ProviderModel providerModel) {
    audioPlayer.pause();
    int currentPos = providerModel.currentPos;

    if (providerModel.queue.length == currentPos && repeatQueu) {
      currentPos = 0;
      providerModel.currentPos = 0;
    } else {
      providerModel.currentPos = (currentPos + 1);
    }
    print('current pos is ' +
        providerModel.currentPos.toString() +
        'The length is ' +
        providerModel.queue.length.toString());
    providerModel.currentSong =
        providerModel.queue.elementAt(providerModel.currentPos);

    audioPlayer.play(providerModel.currentSong.url, isLocal: false);
    notifyListeners();
  }
}

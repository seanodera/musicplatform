import 'package:flutter/material.dart';

import 'songsModels.dart';
import 'paymentModels.dart';
import 'userModels.dart';
export 'songsModels.dart';
export  'paymentModels.dart';
export 'userModels.dart';

getSong(int id){

}

getAlbum(int id){}

getArtist(int id){}

getPlaylist(int id){}

createPlaylist(FileImage image,String name, String description, List<Song>? songs){
  int playlistId = 0;
  if (songs != null){
    addSongToPlaylist(playlistId, songs);
  }
}

addSongToPlaylist(int playlistId, List<Song> songs){

}

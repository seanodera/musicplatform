import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import 'songsModels.dart';
import 'paymentModels.dart';
import 'userModels.dart';
export 'songsModels.dart';
export 'paymentModels.dart';
export 'userModels.dart';

class RecentlyPlayed {
  String type;
  dynamic object;

  RecentlyPlayed({required this.type, required this.object});
}

nextPage({required BuildContext context, required Widget widget}) {
  print('going next page');
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Consumer(
            builder: (a, b, c) => widget,
          )));
}

getSong(int id) {}

getAlbum(int id) {}

getArtist(int id) {}

Future<bool> checkFavorite(int id) async {
  List<int> songIds = [];
  if (songIds.contains(id)) {
    return true;
  } else {
    return false;
  }
}

getPlaylist(int id) {}

createPlaylist(
    FileImage image, String name, String description, List<Song>? songs) {
  int playlistId = 0;
  if (songs != null) {
    addSongToPlaylist(playlistId, songs);
  }
}

addSongToPlaylist(int playlistId, List<Song> songs) {}

Future<Color> getColorFromImage(ImageProvider image) async {
  PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(image);
  var dominantColor = paletteGenerator.dominantColor;
  if (dominantColor == null) {
    return Colors.redAccent.shade400;
  } else {
    return dominantColor.color;
  }
}

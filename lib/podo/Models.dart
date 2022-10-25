// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import 'songsModels.dart';
export 'songsModels.dart';
export 'paymentModels.dart';
export 'userModels.dart';

class RecentlyPlayed {
  String type;
  dynamic object;

  RecentlyPlayed({required this.type, required this.object});
}

nextPage({required BuildContext context, required Widget widget}) {
  Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => Consumer(
            builder: (a, b, c) => widget,
          )));
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

Future<PaletteGenerator> getColorFromImage(ImageProvider image) async {
  PaletteGenerator paletteGenerator =
      await PaletteGenerator.fromImageProvider(image);

  return paletteGenerator;
}

Future<PaletteGenerator> getColorFromImageBottom(ImageProvider image) async {
  PaletteGenerator paletteGenerator = await PaletteGenerator.fromImageProvider(
      image,
      region: Offset.zero & const Size(1, 100),
      size: const Size(100, 100));

  return paletteGenerator;
}

String monthToString(int month) {
  switch (month) {
    case DateTime.december:
      return 'December';
    case DateTime.november:
      return 'Novemeber';
    case DateTime.october:
      return 'October';
    case DateTime.september:
      return 'September';
    case DateTime.august:
      return 'August';
    case DateTime.july:
      return 'July';
    case DateTime.june:
      return 'June';
    case DateTime.may:
      return 'May';
    case DateTime.april:
      return 'April';
    case DateTime.march:
      return 'March';
    case DateTime.february:
      return 'February';
    case DateTime.january:
      return 'January';
    default:
      return 'Invalid';
  }
}

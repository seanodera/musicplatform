// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/screens/AlbumView.dart';

class AlbumWidget extends StatelessWidget {
  final Album album;
  const AlbumWidget({Key? key, required this.album}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      child: SizedBox(
        width: (size.width / 2.5) - 40,
        child: Column(
          children: [
            Image.network(
              album.art,
              width: (size.width / 2.5) - 40,
              height: (size.width / 2.5) - 40,
              fit: BoxFit.contain,
            ),
            Text(album.name),
            Text('Album . ' + album.artistName),
          ],
        ),
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AlbumPage(
                id: album.id,
              ))),
    );
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/screens/PlayListView.dart';

class PlaylistWidget extends StatelessWidget {
  final Playlist playList;

  const PlaylistWidget({Key? key, required this.playList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String art =
        'https://images.unsplash.com/photo-1602848597239-b63398805e3f?crop=entropy&cs=tinysrgb&fm=jpg&ixlib=rb-1.2.1&q=80&raw_url=true&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1475';
    return InkWell(
      child: SizedBox(
        width: (size.width / 2.5) - 40,
        child: Column(
          children: [
            Image.network(
              (playList.picture != '') ? playList.pictureBig : art,
              width: (size.width / 2.5) - 40,
              height: (size.width / 2.5) - 40,
              fit: BoxFit.contain,
            ),
            Text(playList.title),
            Text('Album . ' + playList.user.name),
          ],
        ),
      ),
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => PlaylistView(playList: playList))),
    );
  }
}

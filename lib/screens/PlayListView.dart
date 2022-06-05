import 'dart:math';

import 'package:flutter/material.dart';
import 'package:musicplatform/components/MiniPlayer.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/podo/providerModel.dart';
import 'package:provider/provider.dart';

import '../components/SongWidget.dart';

class PlaylistView extends StatefulWidget {
  final Playlist playList;
  const PlaylistView({Key? key, required this.playList}) : super(key: key);

  @override
  State<PlaylistView> createState() => _PlaylistViewState();
}

class _PlaylistViewState extends State<PlaylistView> {
  bool fav = Random().nextBool();
  @override
  Widget build(BuildContext context) {
    Playlist playlist = widget.playList;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            flexibleSpace: Container(
              alignment: Alignment.center,
              child: Image.network(
                playlist.pictureBig,
                height: 300,
                width: 300,
                fit: BoxFit.contain,
              ),
            ),
            title: Text(playlist.title),
            bottom: PreferredSize(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => nextPage(context: context, widget: widget),
                    child: Text(playlist.user.name),
                  ),
                  Text('Playlist . ' + playlist.creationDate),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: (fav)
                            ? const Icon(
                                Icons.favorite,
                              )
                            : const Icon(Icons.favorite_border),
                      ),
                      IconButton(
                        icon: const Icon(Icons.more_horiz),
                        onPressed: () {},
                      )
                    ],
                  )
                ],
              ),
              preferredSize: Size(MediaQuery.of(context).size.width, 80),
            ),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  (context, index) => SongWidget(
                        key: Key(index.toString()),
                        song: playlist.songs[index],
                        onTap: () {},
                        index: index,
                        othersongs: playlist.songs,
                      ),
                  childCount: playlist.songs.length)),
        ],
      ),
      bottomNavigationBar: Consumer<ProviderModel>(
        builder: (context, providerModel, widget) => MiniPlayer(
          providerModel: providerModel,
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:musicplatform/components/MiniPlayer.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/podo/providerModel.dart';
import 'package:palette_generator/palette_generator.dart';
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
  PaletteGenerator? paletteGenerator;
  Color? backgroundColor = Colors.redAccent.shade400;
  List<Color> bottomColor = [Colors.red.shade400];
  late ImageProvider image;
  bool _filterPlaylist = false;
  @override
  void initState() {
    image = NetworkImage(widget.playList.pictureXl);
    init() async {
      paletteGenerator = await getColorFromImage(image);
      backgroundColor = paletteGenerator!.dominantColor!.color;
      var _pal = await getColorFromImageBottom(image);
      bottomColor = List.generate(_pal.paletteColors.length, (index) {
        return _pal.paletteColors.elementAt(index).color;
      });
      setState(() {});
    }

    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Playlist playlist = widget.playList;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: (_filterPlaylist) ? Text('Showed') : Material(),
          ),
          SliverAppBar(
            backgroundColor: backgroundColor,
            pinned: true,
            stretch: false,
            floating: false,
            snap: false,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              background: Container(
                alignment: Alignment.center,
                child: Image(
                  image: image,
                  height: size.width,
                  width: size.width,
                  fit: BoxFit.contain,
                ),
              ),
              title: Text(playlist.title),
              centerTitle: false,
            ),
            // title: Text(playlist.title),
            centerTitle: false,
            elevation: 25,
            expandedHeight: size.width - 50,
            stretchTriggerOffset: size.width - 10,
            onStretchTrigger: () async {
              setState(() {
                _filterPlaylist = true;
              });
            },
          ),
          SliverToBoxAdapter(
            child: Material(
              color: Colors.transparent,
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  bottomColor.last,
                  Theme.of(context).backgroundColor
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {},
                      child: Text(
                        playlist.user.name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    Text(
                      'Playlist . ' + playlist.creationDate,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
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
              ),
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

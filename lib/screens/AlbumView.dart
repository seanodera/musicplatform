import 'dart:math';

import 'package:flutter/material.dart';
import 'package:musicplatform/components/LoadingWidgets.dart';
import 'package:musicplatform/components/SongWidget.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/podo/TempData.dart';
import 'package:palette_generator/palette_generator.dart';

class AlbumPage extends StatefulWidget {
  final int id;
  final Album? album;
  const AlbumPage({
    Key? key,
    required this.id,
    this.album,
  }) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  Color? mainColor;
  late Album album;
  bool loaded = false;
  PaletteGenerator? paletteGenerator;
  late ImageProvider image;
  List<Color> bottomColor = [Colors.redAccent.shade400];
  late Duration length;
  @override
  void initState() {
    loaded = false;

    init() async {
      album = await Database().getAlbum(widget.id);
      image = NetworkImage(album.art);
      paletteGenerator = await getColorFromImage(image);
      mainColor = paletteGenerator!.dominantColor!.color;
      var _pal = await getColorFromImageBottom(image);
      bottomColor = List.generate(_pal.paletteColors.length, (index) {
        return _pal.paletteColors.elementAt(index).color;
      });
      int durationSeconds = 0;
      album.songs.map((e) {
        durationSeconds += e.duration.inSeconds;
      });
      length = Duration(seconds: durationSeconds);

      loaded = true;
      setState(() {});
    }

    init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool fav = Random().nextBool();
    Size size = MediaQuery.of(context).size;
    return (!loaded)
        ? LoadingScreen(color: Colors.redAccent.shade400)
        : CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: paletteGenerator!.dominantColor!.color,
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
                  title: Text(album.name),
                  centerTitle: false,
                ),
                // title: Text(playlist.title),
                centerTitle: false,
                elevation: 25,
                expandedHeight: size.width - 50,
              ),
              SliverToBoxAdapter(
                child: Material(
                  color: Colors.transparent,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [
                          bottomColor.last,
                          Theme.of(context).backgroundColor
                        ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            album.artistName,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                        Text(
                          'Playlist . ' + album.releaseDate.year.toString(),
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: (fav)
                                  ? Icon(
                                      Icons.favorite,
                                      color: bottomColor.last,
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
                      (context, index) => Material(
                            child: SongWidget(
                              key: Key(index.toString()),
                              song: album.songs[index],
                              onTap: () {},
                              index: index,
                              othersongs: album.songs,
                            ),
                          ),
                      childCount: album.songs.length)),
              SliverToBoxAdapter(
                child: Material(
                  child: Column(
                    children: [
                      Text(monthToString(album.releaseDate.month) +
                          ' ' +
                          album.releaseDate.day.toString() +
                          ', ' +
                          album.releaseDate.year.toString()),
                      Text(album.songs.length.toString() +
                          ' songs .  ' +
                          produceStringFromDuration(length))
                    ],
                  ),
                ),
              )
            ],
          );
  }
}

String produceStringFromDuration(Duration duration) {
  List<String> string = [];
  int minutes = 0;
  int _minutes = 0;
  int seconds = 0;
  int hours = 0;
  if (Duration.minutesPerHour >= duration.inMinutes) {
    hours = (duration.inMinutes / Duration.minutesPerHour).truncate();
    minutes = duration.inMinutes - (hours * 60);
  }

  if (Duration.secondsPerMinute >= duration.inSeconds) {
    _minutes = (duration.inSeconds / Duration.secondsPerMinute).truncate();
    seconds = duration.inSeconds - (minutes * Duration.secondsPerMinute);
  }
  if (minutes != _minutes) {
    debugPrint('Math aint Mathing');
  }
  if (hours > 0) {
    string.add(hours.toString() + ' hr');
  }
  if (minutes > 0) {
    string.add(minutes.toString() + ' min');
  }
  if (seconds > 0) {
    string.add(seconds.toString() + ' sec');
  }
  String compiled = '';
  for (var element in string) {
    compiled = compiled + element + '';
  }
  return compiled;
}

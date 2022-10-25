import 'package:flutter/material.dart';
import 'package:musicplatform/podo/FavouriteModel.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/podo/Player.dart';
import 'package:musicplatform/podo/providerModel.dart';
import 'package:musicplatform/screens/AlbumView.dart';
import 'package:palette_generator/palette_generator.dart';

class PlayScreen extends StatefulWidget {
  final ProviderModel providerModel;
  final Favourites favourites;
  const PlayScreen(
      {Key? key, required this.providerModel, required this.favourites})
      : super(key: key);

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen>
    with AutomaticKeepAliveClientMixin {
  bool fav = false, shuffle = false, repeat = false;
  late Song currentSong;
  PaletteColor? color;
  late Player player;
  List<PaletteColor> colors = [];
  late ImageProvider image;
  Duration currentDuration = const Duration(seconds: 0),
      fullLength = const Duration(seconds: 0);
  int duration = 0, currentPosition = 0;
  @override
  void initState() {
    super.initState();

    player = widget.providerModel.player;
    currentSong = widget.providerModel.currentSong;
    image = NetworkImage(currentSong.cover);

    init() async {
      var pal = await getColorFromImage(image);
      colors = pal.paletteColors;
      color =
          (pal.vibrantColor == null) ? pal.paletteColors[0] : pal.vibrantColor!;
      duration = await player.audioPlayer.getDuration();
      fullLength = Duration(seconds: duration);

      init();

      fav = widget.favourites.checkFavourite(currentSong.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ThemeData theme = Theme.of(context);
    player.audioPlayer.onAudioPositionChanged.listen((event) {
      currentDuration = event;
      setState(() {});
    });
    player.audioPlayer.onDurationChanged.listen((event) {
      fullLength = event;
      setState(() {});
    });
    return Material(
        color: color?.color,
        child: Scaffold(
          // backgroundColor:
          //     Theme.of(context).colorScheme.background.withAlpha(220),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  size: 34,
                )),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: size.width - 40,
                  height: size.width - 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(currentSong.cover),
                        fit: BoxFit.contain),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                Text(
                  currentSong.title,
                  style: theme.textTheme.bodyLarge,
                ),
                Text(
                  currentSong.artist,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: (fav)
                            ? const Icon(
                                Icons.favorite,
                              )
                            : const Icon(Icons.favorite_border)),
                    Column(
                      children: [],
                    )
                  ],
                ),
                LinearProgressIndicator(
                  value: currentDuration.inMicroseconds /
                      const Duration(seconds: 30).inMicroseconds,
                  color: (colors.isEmpty) ? null : colors.first.color,
                  valueColor: AlwaysStoppedAnimation<Color>((colors.isEmpty)
                      ? Colors.redAccent.shade400
                      : colors.first.color),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(currentDuration.inMinutes.toString() +
                        ':' +
                        currentDuration.inSeconds.toString()),
                    Text(produceStringFromDuration(fullLength))
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon((shuffle)
                            ? Icons.shuffle_on
                            : Icons.shuffle_outlined)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.skip_previous_outlined)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.play_circle_fill_outlined)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.skip_next_outlined)),
                    IconButton(
                        onPressed: () {},
                        icon: Icon((repeat) ? Icons.repeat_on : Icons.repeat)),
                  ],
                )
              ],
            ),
          ),
        ));
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}

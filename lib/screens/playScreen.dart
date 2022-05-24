import 'package:flutter/material.dart';
import 'package:musicplatform/podo/Models.dart';

import '../podo/songsModels.dart';

class Player extends StatefulWidget {
  const Player({Key? key}) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  bool fav = false, shuffle = false, repeat = false;
  late Song currentSong;
  Duration currentDuration = const Duration(seconds: 0);

  @override
  void initState() {
    super.initState();

    checkFavorite(currentSong.id).then((value) {
      fav = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.keyboard_arrow_down)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
            ],
          ),
          Container(
            width: size.width - 40,
            height: size.width - 40,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(currentSong.cover), fit: BoxFit.contain),
              borderRadius: BorderRadius.circular(10),
            ),
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
                children: [
                  Text(currentSong.title),
                  Text(currentSong.artist),
                ],
              )
            ],
          ),
          LinearProgressIndicator(
            value: currentDuration.inMicroseconds /
                currentSong.duration.inMicroseconds,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(currentDuration.inMinutes.toString() +
                  ':' +
                  currentDuration.inSeconds.toString()),
              Text(currentSong.duration.inMinutes.toString() +
                  ':' +
                  currentSong.duration.inSeconds.toString()),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(onPressed: () {}, icon: Icon((shuffle)? Icons.shuffle_on : Icons.shuffle_outlined)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.skip_previous_outlined)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.play_circle_fill_outlined)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.skip_next_outlined)),
              IconButton(onPressed: () {}, icon: Icon((repeat)? Icons.repeat_on : Icons.repeat)),
            ],
          )
        ],
      ),
    );
  }
}

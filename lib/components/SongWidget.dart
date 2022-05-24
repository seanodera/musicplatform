import 'package:flutter/material.dart';
import 'package:musicplatform/podo/Models.dart';

class SongWidget extends StatefulWidget {
  final int id;
  const SongWidget({Key? key, required this.id}) : super(key: key);

  @override
  State<SongWidget> createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> {
  late Song song;
  late bool fav;
  @override
  initState() async {
    song = await getSong(widget.id);
    fav = await checkFavorite(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            children: [
              Text(song.title),
              Text(song.artist),
            ],
          ),
        ),
        (fav)? IconButton(onPressed: (){}, icon: const Icon(Icons.favorite)): Container(),
        IconButton(onPressed: (){}, icon: const Icon(Icons.more_horiz))
      ],
    );
  }
}

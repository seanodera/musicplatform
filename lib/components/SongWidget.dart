import 'package:flutter/material.dart';
import 'package:musicplatform/podo/FavouriteModel.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/podo/Player.dart';
import 'package:musicplatform/podo/providerModel.dart';
import 'package:provider/provider.dart';

class SongWidget extends StatefulWidget {
  final Song song;
  final Function onTap;
  final int index;
  final List<Song> othersongs;
  const SongWidget(
      {Key? key,
      required this.song,
      required this.onTap,
      required this.index,
      required this.othersongs})
      : super(key: key);

  @override
  State<SongWidget> createState() => _SongWidgetState();
}

class _SongWidgetState extends State<SongWidget> {
  late bool fav;
  Widget _buildSongItem(Song data) {
    Favourites favoriteModel = Provider.of<Favourites>(context);
    ProviderModel songModel = Provider.of<ProviderModel>(context);
    if (data.id == songModel.currentSong.id) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            padding: const EdgeInsets.all(10),
            color: Theme.of(context).colorScheme.secondary.withAlpha(90),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Container(
                      width: 50, height: 50, child: Image.network(data.cover)),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.title,
                          style: data.url == null
                              ? const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                )
                              : const TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w600,
                                ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          data.artist,
                          style: data.url == null
                              ? const TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.grey,
                                )
                              : const TextStyle(
                                  fontSize: 10.0,
                                ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]),
                ),
                IconButton(
                    onPressed: () => favoriteModel.collect(data.id),
                    icon: const Icon(
                      Icons.pause,
                      size: 20.0,
                    ))
              ],
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Container(
                  width: 50, height: 50, child: Image.network(data.cover)),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      data.title,
                      style: data.url == null
                          ? const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey,
                            )
                          : const TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.w600,
                            ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      data.artist,
                      style: data.url == null
                          ? const TextStyle(
                              fontSize: 10.0,
                              color: Colors.grey,
                            )
                          : const TextStyle(
                              fontSize: 10.0,
                            ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ]),
            ),
            IconButton(
                onPressed: () => favoriteModel.collect(data.id),
                icon: data.url == null
                    ? const Icon(
                        Icons.favorite_border,
                        color: Color(0xFFE0E0E0),
                        size: 20.0,
                      )
                    : favoriteModel.checkFavourite(data.id)
                        ? Icon(
                            Icons.favorite,
                            color: Theme.of(context).colorScheme.secondary,
                            size: 20.0,
                          )
                        : const Icon(
                            Icons.favorite_border,
                            size: 20.0,
                          ))
          ],
        ),
      );
    }
  }

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProviderModel songModel = Provider.of<ProviderModel>(context);
    Player player = Player(context);
    return GestureDetector(
      onTap: () {
        songModel.currentPos = widget.index;
        songModel.currentSong = widget.song;
        player.playSong(widget.song);
      },
      child: _buildSongItem(widget.song),
    );
  }
}

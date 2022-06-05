import 'package:flutter/material.dart';
import 'package:musicplatform/components/SongWidget.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/podo/TempData.dart';

class AlbumPage extends StatefulWidget {
  final int id;

  const AlbumPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  Color mainColor = Colors.redAccent.shade400;
  late Album album;
  bool loaded = false;
  @override
  void initState() {
    loaded = false;
    Database().getAlbum(widget.id).then((value) {
      album = value;
      getColorFromImage(NetworkImage(album.art)).then((value) {
        mainColor = value;

        print(loaded);
        setState(() {
          loaded = true;
        });
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool fav = false;
    return (!loaded)
        ? CircularProgressIndicator(strokeWidth: 7)
        : CustomScrollView(
            slivers: [
              SliverAppBar(
                flexibleSpace: Container(
                  alignment: Alignment.center,
                  child: Image.network(
                    album.art,
                    height: 250,
                    width: 250,
                    fit: BoxFit.contain,
                  ),
                ),
                title: Text(album.name),
                bottom: PreferredSize(
                  child: Column(
                    children: [
                      Text(album.artistName),
                      Text('Album . ' + album.releaseDate.year.toString()),
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
                            song: album.songs[index],
                            onTap: () {},
                            index: index,
                            othersongs: album.songs,
                          ),
                      childCount: album.songs.length)),
            ],
          );
  }
}

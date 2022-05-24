import 'package:flutter/material.dart';
import 'package:musicplatform/components/SongWidget.dart';
import 'package:musicplatform/podo/Models.dart';


class AlbumPage extends StatefulWidget {
  final Album album;

  const AlbumPage({
    Key? key,
    required this.album,
  }) : super(key: key);

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  Color mainColor = Colors.redAccent.shade400;
  @override
  void initState() async {
   mainColor = await getColorFromImage( NetworkImage(widget.album.art));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    bool fav = false;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          flexibleSpace: Container(
            alignment: Alignment.center,
            child: Image.network(
              widget.album.art,
              height: 250,
              width: 250,
              fit: BoxFit.contain,
            ),
          ),
          title: Text(widget.album.name),
          bottom: PreferredSize(
            child: Column(
              children: [
                Text(widget.album.artistName),
                Text('Album . ' + widget.album.releaseDate.year.toString()),
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
            delegate: SliverChildBuilderDelegate((context, index) =>
                SongWidget(id: widget.album.songs.elementAt(index)), childCount: widget.album.songs.length)),

      ],
    );
  }
}

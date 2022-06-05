// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:musicplatform/podo/HomeModel.dart';
import 'package:musicplatform/podo/providerModel.dart';
import 'package:musicplatform/screens/AlbumView.dart';
import 'package:musicplatform/screens/ArtistView.dart';
import 'package:musicplatform/screens/PlayListView.dart';
import 'package:provider/provider.dart';
import '../components/HomeWidgets.dart';
import '../podo/Models.dart';

//
// class HomeScreen extends StatelessWidget {
//   const HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     ProviderModel providerModel = Provider.of<ProviderModel>(context);
//     Size size = MediaQuery.of(context).size;
//     List<PlayList> featured = [];
//     List<Song> songs = providerModel.queue;
//     return ListView(
//       children: [
//         const SizedBox(
//           height: 20,
//         ),
//         Row(
//           mainAxisSize: MainAxisSize.max,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             const Text('Recently Added'),
//             Row(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 IconButton(
//                   icon: const Icon(Icons.notifications_none),
//                   onPressed: () {},
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.timelapse_outlined),
//                   onPressed: () {},
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.settings),
//                   onPressed: () {},
//                 ),
//               ],
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             SizedBox(
//               width: size.width,
//               height: (size.width / 2.5) - 20,
//               child: ListView.builder(
//                 shrinkWrap: true,
//                 itemBuilder: (context, index) {
//                   return PlaylistWidget(playList: featured.elementAt(index));
//                 },
//                 itemCount: featured.length,
//                 scrollDirection: Axis.horizontal,
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             SizedBox(
//               width: size.width,
//               height: 200,
//               child: GridView.builder(
//                 shrinkWrap: false,
//                 scrollDirection: Axis.horizontal,
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 3, mainAxisSpacing: 5, crossAxisSpacing: 5),
//                 itemBuilder: (BuildContext context, int index) {
//                   return Container();
//                 },
//                 itemCount: songs.length,
//               ),
//             )
//           ],
//         )
//       ],
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    ProviderModel providerModel = Provider.of<ProviderModel>(context);
    HomeModel homeModel = Provider.of<HomeModel>(context);
    Size size = MediaQuery.of(context).size;
    List<Playlist> featured = homeModel.topPlaylist;
    List<Song> songs = providerModel.queue;
    List<Album> topAlbums = homeModel.albums;
    List<RecentlyPlayed> recent = List.generate(providerModel.queue.length,
        (index) => RecentlyPlayed(type: 'song', object: songs[index]));

    return ListView(
      shrinkWrap: true,
      children: [
        HomeTitle(title: 'Recently Played', onTap: () {}),
        SizedBox(
            width: size.width,
            height: (size.width / 2.5) + 20,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                String image, text, subText;
                void Function() onTap;
                RecentlyPlayed recentlyPlayed = recent.elementAt(index);
                if (recentlyPlayed.type == 'album') {
                  Album album = recentlyPlayed.object;
                  image = album.art;
                  text = album.name;
                  subText = album.artistName;
                  onTap = () => nextPage(
                      context: context, widget: AlbumPage(id: album.id));
                } else if (recentlyPlayed.type == 'playlist') {
                  Playlist playlist = recentlyPlayed.object;
                  //update to new method
                  image = playlist.pictureBig;
                  text = playlist.title;
                  subText = playlist.user.name;
                  onTap = () => nextPage(
                      context: context,
                      widget: PlaylistView(playList: playlist));
                } else if (recentlyPlayed.type == 'song') {
                  Song song = recentlyPlayed.object;
                  image = song.cover;
                  text = song.title;
                  subText = song.artist;
                  onTap = () {
                    nextPage(
                        context: context, widget: AlbumPage(id: song.albumId));
                  };
                } else if (recentlyPlayed.type == 'artist') {
                  Artist artist = recentlyPlayed.object;
                  image = artist.cover;
                  text = artist.name;
                  subText = '';
                  onTap = () =>
                      nextPage(context: context, widget: const ArtistPage());
                } else {
                  return Container();
                }

                return HomeListWidget(
                  title: text,
                  image: image,
                  author: subText,
                  onTap: onTap,
                );
              },
              itemCount: recent.length,
            )),
        HomeTitle(title: 'Top Albums', onTap: () {}),
        SizedBox(
            width: size.width,
            height: (size.width / 2.5) + 20,
            child: ListView.builder(
              itemBuilder: (context, index) {
                Album album = topAlbums[index];
                return HomeListWidget(
                    onTap: () => nextPage(
                        context: context, widget: AlbumPage(id: album.id)),
                    image: album.art,
                    title: album.name,
                    author: album.artistName);
              },
              itemCount: topAlbums.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
            )),
        HomeTitle(title: 'Featured Playlist', onTap: () {}),
        SizedBox(
            width: size.width,
            height: (size.width / 2.5) + 20,
            child: ListView.builder(
              itemBuilder: (context, index) {
                Playlist playlist = featured[index];
                return HomeListWidget(
                  onTap: () => nextPage(
                      context: context,
                      widget: PlaylistView(playList: playlist)),
                  image: playlist.pictureBig,
                  title: playlist.title,
                  author: playlist.user.name,
                );
              },
              itemCount: featured.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
            )),
      ],
    );
  }
}

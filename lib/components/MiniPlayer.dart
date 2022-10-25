// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:musicplatform/podo/FavouriteModel.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/podo/Player.dart';
import 'package:musicplatform/podo/providerModel.dart';
import 'package:musicplatform/screens/playScreen.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatefulWidget {
  final ProviderModel providerModel;
  final bool mainShell;
  const MiniPlayer(
      {Key? key, required this.providerModel, this.mainShell = false})
      : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer>
    with AutomaticKeepAliveClientMixin {
  bool mainShell = false;
  Song? currentSong;
  Color? back;
  int currentImageId = 0;
  @override
  void initState() {
    currentSong = widget.providerModel.currentSong;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProviderModel providerModel =
        Provider.of<ProviderModel>(context, listen: true);
    Song data = providerModel.currentSong;
    if (data.id != 0 && currentImageId != data.id) {
      getColorFromImage(NetworkImage(currentSong!.cover)).then((value) {
        setState(() {
          back = value.dominantColor!.color;
          debugPrint('get color called');
          currentImageId = data.id;
        });
      });
    }
    if (currentSong == null && currentSong!.id == 0) {
      return const SizedBox(
        height: 1,
        width: 1,
      );
    } else {
      return GestureDetector(
        onTap: () => nextPage(
            context: context,
            widget: Consumer2<ProviderModel, Favourites>(
                builder: (context, providerModel, favourites, widget) =>
                    PlayScreen(
                      providerModel: providerModel,
                      favourites: favourites,
                    ))),
        child: Container(
          margin: (widget.mainShell)
              ? const EdgeInsets.only(left: 10.0, right: 10)
              : null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 70,
              padding: (widget.mainShell)
                  ? const EdgeInsets.fromLTRB(20, 10, 20, 0)
                  : const EdgeInsets.fromLTRB(30, 10, 30, 0),
              width: MediaQuery.of(context).size.width,
              color: (back == null)
                  ? Theme.of(context).colorScheme.secondary.withAlpha(100)
                  : back,
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.network(
                          data.cover,
                          fit: BoxFit.contain,
                        )),
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
                      onPressed: () =>
                          widget.providerModel.player.pausePlayer(),
                      icon: (widget.providerModel.player.paused)
                          ? const Icon(
                              Icons.play_arrow,
                              size: 20,
                            )
                          : const Icon(
                              Icons.pause,
                              size: 20.0,
                            ))
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  bool get wantKeepAlive => false;
}

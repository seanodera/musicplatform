import 'package:flutter/material.dart';
import 'package:musicplatform/podo/Models.dart';
import 'package:musicplatform/podo/Player.dart';
import 'package:musicplatform/podo/providerModel.dart';
import 'package:provider/provider.dart';

class MiniPlayer extends StatefulWidget {
  final ProviderModel providerModel;
  const MiniPlayer({Key? key, required this.providerModel}) : super(key: key);

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  Song? currentSong;
  Color? back;
  @override
  void initState() {
    currentSong = widget.providerModel.currentSong;
    if (currentSong != null && currentSong!.id != 0) {
      getColorFromImage(NetworkImage(currentSong!.cover)).then((value) {
        setState(() {
          back = value;
          print(value);
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Song data = currentSong!;
    if (currentSong == null && currentSong!.id == 0) {
      return SizedBox(
        height: 1,
        width: 1,
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            height: 70,
            padding: const EdgeInsets.all(10),
            color: back,
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
                    onPressed: () => Player(context).pausePlayer(),
                    icon: const Icon(
                      Icons.pause,
                      size: 20.0,
                    ))
              ],
            ),
          ),
        ),
      );
      ;
    }
  }
}

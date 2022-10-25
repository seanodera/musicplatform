// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:musicplatform/podo/providerModel.dart';
import 'package:provider/provider.dart';

class RotatePlayer extends AnimatedWidget {
  final Animation<double> animation;
  const RotatePlayer({
    Key? key,
    required this.animation,
  }) : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    ProviderModel songModel = Provider.of(context);
    return GestureDetector(
      onTap: () {},
      child: RotationTransition(
        turns: animation,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.5,
          height: MediaQuery.of(context).size.width * 0.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: CachedNetworkImageProvider(songModel.currentSong.url),
            ),
          ),
        ),
      ),
    );
  }
}

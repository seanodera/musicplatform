// ignore_for_file: file_names

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HomeTitle extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  final bool showRight;
  const HomeTitle(
      {Key? key, required this.title, this.onTap, this.showRight = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title,
              style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2)),
          (showRight)
              ? GestureDetector(
                  onTap: onTap,
                  child: const Text('View All',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w600,
                      )),
                )
              : Container(),
        ],
      ),
    );
  }
}

class HomeListWidget extends StatelessWidget {
  final void Function() onTap;
  final String image, title, author;
  const HomeListWidget(
      {Key? key,
      required this.onTap,
      required this.image,
      required this.title,
      required this.author})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 0.0),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  height: 120.0,
                  width: 120.0,
                  image: CachedNetworkImageProvider(image),
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(
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
                author,
                style: const TextStyle(
                  fontSize: 10.0,
                  color: Colors.grey,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

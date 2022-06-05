// ignore_for_file: file_names

import 'package:musicplatform/podo/Models.dart';

// class User {
//   String uid, firstName, lastName, email, phoneNumber, countryCode, profilePicture;
//   bool? hasImage;
//   User(this.uid,this.firstName,this.lastName,this.countryCode, this.phoneNumber, this.email, this.profilePicture, this.hasImage);
// }

class Playlist {
  late int id;
  late String title;
  late bool public;
  late int nbTracks;
  late String link;
  late String picture;
  late String pictureSmall;
  late String pictureMedium;
  late String pictureBig;
  late String pictureXl;
  late String checksum;
  late List<Song> songs;
  late String creationDate;
  late String md5Image;
  late String pictureType;
  late User user;
  late String type;

  Playlist(
      {required this.id,
      required this.title,
      required this.public,
      required this.nbTracks,
      required this.link,
      required this.picture,
      required this.pictureSmall,
      required this.pictureMedium,
      required this.pictureBig,
      required this.pictureXl,
      required this.checksum,
      required this.songs,
      required this.creationDate,
      required this.md5Image,
      required this.pictureType,
      required this.user,
      required this.type});

  Playlist.fromJson(Map<String, dynamic> json, this.songs) {
    id = json['id'];
    title = json['title'];
    public = json['public'];
    nbTracks = json['nb_tracks'];
    link = json['link'];
    picture = json['picture'];
    pictureSmall = json['picture_small'];
    pictureMedium = json['picture_medium'];
    pictureBig = json['picture_big'];
    pictureXl = json['picture_xl'];
    checksum = json['checksum'];
    creationDate = json['creation_date'];
    md5Image = json['md5_image'];
    pictureType = json['picture_type'];
    user = User.fromJson(json['user']);
    type = json['type'];
  }
}

class User {
  late int id;
  late String name;
  late String tracklist;
  late String type;

  User(
      {required this.id,
      required this.name,
      required this.tracklist,
      required this.type});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    tracklist = json['tracklist'];
    type = json['type'];
  }
}

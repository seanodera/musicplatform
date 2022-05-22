import 'package:musicplatform/podo/Models.dart';

class User {
  String uid, firstName, lastName, email, phoneNumber, countryCode, profilePicture;
  bool? hasImage;
  User(this.uid,this.firstName,this.lastName,this.countryCode, this.phoneNumber, this.email, this.profilePicture, this.hasImage);
}

class PlayList{
  int id;
  String name, description, image, userId;
  bool? hasImage;
  List<Song> songs;
  PlayList(this.id, this.name, this.description, this.hasImage, this.image, this.songs, this.userId);
}
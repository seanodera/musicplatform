

class Song {
  int id, artistId, albumId;
  Duration duration;
  String title, artist, album, cover;
  Song({required this.id, required this.artistId, required this.albumId, required this.artist, required this.album, required this.cover, required this.duration, required this.title});
}

class Artist{
  int id;
  String name, description, cover;
  bool hasImage;
  List<String> albumIds;
  Artist(this.id, this.cover, this.hasImage, this.description, this.name, this.albumIds);
}

class Album {
  int id, artistId;
  String art, name, artistName;
  DateTime releaseDate;
  bool? single, ep;
  List<int> songs;
  Album(this.id, this.name,this.artistName, this.artistId, this.songs, this.art, this.ep, this.single, this.releaseDate);
}

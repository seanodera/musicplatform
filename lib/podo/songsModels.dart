

class Song {
  int id, duration, artistId, albumId;
  String title, artist, album, cover;
  Song(this.id, this.artistId, this.albumId, this.artist, this.album, this.cover, this.duration, this.title);
}

class Artist{
  int id;
  String name, description, cover;
  bool hasImage;
  List<String> albumIds;
  Artist(this.id, this.cover, this.hasImage, this.description, this.name, this.albumIds);
}

class Album {
  int id;
  String art, name;
  bool? single, ep;
  List<Song> songs;
  Album(this.id, this.name, this.songs, this.art, this.ep, this.single);
}

class Song {
  late int id, artistId, albumId;
  late Duration duration;
  late String title, artist, album, cover, url;
  Song(
      {required this.id,
      required this.artistId,
      required this.albumId,
      required this.artist,
      required this.album,
      required this.cover,
      required this.duration,
      required this.title,
      required this.url});
  Song.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    artistId = data['artist']['id'];
    albumId = data['album']['id'];
    artist = data['artist']['name'];
    album = data['album']['title'];
    cover = data['album']['cover_big'];
    duration = Duration(seconds: data['duration']);
    title = data['title'];
    url = data['preview'];
  }
  Song.fromTrackListMap(
      Map<String, dynamic> data, this.albumId, this.album, this.cover) {
    id = data['id'];
    artistId = data['artist']['id'];
    artist = data['artist']['name'];
    duration = Duration(seconds: data['duration']);
    title = data['title'];
    url = data['preview'];
  }
}

class Artist {
  int id;
  String name, description, cover;
  bool hasImage;
  List<String> albumIds;
  Artist(this.id, this.cover, this.hasImage, this.description, this.name,
      this.albumIds);
}

class Album {
  late int id, artistId;
  late String art, name, artistName;
  late DateTime releaseDate;
  bool? single, ep;
  late List<Song> songs;
  Album(this.id, this.name, this.artistName, this.artistId, this.songs,
      this.art, this.ep, this.single, this.releaseDate);

  Album.fromMap(Map<String, dynamic> json, List<Song> _songs) {
    artistId = json['artist']['id'];
    artistName = json['artist']['name'];
    id = json['id'];
    name = json['title'];
    art = json['cover_big'];
    releaseDate = (json['release_date'] == null)
        ? DateTime.now()
        : DateTime.parse(json['release_date']);
    var recordType = json['record_type'];
    print(recordType);
    single = false;
    ep = false;
    songs = _songs;
  }
}

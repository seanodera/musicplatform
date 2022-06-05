import 'dart:convert';
import 'Models.dart';
import 'package:http/http.dart' as http;

class Database {
  String aPIKey = 'ca23bd9c911a62a9270639fa66ee5fd1';
  String secret = '4f12b6cc4a138c9f2d59020a2bba4313';
  String baseUrl = 'https://api.deezer.com/';

  Database();

  Future<List<Song>> getCharts() async {
    List<Song> songs = [];
    var request =
        http.Request('GET', Uri.parse('https://api.deezer.com/chart'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      List data =
          jsonDecode(await response.stream.bytesToString())['tracks']['data'];
      for (var element in data) {
        songs.add(Song.fromMap(element));
      }
    } else {
      print(response.reasonPhrase);
    }

    return songs;
  }

  Future<Album> getAlbum(int id) async {
    var res = await http.get(Uri.parse(baseUrl + 'album/' + id.toString()));
    Map<String, dynamic> data = jsonDecode(res.body);
    bool ep = false;
    bool single = false;
    if (data['record_type'] == 'ep') {
      ep = true;
    } else if (data['record_type'] == 'single') {
      single = true;
    }

    List tracks = data['tracks']['data'];
    List<Song> songs = [];
    for (var element in tracks) {
      songs.add(Song(
          id: element['id'],
          artistId: data['artist']['id'],
          albumId: id,
          artist: data['artist']['name'],
          album: data['title'],
          cover: data['cover_big'],
          duration: Duration(seconds: element['duration']),
          title: element['title'],
          url: element['preview']));
    }
    return Album(
        id,
        data['title'],
        data['artist']['name'],
        data['artist']['id'],
        songs,
        data['cover_big'],
        ep,
        single,
        DateTime.parse(data['release_date']));
  }

  Future<List<Song>> getTracklist(String url,
      {int? albumId,
      String? album,
      String? cover,
      required bool isAlbum}) async {
    List<Song> songs = [];
    var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();
    List data = jsonDecode(await response.stream.bytesToString())['data'];
    for (var element in data) {
      if (isAlbum) {
        songs.add(Song.fromTrackListMap(element, albumId!, album!, cover!));
      } else {
        songs.add(Song.fromMap(element));
      }
    }
    return songs;
  }

  Future<List<Album>> getTopAlbums() async {
    List<Album> albums = [];
    var res = await http.get(Uri.parse(baseUrl + '/chart/0/albums'));
    List data = jsonDecode(res.body)['data'];
    for (var element in data) {
      List<Song> songs = await getTracklist(element['tracklist'],
          albumId: element['id'],
          album: element['title'],
          cover: element['cover_big'],
          isAlbum: true);
      albums.add(Album.fromMap(element, songs));
    }
    return albums;
  }

  Future<List<Playlist>> getTopPlayList() async {
    List<Playlist> playlists = [];
    var res = await http.get(Uri.parse(baseUrl + '/chart/0/playlists'));
    List data = jsonDecode(res.body)['data'];
    for (var element in data) {
      List<Song> songs =
          await getTracklist(element['tracklist'], isAlbum: false);
      playlists.add(Playlist.fromJson(element, songs));
    }
    return playlists;
  }

  Future<Map<String, dynamic>> searchTop(String searchTerm) async {
    var res = await http.get(Uri.parse(baseUrl + 'search?q' + searchTerm));
    Map<String, dynamic> data = jsonDecode(res.body);
    return data;
  }
}

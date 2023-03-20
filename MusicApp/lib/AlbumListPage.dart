import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Album.dart';
import 'AlbumPage.dart';

class AlbumListPage extends StatefulWidget {
  @override
  _AlbumListPageState createState() => _AlbumListPageState();
}

class _AlbumListPageState extends State<AlbumListPage> {
  late List<Album> _albums;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchAlbums();
  }

  Future<void> _fetchAlbums() async {
    final response = await http.get(Uri.parse('https://api.deezer.com/chart'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final albums = (data['albums']['data'] as List<dynamic>)
          .map((e) => Album.fromJson(e))
          .toList();
      setState(() {
        _albums = albums;
        _isLoading = false;
      });
    } else {
      throw Exception('Failed to load albums');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : ListView.builder(
        itemCount: _albums.length,
        itemBuilder: (context, index) {
          final album = _albums[index];
          return ListTile(
            leading: Image.network(album.coverMedium),
            title: Text(album.title),
            subtitle: Text(album.artist.name),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AlbumPage(albumId: "302127"),
              ),
            ),
          );
        },
      ),
    );
  }
}
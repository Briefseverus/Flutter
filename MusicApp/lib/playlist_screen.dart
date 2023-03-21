import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'PlayScreen.dart';

class playlist_sceen extends StatefulWidget {
  final String playlistId;

  playlist_sceen({required this.playlistId});

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<playlist_sceen> {
  late Future<List<dynamic>> _playlistData;

  Future<List<dynamic>> _fetchPlaylistData(String playlistId) async {
    final response = await http.get(Uri.parse('https://api.deezer.com/playlist/$playlistId/tracks'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List<dynamic> trackList = (jsonData as Map<String, dynamic>)['data'];
      return trackList;
    } else {
      throw Exception('Failed to fetch playlist data');
    }
  }

  @override
  void initState() {
    super.initState();
    _playlistData = _fetchPlaylistData(widget.playlistId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Playlist')),
      body: FutureBuilder(
        future: _playlistData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final trackList = snapshot.data! as List<dynamic>;

            return ListView.builder(
              itemCount: trackList.length,
              itemBuilder: (context, index) {
                final trackData = trackList[index];
                final String trackTitle = (trackData as Map<String, dynamic>)['title'];
                final String artistName = (trackData['artist'] as Map<String, dynamic>)['name'];
                final String albumCoverUrl = (trackData['album'] as Map<String, dynamic>)['cover_big'];
                final String trackUrl = trackData['preview'];

                return Card(
                  child: ListTile(
                    leading: Image.network(albumCoverUrl),
                    title: Text(trackTitle),
                    subtitle: Text(artistName),
                    trailing: IconButton(
                      icon: Icon(Icons.play_arrow),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PlayScreen(trackId:"3135556")),
                        );
                      },
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AlbumPage extends StatefulWidget {
  final String albumId;

  AlbumPage({required this.albumId});

  @override
  _AlbumPageState createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late Future<Map<String, dynamic>> _albumData;

  Future<Map<String, dynamic>> _fetchAlbumData(String albumId) async {
    final response = await http.get(Uri.parse('https://api.deezer.com/album/$albumId'));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String albumCoverUrl = data['cover_big'];
      // Add the album cover image to the data map
      data['image'] = albumCoverUrl;
      return data;
    } else {
      throw Exception('Failed to fetch album data');
    }
  }

  @override
  void initState() {
    super.initState();
    _albumData = _fetchAlbumData(widget.albumId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Album Details')),
      body: FutureBuilder(
        future: _albumData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final albumData = snapshot.data as Map<String, dynamic>;

            final String albumTitle = albumData['title'];
            final String artistName = albumData['artist']['name'];
            final String albumCoverUrl = albumData['cover_big'];
            final List<dynamic> trackList = albumData['tracks']['data'];

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 250,
                          child: Card(
                            clipBehavior: Clip.antiAlias,
                            child: Image.network(albumCoverUrl),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(albumTitle, style: TextStyle(fontSize: 24)),
                        SizedBox(height: 10),
                        Text(artistName, style: TextStyle(fontSize: 16)),
                        SizedBox(height: 20),
                        Text('Tracks', style: TextStyle(fontSize: 20)),
                        SizedBox(height: 10),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: trackList.length,
                          itemBuilder: (context, index) {
                            final trackData = trackList[index];
                            final String trackTitle = trackData['title'];
                            final String artistName = trackData['artist']['name'];

                            return ListTile(
                              leading: Text('${index + 1}.'),
                              title: Text(trackTitle),
                              subtitle: Text(artistName),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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

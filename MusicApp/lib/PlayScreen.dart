<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PlayScreen extends StatefulWidget {
  final String trackId;

  PlayScreen({required this.trackId});

  @override
  _PlayScreenState createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  late Future<Map<String, dynamic>> _trackData;
  bool _isPlaying = false;
  bool _isLiked = false;
  AudioPlayer audioPlayer = AudioPlayer();

  Future<Map<String, dynamic>> _fetchTrackData(String trackId) async {
    final response = await http.get(Uri.parse('https://api.deezer.com/track/$trackId'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch track data');
    }
  }

  void _playTrack(String trackUrl) {
    audioPlayer.play(UrlSource(trackUrl));
    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseTrack() {
    audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }
  void _nextTrack() {
    // add code to play the next track
  }

  void _prevTrack() {
    // add code to play the previous track
  }

  void _shuffleTracks() {
    // add code to shuffle the tracks
  }


  @override
  void initState() {
    super.initState();
    _trackData = _fetchTrackData(widget.trackId);
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(title: Text('Now Playing')),
      body: FutureBuilder(
        future: _trackData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final trackData = snapshot.data!;

            final String trackTitle = (trackData as Map<String, dynamic>)['title'];

            final String artistName = (trackData['artist'] as Map<String, dynamic>)['name'];
            final String albumTitle = (trackData['album'] as Map<String, dynamic>)['title'];
            final String albumCoverUrl = (trackData['album'] as Map<String, dynamic>)['cover_big'];
            final String trackUrl = trackData['preview'];


            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
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
                  Text(trackTitle, style: TextStyle(fontSize: 20)),
                  SizedBox(height: 10),
                  Text(artistName, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text(albumTitle, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.shuffle),
                        onPressed: () {
                          _shuffleTracks();
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.skip_previous),
                        onPressed: () {
                          _prevTrack();
                        },
                      ),
                      IconButton(
                        icon: _isPlaying ? Icon(Icons.pause) : Icon(Icons.play_arrow),
                        onPressed: () {
                          if (_isPlaying) {
                            _pauseTrack();
                          } else {
                            _playTrack(trackUrl);
                          }
                        },

                      ),
                      IconButton(
                        icon: Icon(Icons.skip_next),
                        onPressed: () {
                          _nextTrack();
                        },
                      ),
                      GestureDetector(
                        child: IconButton(
                          icon: _isLiked ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
                          onPressed: () {},
                        ),
                        onTap: () {
                          setState(() {
                            _isLiked = !_isLiked;
                          });
                        },
                      ),

                    ],
                  ),
                ],
              ),
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
=======
import 'package:flutter/material.dart';

class PlayScreen   extends StatelessWidget {
@override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.black,
    body: Column(
      children: <Widget>[
        SizedBox(height: 80),
        Text(
          'Now Playing',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        SizedBox(height: 20),
        CircleAvatar(
          radius: 150,
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1617158618836-c4c7af4f51fc',
          ),
        ),
        SizedBox(height: 20),
        Text(
          'Song Name',
          style: TextStyle(
            color: Colors.white,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Text(
          'Artist Name',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.skip_previous,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 60,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(
                Icons.skip_next,
                color: Colors.white,
                size: 40,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ],
    ),
  );
}
}
>>>>>>> 0ea812d7b37dd3d7e3c66d37462e188b2f5247d4

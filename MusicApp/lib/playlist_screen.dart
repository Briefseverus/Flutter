import 'package:flutter/material.dart';
import 'PlayScreen.dart';
class PlaylistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlist'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Song ${index + 1}'),
            subtitle: Text('Artist name'),
            trailing: Icon(Icons.more_vert),
            onTap: () {

              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PlayScreen()),
              );
            },
          );
        },
      ),
    );
  }
}



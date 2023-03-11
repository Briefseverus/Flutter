import 'package:flutter/material.dart';

class AlbumPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Album Title'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 250.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/album_cover.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Text(
            'Album Title',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Artist Name',
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 20.0),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with actual number of songs
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text('Song Title ${index + 1}'),
                  subtitle: Text('Artist Name'),
                  trailing: Icon(Icons.more_vert),
                  onTap: () {
                    // Play the song or navigate to the song's details page
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

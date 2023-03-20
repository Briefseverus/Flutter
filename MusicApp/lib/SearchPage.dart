import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            border: InputBorder.none,
            hintStyle: TextStyle(color: Colors.white70),
          ),
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              // Clear search field
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Song Title'),
            subtitle: Text('Artist Name'),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              // Play song or navigate to song details page
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Song Title'),
            subtitle: Text('Artist Name'),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              // Play song or navigate to song details page
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Song Title'),
            subtitle: Text('Artist Name'),
            trailing: Icon(Icons.more_vert),
            onTap: () {
              // Play song or navigate to song details page
            },
          ),
          Divider(),
          // Add more search results here
        ],
      ),
    );
  }
}

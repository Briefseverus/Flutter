import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.pinkAccent, Colors.purpleAccent],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50.0,
                  backgroundImage: AssetImage('assets/images/avatar.jpg'),
                ),
                SizedBox(height: 10.0),
                Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.0),
                Text(
                  'johndoe@gmail.com',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.0),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favorite Songs'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to Favorite Songs page
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.playlist_add),
            title: Text('Playlists'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to Playlists page
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              // Navigate to Settings page
            },
          ),
        ],
      ),
    );
  }
}

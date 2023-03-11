import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'General',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ),
            ListTile(
              title: Text('Notification'),
              trailing: Switch(
                value: true,
                onChanged: (bool value) {},
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Playback',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text('Equalizer'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Navigate to equalizer settings page
              },
            ),
            ListTile(
              title: Text('Crossfade'),
              trailing: Switch(
                value: true,
                onChanged: (bool value) {},
              ),
            ),
            ListTile(
              title: Text('Gapless Playback'),
              trailing: Switch(
                value: false,
                onChanged: (bool value) {},
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Account',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              title: Text('Sign Out'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                // Sign out user
              },
            ),
          ],
        ),
      ),
    );
  }
}

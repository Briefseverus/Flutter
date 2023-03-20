
class Album {
  final int id;
  final String title;
  final String coverMedium;
  final Artist artist;

  Album({
    required this.id,
    required this.title,
    required this.coverMedium,
    required this.artist,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      title: json['title'],
      coverMedium: json['cover_medium'],
      artist: Artist.fromJson(json['artist']),
    );
  }
}

class Artist {
  final int id;
  final String name;

  Artist({
    required this.id,
    required this.name,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
    );
  }
}
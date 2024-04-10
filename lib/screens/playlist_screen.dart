import 'package:flutter/material.dart';

// Assuming you have a PlaylistModel class to hold data for each playlist
class PlaylistModel {
  String name;
  List<String> songIds; // List of song IDs in the playlist

  PlaylistModel(this.name, this.songIds);
}

class PlaylistsScreen extends StatefulWidget {
  @override
  _PlaylistsScreenState createState() => _PlaylistsScreenState();
}

class _PlaylistsScreenState extends State<PlaylistsScreen> {
  List<PlaylistModel> playlists = [];

  @override
  void initState() {
    super.initState();
    // Load playlists from storage or initialize with default values
    playlists = [
      // Example playlists
      PlaylistModel('Favorites', ['songId1', 'songId2']),
      PlaylistModel('Workout', ['songId3', 'songId4']),
    ];
  }

  void navigateToPlaylist(PlaylistModel playlist) {
    // Navigate to the playlist details screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlaylistDetailsScreen(playlist: playlist),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playlists'),
      ),
      body: ListView.builder(
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(playlists[index].name),
            onTap: () => navigateToPlaylist(playlists[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality to create a new playlist
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class PlaylistDetailsScreen extends StatelessWidget {
  final PlaylistModel playlist;

  PlaylistDetailsScreen({Key? key, required this.playlist}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playlist.name),
      ),
      body: ListView.builder(
        itemCount: playlist.songIds.length,
        itemBuilder: (context, index) {
          // Replace with fetching the song details using the song ID
          String songTitle = 'Song ${playlist.songIds[index]}';
          return ListTile(
            title: Text(songTitle),
            // Add onTap or other functionality as needed
          );
        },
      ),
    );
  }
}

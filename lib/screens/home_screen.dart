
import 'package:flutter/material.dart';
import 'package:myapp/screens/albums_screens.dart';
import 'package:myapp/screens/artists_screen.dart';
import 'package:myapp/screens/playlist_screen.dart';

import 'all_songs_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
 late TabController _tabController;

  // Define the tabs for the BottomNavigationBar
final List<BottomNavigationBarItem> bottomTabs = [
  const BottomNavigationBarItem(
    icon: Icon(Icons.music_note),
    label: 'Songs',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.person),
    label: 'Artists',
  ),
  const BottomNavigationBarItem(
    icon: Icon(Icons.album),
    label: 'Albums',
  ),

];

// Define the drawer items for the Drawer navigation
final List<ListTile> drawerItems = [
  ListTile(
    leading: const Icon(Icons.music_note),
    title: const Text('All Songs'),
    onTap: () {
      // Update the state to AllSongs widget
    },
  ),
  ListTile(
    leading: const Icon(Icons.person),
    title: const Text('Artists'),
    onTap: () {
      // Update the state to Artists widget
    },
  ),
  ListTile(
    leading: const Icon(Icons.album),
    title: const Text('Albums'),
    onTap: () {
      // Update the state to Albums widget
    },
  ),
  // Add more items as needed
];


  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4); 
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.music_note), text: 'All Songs'),
            Tab(icon: Icon(Icons.person), text: 'Artists'),
            Tab(icon: Icon(Icons.album), text: 'Albums'),
            Tab(icon: Icon(Icons.playlist_play), text: 'Playlists'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Navigation'),
            ),
            ...drawerItems, 
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          const AllSongsScreen(), 
          ArtistsScreen(),  
          const AlbumsScreen(),   
          PlaylistsScreen(),
        ],
      ),
    );
  }
}



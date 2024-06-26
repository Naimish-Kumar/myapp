import 'package:flutter/material.dart';
import 'package:myapp/screens/albums_screens.dart';
import 'package:myapp/screens/artists_screen.dart';
import 'package:myapp/screens/playlist_screen.dart';

import 'all_songs_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: Image.asset(
            'assets/images/logo.png',
            height: 60,
            fit: BoxFit.fill,
          ),
        ),
        title: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.deepPurple,
              Colors.blue, // dark purple
              Colors.red,
              Colors.pink // red
            ],
          ).createShader(
            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
          ),
          child: const Text(
            'Music Player',
            style: TextStyle(fontSize: 30, fontFamily: 'Main Font'),
          ),
        ),
        bottom: TabBar(
          indicatorSize: TabBarIndicatorSize.tab,
          indicatorColor: Colors.blue,
          controller: _tabController,
          labelStyle: const TextStyle(
              color: Colors.pink,
              fontFamily: 'Nunito Regular',
              fontSize: 18,
              fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'All Songs'),
            Tab(text: 'Artists'),
            Tab(text: 'Albums'),
            Tab(text: 'Playlists'),
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

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumsScreen extends StatefulWidget {
  const AlbumsScreen({super.key});

  @override
  _AlbumsScreenState createState() => _AlbumsScreenState();
}

class _AlbumsScreenState extends State<AlbumsScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  Map<String, List<SongModel>> _albumsMap = {};

  @override
  void initState() {
    super.initState();
    _getAlbums();
  }

  void _getAlbums() async {
    // Requesting storage permission
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }

    // Querying all songs
    List<SongModel> songs = await _audioQuery.querySongs(
      sortType: SongSortType.ALBUM,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    // Grouping songs by album
    Map<String, List<SongModel>> albumsMap = {};
    for (var song in songs) {
      (albumsMap[song.album.toString()] ??= []).add(song);
    }

    setState(() {
      _albumsMap = albumsMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   
      body: _albumsMap.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _albumsMap.keys.length,
              itemBuilder: (context, index) {
                String album = _albumsMap.keys.elementAt(index);
                return ExpansionTile(
                  title: Text(album),
                  children: _albumsMap[album]!
                      .map((song) => ListTile(
                            title: Text(song.title),
                            subtitle: Text(song.artist ?? 'Unknown Artist'),
                            leading: QueryArtworkWidget(
                              id: song.id,
                              type: ArtworkType.AUDIO,
                            ),
                            onTap: () {
                              // Add navigation or play functionality
                            },
                          ))
                      .toList(),
                );
              },
            ),
    );
  }
}

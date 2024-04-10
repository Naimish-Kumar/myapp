import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';

class ArtistsScreen extends StatefulWidget {
  @override
  _ArtistsScreenState createState() => _ArtistsScreenState();
}

class _ArtistsScreenState extends State<ArtistsScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  Map<String, List<SongModel>> _artistsMap = {};

  @override
  void initState() {
    super.initState();
    _getArtists();
  }

  void _getArtists() async {
    // Requesting storage permission
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }

    // Querying all songs
    List<SongModel> songs = await _audioQuery.querySongs(
      sortType: SongSortType.ARTIST,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    // Grouping songs by artist
    Map<String, List<SongModel>> artistsMap = {};
    for (var song in songs) {
      (artistsMap[song.artist.toString()] ??= []).add(song);
    }

    setState(() {
      _artistsMap = artistsMap;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artists'),
      ),
      body: _artistsMap.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _artistsMap.keys.length,
              itemBuilder: (context, index) {
                String artist = _artistsMap.keys.elementAt(index);
                return ExpansionTile(
                  title: Text(artist),
                  children: _artistsMap[artist]!
                      .map((song) => ListTile(
                            title: Text(song.title),
                            subtitle: Text(song.album ?? 'Unknown Album'),
                            leading: QueryArtworkWidget(
                              id: song.id,
                              type: ArtworkType.AUDIO,
                            ),
                            onTap: () {
                         

                            },
                          ))
                      .toList(),
                );
              },
            ),
    );
  }
}

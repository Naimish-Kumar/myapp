import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:myapp/screens/song_details_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongsScreen extends StatefulWidget {
  const AllSongsScreen({super.key});

  @override
  _AllSongsScreenState createState() => _AllSongsScreenState();
}

class _AllSongsScreenState extends State<AllSongsScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    requestPermission();
  }

  void requestPermission() async {
    // Requesting storage permission
    bool permissionStatus = await _audioQuery.permissionsStatus();
    if (!permissionStatus) {
      await _audioQuery.permissionsRequest();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<SongModel>>(
        future: _audioQuery.querySongs(
          sortType: SongSortType.TITLE,
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No songs found on device.'));
          }
          List<SongModel>? songs = snapshot.data;
          return ListView.builder(
            itemCount: songs?.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: const Icon(Icons.music_note),
                title: Text(songs![index].title),
                subtitle: Text(songs[index].artist ?? 'Unknown Artist'),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SongDetailsScreen(
                          song: songs[index],
                          songs: songs,
                          currentIndex: index),
                    ),
                  );

                  // await _audioPlayer.play(DeviceFileSource(songs[index].data));
                },
              );
            },
          );
        },
      ),
    );
  }
}

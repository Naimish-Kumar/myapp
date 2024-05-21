import 'package:flutter/material.dart';
import 'package:myapp/screens/song_player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AllSongsScreen extends StatefulWidget {
  

  const AllSongsScreen({super.key});

  @override
  _AllSongsScreenState createState() => _AllSongsScreenState();
}

class _AllSongsScreenState extends State<AllSongsScreen> {
  final OnAudioQuery _audioQuery = OnAudioQuery();

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
    return FutureBuilder<List<SongModel>>(
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
            return Card(
              elevation: 4,
              child: ListTile(
                leading: Image.asset(
                  'assets/images/logo_1.png',
                  height: 40,
                ),
                title: Text(
                  songs![index].title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  songs[index].artist ?? 'Unknown Artist',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MusicPlayerScreen(
                          song: songs[index],
                          songs: songs,
                      
                          ),
                    ),
                  );

                  // await _audioPlayer.play(DeviceFileSource(songs[index].data));
                },
              ),
            );
          },
        );
      },
    );
  }
}

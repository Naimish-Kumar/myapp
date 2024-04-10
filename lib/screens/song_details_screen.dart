import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:audioplayers/audioplayers.dart';

class SongDetailsScreen extends StatefulWidget {
  final SongModel song;
  final List<SongModel> songs;
  final int currentIndex;

  const SongDetailsScreen({
    super.key,
    required this.song,
    required this.songs,
    required this.currentIndex,
  });

  @override
  _SongDetailsScreenState createState() => _SongDetailsScreenState();
}

class _SongDetailsScreenState extends State<SongDetailsScreen> {
  late AudioPlayer audioPlayer;
  bool isPlaying = false;
  int currentIndex = 0;


  void setupAudioPlayer() {
    audioPlayer.setReleaseMode(ReleaseMode.stop); // Set release mode to STOP
    // Listen for the completion of the song
    audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }

  void playNextSong() {
    setState(() {
      currentIndex =
          (currentIndex + 1) % widget.songs.length; // Move to the next song
      audioPlayer.play(DeviceFileSource(widget.songs[currentIndex].data));
    });
  }
  void playPreviousSong() {
    setState(() {
      currentIndex =
          (currentIndex - 1) % widget.songs.length; // Move to the previous song
      audioPlayer.play(DeviceFileSource(widget.songs[currentIndex].data));
    });
  }

  void pauseSong() {
    audioPlayer.pause();
  }
  void resumeSong() {
    audioPlayer.resume();
  }
  void stopSong() {
    audioPlayer.stop();
  }
  void seekTo(Duration position) {
    audioPlayer.seek(position);
  }


  void playSong(int index) {
    setState(() {
      currentIndex = index;
      audioPlayer.play(DeviceFileSource(widget.songs[currentIndex].data));
    });
  }

  void togglePlayPause() {
    if (audioPlayer.state == PlayerState.playing) {
      audioPlayer.pause();
    } else {
      audioPlayer.resume();
    }
  }


  @override
  void initState() {
    super.initState();
    currentIndex = widget.currentIndex;
    audioPlayer = AudioPlayer();
    setupAudioPlayer();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.song.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          PlaybackControls(
            audioPlayer: audioPlayer,
            song: widget.song,
            songs: widget.songs,
            currentIndex: widget.currentIndex,
            isPlaying: isPlaying,
          ),
        ],
      ),
    );
  }
}

class PlaybackControls extends StatelessWidget {
  final AudioPlayer audioPlayer;
  final SongModel song;
  final List<SongModel> songs;
  int currentIndex;
  final bool isPlaying;

  PlaybackControls(
      {Key? key,
      required this.audioPlayer,
      required this.song,
      required this.songs,
      required this.currentIndex,
      required this.isPlaying})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.skip_previous),
          onPressed: () {
          },
        ),
        IconButton(
          icon: isPlaying
              ? const Icon(Icons.pause)
              : const Icon(Icons.play_arrow),
          onPressed: () {
            // Toggle play or pause
            if (isPlaying) {
              audioPlayer.pause();
            } else {
              audioPlayer.play(DeviceFileSource(song.data));
            }
          },
        ),
        IconButton(
          icon: const Icon(Icons.skip_next),
          onPressed: () {
              int nextIndex = (currentIndex + 1) % songs.length;
            audioPlayer.play(DeviceFileSource(songs[nextIndex].data));
            onSongChanged(nextIndex);
          },
        ),
      ],
    );
  }
  void onSongChanged(int index) {
    currentIndex = index;
  }
}





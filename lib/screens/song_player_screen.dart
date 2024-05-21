import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:marquee/marquee.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:share_plus/share_plus.dart';

class MusicPlayerScreen extends StatefulWidget {
  SongModel song;
  List<SongModel> songs;
  MusicPlayerScreen({
    super.key,
    required this.song,
    required this.songs,
  });
  @override
  _MusicPlayerScreenState createState() => _MusicPlayerScreenState();
}

class _MusicPlayerScreenState extends State<MusicPlayerScreen> {
  AudioPlayer? audioPlayer;
  Duration? duration;
  Duration? position;
  bool? isPlaying;
  bool? isShuffle;
  int? currentIndex;

  void initializePlayer() {
    isPlaying = false;
    isShuffle = false;
    audioPlayer = AudioPlayer();
    duration = Duration.zero;
    position = Duration.zero;

    if (audioPlayer?.state == PlayerState.playing) {
      audioPlayer!.pause();
    } else if (audioPlayer?.state == PlayerState.paused) {
      audioPlayer!.resume();
    } else {
      audioPlayer!.setSourceUrl(widget.song.data);
      audioPlayer!.resume();
    }
    if (isShuffle!) {
      currentIndex = Random().nextInt(widget.songs.length);
    } else {
      currentIndex = widget.songs.indexOf(widget.song);
    }

    audioPlayer!.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });
    audioPlayer!.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    audioPlayer!.onPlayerComplete.listen((event) {
      if (isShuffle!) {
        currentIndex = Random().nextInt(widget.songs.length);
      } else {
        widget.song = widget.songs[currentIndex!];
      }
      setState(() {
        audioPlayer!.setSourceUrl(widget.song.data);
        audioPlayer!.resume();
      });
    });
    audioPlayer!.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    audioPlayer!.setSourceUrl(widget.song.data);
    audioPlayer!.resume();
  }

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer!.dispose();
  }

  void playOrPause() async {
    if (isPlaying!) {
      await audioPlayer!.pause();
    } else {
      await audioPlayer!.resume();
    }
    setState(() {
      isPlaying = !isPlaying!;
    });
  }

  void seekTo(Duration position) async {
    await audioPlayer!.seek(position);
  }

  void nextSong() async {
    // Next song logic
    if (currentIndex! < widget.songs.length - 1) {
      currentIndex = currentIndex! + 1;
      widget.song = widget.songs[currentIndex!];
      audioPlayer!.setSourceUrl(widget.song.data);
      audioPlayer!.resume();
    }
  }

  void previousSong() async {
    // Previous song logic
    if (currentIndex! > 0) {
      currentIndex = currentIndex! - 1;
      widget.song = widget.songs[currentIndex!];
      audioPlayer!.setSourceUrl(widget.song.data);
      audioPlayer!.resume();
    }
  }

  void shuffleMusic() async {
    // Shuffle music logic
    List<SongModel> shuffledSongs = List.from(widget.songs);
    shuffledSongs.shuffle();
  }

  void setRingtone() async {
    // Set ringtone logic (platform-specific)
    if (Platform.isAndroid) {
      // Android-specific code
      // final AndroidIntent intent = AndroidIntent(
      //   action: 'android.intent.action.RINGTONE_PICKER',
      //   type: 'audio/*',
      //   data: widget.song.data,
      //   flags: <int>[Flag.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS],
      // );
      // await intent.launch();
    } else if (Platform.isIOS) {
      // iOS-specific code
      // final IOSIntent intent = IOSIntent(
      //   action: IOSAction.PICK,
      //   data: widget.song.data,
      //   flags: <int>[Flag.FLAG_ACTIVITY_EXCLUDE_FROM_RECENTS],
      // );
    }
  }

  void shareSong() {
    // Share song logic
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.shareXFiles(
      [XFile(widget.song.data)],
      text: widget.song.title,
      subject: widget.song.title,
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(
            height: 150,
          ),
          // Display song image
          QueryArtworkWidget(
            id: widget.song.id,
            type: ArtworkType.AUDIO,
            nullArtworkWidget: Image.asset(
              'assets/images/logo_1.png',
              height: 250,
            ),
            artworkQuality: FilterQuality.high,
            keepOldArtwork: true,
            artworkFit: BoxFit.cover,
          ),
          const SizedBox(
            height: 200,
          ),

          // show song name with marquee package
          SizedBox(
            height: 30,
            width: MediaQuery.of(context).size.width,
            child: Marquee(
              text: widget.songs[currentIndex!].title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          // Playback controls
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(position.toString().split(".")[0]),
                Expanded(
                  child: Slider(
                    value: position!.inMilliseconds.toDouble(),
                    min: 0,
                    max: duration!.inMilliseconds.toDouble(),
                    label: position.toString().split(".")[0],
                    onChanged: (double value) {
                      seekTo(Duration(milliseconds: value.toInt()));
                    },
                  ),
                ),
                Text(duration.toString().split(".")[0]),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.skip_previous),
                onPressed: previousSong,
              ),
              IconButton(
                  icon: Icon(isPlaying! ? Icons.pause : Icons.play_arrow),
                  onPressed: playOrPause),
              IconButton(
                icon: const Icon(Icons.skip_next),
                onPressed: nextSong,
              ),
              IconButton(
                icon: Icon(isShuffle! ? Icons.shuffle_on : Icons.shuffle),
                onPressed: shuffleMusic,
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          IconButton(
              onPressed: shareSong,
              icon: const Icon(
                Icons.share,
                size: 30,
                color: Colors.pink,
              ))
          // Seek bar
        ],
      ),
    );
  }
}

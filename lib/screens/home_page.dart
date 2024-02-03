import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String audioUrl =
      "https://raag.fm/files/mp3/128/Hindi-Singles/23303/Kesariya%20(Brahmastra)%20-%20(Raag.Fm).mp3";
  AudioPlayer? player;
  Duration currPosValue = Duration.zero;
  Duration? totalPosValue = Duration.zero;
  Duration bufferPosValue = Duration.zero;

  @override
  void initState() {
    super.initState();
    setUpMyAudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          "Audio Player",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: const Icon(CupertinoIcons.backward_end),
                ),
                const SizedBox(width: 11),
                InkWell(
                  onTap: () {
                    if (player!.playing) {
                      player!.pause();
                      setState(() {});
                    } else {
                      player!.play();
                      setState(() {});
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                    child: player!.playing
                        ? const Icon(Icons.pause)
                        : const Icon(Icons.play_arrow),
                  ),
                ),
                const SizedBox(width: 11),
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
                  child: const Icon(CupertinoIcons.forward_end),
                ),
              ],
            ),
            const SizedBox(height: 11),
            ProgressBar(
              progress: currPosValue,
              total: totalPosValue!,
              buffered: bufferPosValue,
              progressBarColor: Colors.red,
              thumbColor: Colors.red,
              baseBarColor: Colors.grey.shade400,
              bufferedBarColor: Colors.grey.shade500,
              onSeek: (seekTo) {
                player!.seek(seekTo);
                setState(() {});
              },
            ),
          ],
        ),
      ),
    );
  }

  void setUpMyAudioPlayer() async {
    player = AudioPlayer();
    totalPosValue = await player!.setUrl(audioUrl);
    player!.play();
    player!.positionStream.listen((event) {
      currPosValue = event;
      setState(() {});
    });

    player!.bufferedPositionStream.listen((event) {
      bufferPosValue = event;
      setState(() {});
    });
  }
}

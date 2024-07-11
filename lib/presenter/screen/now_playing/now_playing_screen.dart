import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../data/model/book_data.dart';
import '../pdf/pdf_screen.dart';

class NowPlayingScreen extends StatefulWidget {
  final List<BookData> bookList;
  final int index;

  const NowPlayingScreen({super.key, required this.bookList, required this.index});

  @override
  State<NowPlayingScreen> createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  double _currentSliderValue = 0;
  bool isPlaying = false;
  AudioPlayer audioPlayer = AudioPlayer();
  Duration totalDuration = const Duration();
  Duration currentDuration = const Duration();
  int currentIndex = 0; // Track currently playing book index

  @override
  void initState() {
    super.initState();
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        totalDuration = duration;
      });
    });
    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        currentDuration = position;
        _currentSliderValue = position.inSeconds.toDouble();
      });
    });
    currentIndex = widget.index;
    loadAudio();
  }

  void loadAudio() async {
    String audioUrl = widget.bookList[currentIndex].audio;
    await audioPlayer.setSourceUrl(audioUrl);
    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        totalDuration = duration;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        currentDuration = position;
        _currentSliderValue = position.inSeconds.toDouble();
      });
    });
  }

  void seekToSecond(int second) {
    Duration newDuration = Duration(seconds: second);
    audioPlayer.seek(newDuration);
  }

  void skipForward() {
    int newPosition = currentDuration.inSeconds + 10;
    if (newPosition > totalDuration.inSeconds) {
      newPosition = totalDuration.inSeconds;
    }
    setState(() {
      _currentSliderValue = newPosition.toDouble();
      seekToSecond(newPosition);
    });
  }

  void skipBackward() {
    int newPosition = currentDuration.inSeconds - 10;
    if (newPosition < 0) {
      newPosition = 0;
    }
    setState(() {
      _currentSliderValue = newPosition.toDouble();
      seekToSecond(newPosition);
    });
  }

  void playPause() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.resume();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  void stop() async {
    await audioPlayer.stop();
    setState(() {
      isPlaying = false;
      _currentSliderValue = 0;
      currentDuration = const Duration();
    });
  }

  void playNext() {
    if (currentIndex < widget.bookList.length - 1) {
      currentIndex++;
      loadAudio();
    }
  }

  void playPrevious() {
    if (currentIndex > 0) {
      currentIndex--;
      loadAudio();
    }
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
        backgroundColor: const Color(0xffef6b6c),
        title: const Center(
          child: Text(
            'Now Playing',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Icon(Icons.more_vert, color: Colors.white),
          SizedBox(width: 24),
        ],
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                  width: double.infinity,
                  height: 100,
                  child: Image.asset(
                    "assets/img_top.png",
                    fit: BoxFit.fill,
                  ))
            ],
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  shadowColor: Colors.white54,
                  elevation: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PDFScreen(
                                  url: widget.bookList[currentIndex].pdf)));
                    },
                    child: Container(
                      height: 274,
                      width: 193,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image:
                          NetworkImage(widget.bookList[currentIndex].image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(widget.bookList[currentIndex].name,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.red)),
                Text(widget.bookList[currentIndex].author,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54)),
                const Text("Stephen King",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54)),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    children: [
                      Text(
                          currentDuration
                              .toString()
                              .split('.')
                              .first
                              .padLeft(8, "0"),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54)),
                      Expanded(
                        child: Slider(
                          value: _currentSliderValue,
                          min: 0.0,
                          max: totalDuration.inSeconds.toDouble(),
                          divisions: totalDuration.inSeconds > 0
                              ? totalDuration.inSeconds
                              : 1,
                          label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          },
                          onChangeEnd: (double value) {
                            seekToSecond(value.toInt());
                          },
                          activeColor: Color(0xFFF26B6C),
                          inactiveColor: Colors.grey,
                          thumbColor: Color(0xFFF26B6C),
                        ),
                      ),
                      Text(
                          totalDuration
                              .toString()
                              .split('.')
                              .first
                              .padLeft(8, "0"),
                          style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black54)),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: playPrevious,
                        icon: const Icon(
                          Icons.skip_previous_outlined,
                          color: Colors.black,
                          size: 32,
                        ),
                      ),
                      const SizedBox(
                        width: 24,
                      ),
                      SizedBox(
                          height: 16,
                          width: 20,
                          child: InkWell(
                            onTap: skipBackward,
                            child: Image.asset(
                              "assets/ic_preview_player.png",
                              fit: BoxFit.fill,
                            ),
                          )),
                      const Spacer(),
                      GestureDetector(
                        onTap: playPause,
                        child: Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0x42F26B6C),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Icon(
                              isPlaying ? Icons.pause : Icons.play_arrow,
                              color: const Color(0xFFF26B6C),
                            ),
                          ),
                        ),
                      ),
/*
                      IconButton(
                        icon: Icon(
                          isPlaying
                              ? Icons.pause_circle_filled_outlined
                              : Icons.play_circle_fill_outlined,
                          color: const Color(0xffF26B6C),
                          size: 58,
                        ),
                        onPressed: playPause,
                      ),*/
                      const Spacer(),
                      SizedBox(
                          height: 16,
                          width: 20,
                          child: InkWell(
                            onTap: skipForward,
                            child: Image.asset(
                              "assets/ic_next_player.png",
                              fit: BoxFit.fill,
                            ),
                          )),
                      const SizedBox(
                        width: 24,
                      ),
                      IconButton(
                        onPressed: playNext,
                        icon: const Icon(
                          Icons.skip_next_outlined,
                          color: Colors.black,
                          size: 32,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.dark_mode_outlined,
                      color: Colors.black54,
                      size: 32,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.0),
                      child: Icon(Icons.restart_alt_outlined,
                          color: Colors.black54, size: 32),
                    ),
                    Icon(Icons.bookmark_outline_outlined,
                        color: Colors.black54, size: 32),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

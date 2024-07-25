import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../../data/model/book_data.dart';
import '../../../util/utils.dart';
import '../pdf/pdf_screen.dart';

class NowPlayingScreen extends StatefulWidget {
  final List<BookData> bookList;
  final int index;
  final String tag;

  const NowPlayingScreen({super.key, required this.bookList, required this.index, required this.tag});

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
        backgroundColor: redColor,
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
          SizedBox(width: 48),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Flexible(
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PDFScreen(url: widget.bookList[currentIndex].pdf)));
                  },
                  child: Hero(
                    tag: "${widget.bookList[currentIndex].name}${widget.tag}",
                    child: Container(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(4, 4),
                            spreadRadius: 0,
                          )
                        ],
                        image: DecorationImage(
                          image: NetworkImage(widget.bookList[currentIndex].image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(widget.bookList[currentIndex].name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: Colors.red)),
              Text(widget.bookList[currentIndex].author,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  )),
              Text("Stephen King",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Theme.of(context).textTheme.bodyMedium?.color,
                  )),
              const SizedBox(height: 36),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Row(
                  children: [
                    Text(currentDuration.toString().split('.').first.padLeft(8, "0"),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        )),
                    Expanded(
                      child: SliderTheme(
                          data: SliderTheme.of(context).copyWith(
                            trackHeight: 1.0,
                            trackShape: const RoundedRectSliderTrackShape(),
                            activeTrackColor: redColor,
                            thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 6.0,
                              pressedElevation: 8.0,
                            ),
                            thumbColor: redColor,
                            overlayColor: Colors.pink.withOpacity(0.2),
                            overlayShape: const RoundSliderOverlayShape(overlayRadius: 12.0),
                          ),
                          child: Builder(builder: (context) {
                            return Slider(
                              value: _currentSliderValue,
                              min: 0.0,
                              max: totalDuration.inSeconds.toDouble(),
                              divisions: totalDuration.inSeconds > 0 ? totalDuration.inSeconds : 1,
                              // label: _currentSliderValue.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _currentSliderValue = value;
                                });
                              },
                              onChangeEnd: (double value) {
                                seekToSecond(value.toInt());
                              },
                            );
                          })),
                    ),
                    Text(totalDuration.toString().split('.').first.padLeft(8, "0"),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).textTheme.bodyMedium?.color,
                        )),
                  ],
                ),
              ),
              SizedBox(height: 56),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: playPrevious,
                      icon: const Icon(
                        Icons.skip_previous_outlined,
                        size: 32,
                      ),
                    ),
                    IconButton(
                        onPressed: skipBackward,
                        icon: const Icon(
                          Icons.fast_rewind_outlined,
                          size: 32,
                        )),
                    const Spacer(),
                    SizedBox(
                      width: 64,
                      height: 64,
                      child: FittedBox(
                        child: FloatingActionButton(
                          heroTag: 'button',
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 0,
                          highlightElevation: 0,
                          splashColor: Colors.red.withOpacity(0.1),
                          backgroundColor: Color(0x42F26B6C),
                          onPressed: playPause,
                          child: Icon(
                            isPlaying ? Icons.pause : Icons.play_arrow,
                            color: const Color(0xFFF26B6C),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: skipForward,
                        icon:  const Icon(
                          Icons.fast_forward_outlined,
                          size: 32,
                        )),
                    IconButton(
                      onPressed: playNext,
                      icon: const Icon(
                        Icons.skip_next_outlined,
                        size: 32,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
         /*     const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.dark_mode_outlined,
                    color: Colors.black54,
                    size: 32,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 32.0),
                    child: Icon(Icons.restart_alt_outlined, color: Colors.black54, size: 32),
                  ),
                  Icon(Icons.bookmark_outline_outlined, color: Colors.black54, size: 32),
                ],
              )*/
            ],
          )
        ],
      ),
    );
  }
}

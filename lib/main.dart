import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MusicApp(),
    );
  }
}

class MusicApp extends StatefulWidget {
  @override
  _MusicAppState createState() => _MusicAppState();
}

class _MusicAppState extends State<MusicApp> {
  bool playing = false;
  IconData playbtn = Icons.play_arrow;

  AudioPlayer _player;
  AudioCache cache;
  Duration position = new Duration();
  Duration musicLength = new Duration();

  Widget slider(){
    return Container(
      width: 300.0,
      child: Slider.adaptive(
          activeColor: Colors.blue[800],
          inactiveColor: Colors.grey[350],
          value: position.inSeconds.toDouble(),
          onChanged: (value) {
            seektosec(value.toInt());
          },
          max: musicLength.inSeconds.toDouble(),
      ),
    );
  }

  void seektosec(int sec) {
    Duration newpos = Duration(seconds: sec);
    _player.seek(newpos);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player = AudioPlayer();
    cache = AudioCache(fixedPlayer: _player);

    _player.durationHandler = (d) {
      setState(() {
        musicLength = d;
      });
    };

    _player.positionHandler = (p) {
      setState(() {
        position = p;
      });
    };

    cache.load("night.mp3");
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              //Colors.blue[800],
              Color.fromARGB(255, 241, 39, 17),
              Color.fromARGB(255, 245, 175,25),
            ]
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(top: 48.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Music Beats",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 38.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Text(
                    "Listen to your favorite music",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Center(
                  child: Container(
                    width: 280.0,
                    height: 280.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      image: DecorationImage(
                        image: AssetImage("assets/night.jpg"),
                      )
                    ),
                  ),
                ),
                SizedBox(
                  height: 18.0,
                ),
                Center(
                  child: Text(
                    "Night We Met",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 500.0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("${position.inMinutes}: ${position.inSeconds.remainder(60)}",style: TextStyle(
                                fontSize: 18.0
                              ),),
                              slider(),
                              Text("${musicLength.inMinutes}: ${musicLength.inSeconds.remainder(60)}",
                              style: TextStyle(fontSize: 18.0),),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 45.0,
                              color: Colors.blue,
                              onPressed: () {},

                              icon: Icon(
                                Icons.skip_previous,
                              ),
                            ),
                            IconButton(
                              iconSize: 62.0,
                              color: Colors.blue[800],
                              onPressed: () {
                                if(!playing) {
                                  cache.play("night.mp3");
                                  setState(() {
                                    playbtn = Icons.pause;
                                    playing = true;
                                  });
                                }
                                else
                                  {
                                    _player.pause();
                                    setState(() {
                                      playbtn = Icons.play_arrow;
                                      playing = false;
                                    });
                                  }
                              },

                              icon: Icon(
                                playbtn,
                              ),
                            ),
                            IconButton(
                              iconSize: 45.0,
                              color: Colors.blue,
                              onPressed: () {},

                              icon: Icon(
                                Icons.skip_next,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


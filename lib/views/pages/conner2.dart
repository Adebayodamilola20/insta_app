import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';

class Conner2 extends StatefulWidget {
  const Conner2({super.key});

  @override
  State<Conner2> createState() => _Conner2State();
}

//initaillizing videoplayer//
final VideoPlayerController _videoPlayerController =
    VideoPlayerController.asset('assets/images/http.mp4');
ChewieController? _chewieController;

class _Conner2State extends State<Conner2> {
  @override
  void initState() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: 9 / 20,
      autoPlay: true,
      looping: true,
      autoInitialize: true,
      showControls: false,
    );
    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          /*
          Expanded(child: Chewie(controller: _chewieController!)),
          */

          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 80, left: 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.teal,
                    ),
                    child: Center(
                      child: Text(
                        'WazoMart',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),

              Padding(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome \nto WazoMart',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                        fontSize: 45,
                      ),
                    ),
                    Text('Where we transform buying \n and selling to a \nwhole new',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w900,
                      color: Colors.grey,
                    ),)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

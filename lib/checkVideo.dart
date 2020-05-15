import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
void main(){
  runApp(pvideo());
}
class pvideo extends StatefulWidget {
  @override
  _pickvideoState createState() => _pickvideoState();
}

class _pickvideoState extends State<pvideo> {

  VideoPlayerController _controller;
  bool setButton=true;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
        "https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2Fvideoplayback.mp4?alt=media&token=1b0f44ce-da5a-48c4-83ad-d07b96ed3271")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
        _controller.setLooping(true);
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body:Center(
          child: GestureDetector(
            onTap: (){
              setState(() {
                print("on");
                setState(() {
                  _controller.value.isPlaying
                      ? _controller.pause()
                      : _controller.play();
                });
                setButton=true;
                Future.delayed(const Duration(milliseconds:3000), () {
                  print("off");
                  setState(() {
                    setButton=false;
                  });



                });

              });
            },
            child: Container(

              height:MediaQuery.of(context).size.height*.4,
              width: MediaQuery.of(context).size.width,

              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  VideoPlayer(_controller),
                 // _PlayPauseOverlay(controller: _controller),
                  VideoProgressIndicator(_controller, allowScrubbing: true),
                  Positioned(
                    top: 115,
                    right: 190,
                    child: _controller.value.isBuffering?Center(child: CircularProgressIndicator()):Icon(_controller.value.isPlaying?setButton==false?null:Icons.pause:Icons.play_arrow,
                      size: 50,
                      color: Colors.white),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}

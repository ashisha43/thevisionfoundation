import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
void main(){
  runApp(pickvideo());
}
class pickvideo extends StatefulWidget {
  @override
  _pickvideoState createState() => _pickvideoState();
}
List <VideoPlayerController> vcontroller=List <VideoPlayerController>();
List <File> selectedvideo;
bool videopicked=false;
class _pickvideoState extends State<pickvideo> {
  Future initializeplayer() async{
    print("INITIALIZEPLAYER CALLED");
    print(selectedvideo.length);
    for(int i=0;i<selectedvideo.length;i++){
      vcontroller.add(VideoPlayerController.file(selectedvideo[i])..initialize().then((_){setState(() {  });}));
      vcontroller[i].play();
      vcontroller[i].setVolume(0);
      print(vcontroller[i]);
    }}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Imagepicker"),
          actions: <Widget>[ RaisedButton(
            child: Text("SELECT VIDEO"),
            onPressed: (){
              getimage();
            },
          ),
          ],
        ),
        body: FutureBuilder(builder:( BuildContext context, AsyncSnapshot snapshot){
          if(videopicked){
            initializeplayer();
          }
          return  Center(
              child:selectedvideo==null? Text("VIDEO is not SELECTED")
                  :Container(
                  child: new GridView.builder(
                      itemCount: selectedvideo.length,
                      gridDelegate:
                      new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child:vcontroller[index].value.initialized
                              ?AspectRatio(
                            aspectRatio:vcontroller[index].value.aspectRatio ,
                            child: VideoPlayer(vcontroller[index]),
                          )
                              :Container()
                          ,
                        );
                      }
                  )
              )
          );

        }
        ),
        floatingActionButtonLocation:
        FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(top: 10),
                child:FloatingActionButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.check),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  heroTag: null,
                ),
              ),
            ],
          ),
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  getimage() async{
    //Navigator.push(context,MaterialPageRoute(builder: (context) => mp()));
    List <File> file = await FilePicker.getMultiFile(type: FileType.video);
    print("Your image is $file");
    setState(() {
      selectedvideo=file;
      videopicked=true;
      print("Videopicked=${true}");
    });

  }
}
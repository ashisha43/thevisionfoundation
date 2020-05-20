import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' ;


import 'package:video_player/video_player.dart';
void main(){
  runApp(pickvideo());
}
class pickvideo extends StatefulWidget {
  @override
  _pickvideoState createState() => _pickvideoState();
}
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
List <VideoPlayerController> vcontroller=List <VideoPlayerController>();
List <File> selectedvideo;
bool videopicked=false;
bool removepicked=false;
class _pickvideoState extends State<pickvideo> {

  void initState(){
    print("INITSTATE");
    getimage();
    super.initState();
  }
  Future initializeplayer() async{
    print("INITIALIZEPLAYER CALLED");
    print(selectedvideo.length);
    print(selectedvideo);
    for(int i=0;i<selectedvideo.length;i++){
      vcontroller.add(VideoPlayerController.file(selectedvideo[i])..initialize().then((_){setState(() {  });}));
      vcontroller[i].play();
      vcontroller[i].setVolume(0);
      vcontroller[i].setLooping(true);
      print(vcontroller[i]);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Select Videos"),
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
                  child: removepicked==false? new GridView.builder(
                      itemCount: selectedvideo.length,
                      gridDelegate:
                      new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child:AspectRatio(
                            aspectRatio:vcontroller[index].value.aspectRatio ,
                            child: VideoPlayer(vcontroller[index]),
                          )

                          ,
                        );
                      }
                  ):new GridView.builder(
                      itemCount: selectedvideo.length,
                      gridDelegate:
                      new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int ind) {
                        return Container(
                            color: Colors.blue,
                            child:Card(
                                child: new InkWell(
                                    child:AspectRatio(
                                aspectRatio:vcontroller[ind].value.aspectRatio ,
                                  child: VideoPlayer(vcontroller[ind]),
                                )
                            ,
                                    onTap:() {
                                      print(selectedvideo);
                                      print("************************************************************INDEX IS $ind");
                                      vcontroller.removeAt(ind);
                                      selectedvideo.removeAt(ind);
                                      initializeplayer();
                                      setState(() {

                                      });

                                    }
                                )

                            )
                        );
                      }
                  )



                /*  child: new GridView.builder(
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
                  )*/
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
                    print("FLOATING CALLED");
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                        duration: const Duration(seconds: 4),
                        content:Text("Top on the VIDEO to UNSELECT")

                    ));
                    setState(() {
                      print("rmove picked true");
                      removepicked=true;
                    });
                  },
                  child: Icon(Icons.clear),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
                  heroTag: null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(top: 10),
                      child:FloatingActionButton(
                        onPressed: () {
                          print("POP CONTEXT");
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
      initializeplayer();
  }
}
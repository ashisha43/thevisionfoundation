
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvf/uploadfiles/uploadimage.dart';
import 'package:video_player/video_player.dart';
import 'pickfiles/pickimage.dart';
import 'package:tvf/pickfiles/pickvideos.dart';
import 'package:tvf/setdata/setdata.dart';
import 'package:tvf/pickfiles/pickvideos.dart';
import 'package:path_provider/path_provider.dart';
import 'package:random_string/random_string.dart';
import 'package:tvf/pickfiles/pickimage.dart';

class UploadArticle extends StatefulWidget {
  @override
  _UploadArticleState createState() => _UploadArticleState();
}
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
class _UploadArticleState extends State<UploadArticle> {
  final  authorcontrol=TextEditingController();
  final  desccontrol=TextEditingController();
  final  titlecontrol=TextEditingController();
  static const key = "customCache";

  @override
  void initState(){
    path();
    super.initState();
  }
  Future<void> path() async {
    new Directory('storage/emulated/0/Android/data/com.tvf/cache').create(recursive: true);
    new Directory('storage/emulated/0/tvf').create(recursive: true);
    randomfilenames=randomAlphaNumeric(4);
    flname=File('storage/emulated/0/Android/data/com.tvf/cache/$randomfilenames.txt');
    print(flname);
  }
  @override
  void dispose() {
    print("TXT FILE DESTROYED");
    flname.deleteSync();
    super.dispose();
  }
  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Are you sure to Post?'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text("You won't be able to cancel the upload"),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Yes'),
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context) => uploadimage()));
              },
            ),
            new FlatButton(
              child: new Text('No'),
              onPressed: () {

                Navigator.of(context).pop();

              },
            ),

          ],
        );
      },
    );
  }
  bool allvalid=false;
  void checkvalidation(){

    String authc=authorcontrol.text;
    String descc=desccontrol.text;
    String titlec=titlecontrol.text;
    allvalid=false;
    bool descvalid=false;
    bool titlevalid=false;
    bool authvalid=false;

    if(authc!=''){
      print('AUTHOR VALID');
      authvalid=true;
    }
    if(descc!=''){
      print('DESC VALID');
      descvalid=true;
    }
    if(titlec!=''){
      print('TITLE VALID');
      titlevalid=true;
    }
    if(descvalid&&authvalid&&titlevalid){
      print("ALL VALID TRUE");
      allvalid=true;
    }else{
      showwhatinvalid();
    }

  }
  void showwhatinvalid() {
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.blue,
        content:Text("Please provide Title, Author and Description")
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("CREATE POST"),
          actions: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.blue)
              ),
              color: Colors.blue[800],
              child: Text("UPLOAD IMAGE"),
              onPressed: (){
                checkvalidation();
                if(allvalid){
                  _showcontent();
                }

                // Navigator.push(context,MaterialPageRoute(builder: (context) => uploadimage()));

              },
            )
          ],

        ),
        body:
        Center(
            child: Padding(padding: EdgeInsets.all(16),
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      Container(

                          height: 50,
                          width: MediaQuery. of(context). size. width,
                          child:Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.blue)
                            ),
                            child:  TextField(
                              controller: titlecontrol,
                              decoration: InputDecoration(
                                  hintText: "  TITLE"
                              ),
                              onChanged: (val){
                                settitle(val);
                                print(settitle.post_title);
                              }
                              ,
                            ),
                          )

                      ),
                      SizedBox(height: 8),
                      Container(

                          height: 50,
                          width: MediaQuery. of(context). size. width,
                          child:
                          Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.blue)
                            ),
                            child:  TextField(
                                controller: authorcontrol,

                                decoration: InputDecoration(
                                    hintText: "  AUTHOR NAME"
                                ),
                                onChanged: (val){
                                  setauthor(val);
                                  print(setauthor.author);
                                }

                            ),
                          )
                      ),
                      SizedBox(height: 8),
                      Container(

                          height: 120,
                          width: MediaQuery. of(context). size. width,
                          child:
                          Card(

                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.blue)
                            ) ,
                            child:  TextField(
                                controller: desccontrol,
                                autofocus: false,
                                maxLines: 10,
                                decoration: InputDecoration(
                                    hintText: "  DESCRIPTION"
                                ),
                                onChanged: (val){
                                  setdesc(val);
                                  print(setdesc.desc);
                                }
                            ),

                          )
                      ),
                      SizedBox(height: 8),
                      Container(
                          height: 160,
                          width: MediaQuery. of(context). size. width,
                          child:Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                                side: BorderSide(color: Colors.blue)
                            ),
                            child:Center(
                                child:selectedimage==null? Text("Image not Attached")
                                    :Container(
                                    padding: EdgeInsets.only(left:10,right:10,bottom:10,top: 10),
                                    child: new GridView.builder(
                                        itemCount: selectedimage.length,
                                        gridDelegate:
                                        new SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3),
                                        itemBuilder: (BuildContext context, int index) {
                                          return Container(
                                              child:Image.file(selectedimage[index], fit: BoxFit.contain)
                                          );
                                        }
                                    )
                                )
                            ),

                          )
                      ),
                      FutureBuilder(builder:( BuildContext context, AsyncSnapshot snapshot){

                        return Container(
                            height: 160,
                            width: MediaQuery. of(context). size. width,
                            child:Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(18.0),
                                    side: BorderSide(color: Colors.blue)
                                ),
                                child:Center(
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
                                )

                            )
                        ) ;
                      })

                    ],
                  ),
                )
            )



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
                    Navigator.push(context,MaterialPageRoute(builder: (context) => pickimage()));

                  },
                  child: Icon(Icons.image),
                  heroTag: null,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10),
                  child:FloatingActionButton(
                    onPressed: () {
                      Navigator.push(context,MaterialPageRoute(builder: (context) => pickvideo()));
                    },
                    child: Icon(Icons.video_library),
                    heroTag: null,
                  ))

            ],
          ),
        )



      /*RaisedButton(
                child:Text("SELECT IMAGE"),
                onPressed:(){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => pickimage()));
            })*/




    );
  }
}
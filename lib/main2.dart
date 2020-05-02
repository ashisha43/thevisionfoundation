
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvf/uploadfiles/uploadimage.dart';
import 'pickfiles/pickimage.dart';
import 'package:tvf/pickfiles/pickvideos.dart';
import 'package:tvf/setdata/setdata.dart';
import 'package:random_string/random_string.dart';
import 'package:tvf/pickfiles/pickimage.dart';


class UploadArticle extends StatefulWidget {
  @override
  _UploadArticleState createState() => _UploadArticleState();
}

class _UploadArticleState extends State<UploadArticle> {
  final  authorcontrol=TextEditingController();
  void initState(){
    new Directory('storage/emulated/0/tvf/').create(recursive: true);

    randomfilenames=randomAlphaNumeric(4);
    flname=File('storage/emulated/0/tvf/$randomfilenames.txt');

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: Text("Publish"),
              onPressed: (){
                if(imagepicked){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => uploadimage()));
                }
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
                      )
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

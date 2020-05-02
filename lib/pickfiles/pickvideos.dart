import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvf/uploadfiles/uploadimage.dart';

void main(){
  runApp(pickvideo());
}
class pickvideo extends StatefulWidget {
  @override
  _pickvideoState createState() => _pickvideoState();
}

List <File> selectedvideo;
bool videopicked=false;
class _pickvideoState extends State<pickvideo> {
  getimage() async{
    //Navigator.push(context,MaterialPageRoute(builder: (context) => mp()));
    List <File> file = await FilePicker.getMultiFile(type: FileType.custom,allowedExtensions: ['mp4']);
    print("Your image is $file");
    setState(() {
      selectedvideo=file;
      videopicked=true;
      print("Videopicked=${true}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Imagepicker"),
          actions: <Widget>[ RaisedButton(
            child: Text("SELECT IMAGE"),
            onPressed: (){
              getimage();
            },
          ),
          ],
        ),
        body: Center(
            child:selectedvideo==null? Text("VIDEO is not SELECTED")
                :Container(
                child: new GridView.builder(
                    itemCount: selectedvideo.length,
                    gridDelegate:
                    new SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          child:Text(selectedvideo[index].toString())
                      );

                    }
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
}

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvf/main.dart';
import 'package:tvf/uploadfiles/uploadimage.dart';

void main(){
  runApp(pickimage());
}
class pickimage extends StatefulWidget {
  @override
  _pickimageState createState() => _pickimageState();
}

List <File> selectedimage;
bool imagepicked=false;
bool removepicked=false;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
class _pickimageState extends State<pickimage> {
  getimage() async{
    //Navigator.push(context,MaterialPageRoute(builder: (context) => mp()));
    List <File> file = await FilePicker.getMultiFile(type: FileType.custom,allowedExtensions: ['jpg','png','jpeg']);
    print("Your image is $file");
    setState(() {
      selectedimage=file;
      imagepicked=true;
      print("Imagepicked=${true}");
    });
    print(selectedimage);
  }


  void initState(){
   getimage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Imagepicker"),
             ),
      body: Center(
          child:selectedimage==null? Text("Image is not loader")
              :Container(
              child: removepicked==false? new GridView.builder(
                  itemCount: selectedimage.length,
                  gridDelegate:
                  new SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        child:Card(
                          child: Image.file(selectedimage[index],fit: BoxFit.contain),
                        )
                    );
                  }
              ): new GridView.builder(
          itemCount: selectedimage.length,
              gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: Colors.blue,
                    child:Card(

                      child: new InkWell(
    child: Image.file(selectedimage[index],fit: BoxFit.contain),
                        onTap:() {
                          selectedimage.removeAt(index);
                          print(selectedimage);
                          setState(() {

                          });
                        }
                      )

                    )
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
                    _scaffoldKey.currentState.showSnackBar(new SnackBar(
                      duration: const Duration(seconds: 4),

                        content:Text("Top on the image to remove")

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
}

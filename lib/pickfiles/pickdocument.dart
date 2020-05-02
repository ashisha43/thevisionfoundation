import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvf/uploadfiles/uploadimage.dart';

void main(){
  runApp(pickdoc());
}
class pickdoc extends StatefulWidget {
  @override
  _pickdocState createState() => _pickdocState();
}

File selectedimage;
bool imagepicked=false;
class _pickdocState extends State<pickdoc> {
  getimage() async{
    //Navigator.push(context,MaterialPageRoute(builder: (context) => mp()));
    File file = await FilePicker.getFile(allowedExtensions: ['docx','pdf','jpeg']);
    print("Your image is $file");
    setState(() {
      selectedimage=file;
      imagepicked=true;
      print("Imagepicked=${true}");
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
          RaisedButton(
            child: Text("UPLOAD IMAGE")
            ,
            onPressed: (){
              if(imagepicked){
               Navigator.push(context,MaterialPageRoute(builder: (context) => uploadimage()));
              }
            },
          )
        ],

      ),
      body: Center(
          child:selectedimage==null? Text("Image is not loader")
              :Container(
            child: Image.file(selectedimage, fit: BoxFit.contain),
          )
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

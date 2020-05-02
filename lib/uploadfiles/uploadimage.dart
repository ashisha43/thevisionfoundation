import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvf/crud.dart';
import 'package:tvf/pickfiles/pickimage.dart';

import 'package:tvf/setdata/setdata.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:random_string/random_string.dart';
import 'package:tvf/main.dart';
import 'package:tvf/showNewsDashboard.dart';
bool isloading=false;
CrudMethods crudMethods= new CrudMethods();

void main(){
  runApp(uploadimage());
}
class uploadimage extends StatefulWidget {
  @override
  _uploadimageState createState() => _uploadimageState();
}

class _uploadimageState extends State<uploadimage> {
  static String downloadurlarr="";
  String downloadurl;
  String txtdownloadurl;
  // ignore: must_call_super
  // ignore: must_call_super
  void initState(){
    uploadimage();
  }



  uploadimage() async{
    print(selectedimage);
    try{
      setState(() {
        isloading=true;
      });
      for(int i=0;i<selectedimage.length;i++){
        if(selectedimage!=null){
          print(1);
          StorageReference firebasStorageRef=FirebaseStorage.instance.ref().child("blogposts").child("UID")
              .child("${randomAlphaNumeric(9)}.jpg");
          print(2);
          final StorageUploadTask uploadTask=firebasStorageRef.putFile(selectedimage[i]);

          print(3);
          print("UPLOAD STARTED");
          downloadurl=await(await uploadTask.onComplete).ref.getDownloadURL();
          downloadurlarr=downloadurlarr+" "+downloadurl;
          print(4);
        }
        else{
          print("Image not selected");
        }
        print("CONCAT URL IS $downloadurlarr");
      }
      try{
        StorageReference firebasStorageRef=FirebaseStorage.instance.ref().child("blogposts").child("UID")
            .child("${randomAlphaNumeric(9)}.txt");
        final StorageUploadTask txtuploadTask=firebasStorageRef.putFile(flname);
        txtdownloadurl=await(await txtuploadTask.onComplete).ref.getDownloadURL();
        print("Storage TXT desc URL is $txtdownloadurl");
      }
      catch(e){
        print("Error on uploading txt $e");
      }

      print("Concat URL IS $downloadurlarr");
      Map <String,String> blogmap={
        "title":settitle.post_title,
        "authorname":setauthor.author,
        "description":setdesc.desc,
        "imageurls":downloadurlarr,
        "desctexturl":txtdownloadurl,
      };


      print("MAP CREATED");
      crudMethods.addData(blogmap).then((result){
        print("FINISHED");
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => ShowNewsDashboard()
            ),
            ModalRoute.withName("/Home")
        );
      });
    }
    catch(Error){
      print("ERROR:${Error}");
    }
  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "appTitle",
      home: Scaffold(
        appBar: AppBar(
          title: Text("text"),
        ),
        body: Center(child:
            isloading != true? Text("SELECT IMAGE"):
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Text("UPLOADING...."),
             Container(
               width: 100,
               height: 100,

                 child: CircularProgressIndicator(),

             )
            ],
          )


        )
      ),
    );
  }
}













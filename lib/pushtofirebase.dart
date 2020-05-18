import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PushdatatoFirebase extends StatefulWidget {
  @override
  _PushdatatoFirebaseState createState() => _PushdatatoFirebaseState();
}

class _PushdatatoFirebaseState extends State<PushdatatoFirebase> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Center(
          child: RaisedButton(
            onPressed: (){
              CreateData();
            },
          ),
        ),


    );
  }
void CreateData() async {
    for (int i = 0; i <= 49; i++) {
      try{await Firestore.instance
          .collection('blogs')
          .document("news"+"$i")
          .updateData({

        "thumbnailurl":"https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2F1.webp?alt=media&token=e5ae4fb5-9eaf-421c-b640-e2454f706685"
      }

      );}
      catch(e)
    {
      continue;
    }
      print("added");
    }
  }
}

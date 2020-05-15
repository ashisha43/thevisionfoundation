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

        "videourl":""
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

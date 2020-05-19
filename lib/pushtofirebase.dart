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
    for (int i = 0; i <= 25; i++) {
      try{await Firestore.instance
          .collection('blogs')
          .document("news"+"$i")
          .updateData({

   //"desctexturl":"https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/blogposts%2FUID%2F0B35531SB.txt?alt=media&token=191d7ba8-d0ac-45be-808d-2c5c5f3a3c4e",
    //"UID":"vSaF2smriYn7CCgdyXhb",
      //  "authorname":"as",
        "imageurls":" https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2F1.webp?alt=media&token=e5ae4fb5-9eaf-421c-b640-e2454f706685 https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2F2020-04-27T163750Z_751756470_R-770x433.jpg?alt=media&token=d3a25d66-79e4-424a-89b6-1099bfacc20b https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2F2.webp?alt=media&token=909e57db-987d-4d4f-9a4f-1c54f3a4a4c2 https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2F4.webp?alt=media&token=5aff8876-669c-4966-96ea-437247a547d7"
        //"isPending":false,
        //"isPublished":true,
        //"isSuspended":false,
        //"position":i,
        //"title":"Uttar Pradesh reports 116 new coronavirus cases, state's total now 2,328",
        //"thumbnailurl":"https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2F1.webp?alt=media&token=e5ae4fb5-9eaf-421c-b640-e2454f706685",
        //"videourl":"",
        //"timeStamp":FieldValue.serverTimestamp()


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

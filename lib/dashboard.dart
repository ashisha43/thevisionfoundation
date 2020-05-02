import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tvf/setData.dart';

import 'authservice.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String _userid;
  String _userFirestName=" ";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getuserid();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
               child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                     Text("Hello "+_userFirestName)
                      ,RaisedButton(
                   child: Text('Signout'),
                     onPressed: () {
                          //AuthService().signOut();
                          print(_userFirestName);
                             print(_userid);
                          },
                                 ),

                    ],
                  ),
                ),

        )
    );
  }
  Future<String> _fatchlistcontent()async{
    Firestore.instance
        .collection('UserRecord')
        .document('$_userid')
        .get()
        .then((DocumentSnapshot ds) {
          setState(() {
            _userFirestName=ds.data['firstname'];
          });

          print("user first name is "+_userFirestName);
       
          return(_userFirestName);
    });}
  void _getuserid() async {
    final FirebaseUser user = await auth.currentUser();
    setState(() {
      _userid=user.uid;
    });

    print("My user ID "+user.uid);
    _fatchlistcontent();


    // here you write the codes to input the data into firestore
  }
}


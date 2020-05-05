import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tvf/Admin/admin.dart';
import 'package:tvf/showContent.dart';
import 'package:tvf/showNewsDashboard.dart';

import 'authservice.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ShowNewsDashboard()
      //ShowContent()
     // AuthService().handleAuth(),
     // AdminDashboard()
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tvf/Admin/userslist.dart';
import 'package:tvf/pickfiles/pickvideos.dart';
import 'package:tvf/showContent.dart';

import 'Admin/admin.dart';
import 'authservice.dart';
import 'creator/creatorDashboard.dart';
import 'main2.dart';
import 'showNewsDashboard.dart';



void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: //ShowNewsDashboard(),
      //ShowContent()
      //AuthService().handleAuth(),
      //AdminDashboard(),
      //CreatorDashboad(),
      UsersList(),
      //pickvideo()
      //initialRoute:'/ShowNewsDashboard' ,
      routes: <String, WidgetBuilder> {
        '/ShowNewsDashboard': (BuildContext context) => new ShowNewsDashboard(),
        '/AdminDashboard': (BuildContext context) => new AdminDashboard(),
        '/CreatorDashboad': (BuildContext context) => new CreatorDashboad(),
        '/Create Post': (BuildContext context) => new UploadArticle()
      },

    );
  }
}

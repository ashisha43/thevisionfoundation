import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tvf/Admin/userInfo.dart';
import 'package:tvf/Admin/userslist.dart';
import 'package:tvf/pickfiles/pickvideos.dart';
import 'package:tvf/setdata/setdata.dart';
import 'package:tvf/showContent.dart';
import 'Admin/admin.dart';
import 'authservice.dart';
import 'creator/creatorDashboard.dart';
import 'main2.dart';
import 'showNewsDashboard.dart';


class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    print("INNNIITTTSTATE");

    super.initState();
  }
  @override
  void dispose() {
    print("DIIISSSPPPOOOSSE");
    // TODO: implement dispose
    super.dispose();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UploadArticle(),
      //ShowNewsDashboard(),
      //ShowContent(),
      //AuthService().handleAuth(),
      //AdminDashboard(),
      //CreatorDashboad(),
      //UsersList(),
      // UserInfoPage(),
      //pickvideo()
      //initialRoute:'/ShowNewsDashboard' ,
      routes: <String, WidgetBuilder> {
        '/ShowNewsDashboard': (BuildContext context) => new ShowNewsDashboard(),
        '/AdminDashboard': (BuildContext context) => new AdminDashboard(),
        '/CreatorDashboad': (BuildContext context) => new CreatorDashboad(),
        '/Create Post': (BuildContext context) => new UploadArticle(),
        '/UserInfoPage':(BuildContext context) => new UserInfoPage(),
        '/UserList':(BuildContext context) => new UsersList(),

      },

    );
  }
}


void main() => runApp(MyApp());




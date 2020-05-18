import 'package:flutter/material.dart';
import 'package:tvf/Admin/userInfo.dart';
import 'package:tvf/Admin/userslist.dart';
import 'package:tvf/pushtofirebase.dart';
import 'package:tvf/showContent.dart';
import 'package:tvf/uploadfiles/uploadimage.dart';
import 'Admin/admin.dart';
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
      home: ShowNewsDashboard(),
      //ShowContent(),
      //AuthService().handleAuth(),
      //AdminDashboard(),
      //CreatorDashboad(),
      //UsersList(),
      //UserInfoPage(),
      //pickvideo()
      //pvideo(),
      //initialRoute:'/ShowNewsDashboard' ,
      //PushdatatoFirebase(),

      routes: <String, WidgetBuilder> {
        '/ShowNewsDashboard': (BuildContext context) => new ShowNewsDashboard(),
        '/AdminDashboard': (BuildContext context) => new AdminDashboard(),
        '/CreatorDashboad': (BuildContext context) => new CreatorDashboad(),
        '/Create Post': (BuildContext context) => new UploadArticle(),
        '/UserInfoPage':(BuildContext context) => new UserInfoPage(),
        '/UserList':(BuildContext context) => new UsersList(),
        '/UploadImage':(BuildContext context) => new uploadimage(),
        '/ShowContent':(BuildContext context)=>new ShowContent()


      },

    );
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tvf/main2.dart';
import 'package:tvf/setData.dart';
import 'package:tvf/showContent.dart';

class ShowNewsDashboard extends StatefulWidget {
  @override
  _ShowNewsDashboardState createState() => _ShowNewsDashboardState();
}

class _ShowNewsDashboardState extends State<ShowNewsDashboard> {
  var dio = Dio();
  CancelToken token = CancelToken();
  List<String> _imageurls=[];
  List<String> _titleurls=[];
  List<String> _desctexturl=[];
  bool isLoaded=false;


  ScrollController _scrollController=ScrollController();
  ScrollController _scrollController2=ScrollController();
  bool _isMoreData=true;
  int _currentindex;
  String dropdownValue = 'Bhilai';
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    permission();
     _fatchlistcontent();
    _scrollController.addListener((){
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent)
        if(_isMoreData){
          print("adderd");
         // _getMoreData();
        }
      else{
        print("No More Data");
        }


    });

  }
  @override
  void dispose() {
   _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Dashboard"),
        backgroundColor: Colors.indigo,
        actions: [
          DropdownMenu(context),
          IconButton(icon: Icon(Icons.home), onPressed: () {
          }),
          IconButton(icon: Icon(Icons.notifications,color: Colors.white,),),



        ],
      ),
       drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                  CircleAvatar(
                    child: Icon(Icons.perm_identity),
                    radius: 40.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:15.0,left: 8.0 ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Welcome",style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white
                        ),),
                        Text("User",style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white
                        ),)
                      ],),
                  ),
                      //Text("Hello")),
                  //Text("User"))


            ],
          ),
                ),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),

              ListTile(
                title: Text('Sign Out'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer
                  Navigator.pop(context);
                },
              ),

              ListTile(
                title: Text('Create Post'),
                onTap: () {
                  // Update the state of the app
                  // ...
                  // Then close the drawer

                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UploadArticle(),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      body:_imageurls.length<6?Center(child: CircularProgressIndicator()):
      RefreshIndicator(
    onRefresh: () async {
     /* setState(() {
        _imageurls.clear();
        _titleurls.clear();
        _desctexturl.clear();

      });
      _fatchlistcontent();*/

    return await Future.delayed(Duration(seconds: 3));
    },child: ListView(
        controller: _scrollController,

        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height*.35,
                  width: MediaQuery.of(context).size.width,

                  child: CarouselSlider.builder(
                    itemCount:5,
                    options: CarouselOptions(

                      viewportFraction:.95,
                      autoPlay: true,
                      enlargeCenterPage: true,
                      onPageChanged: callbackFunction,
                    ),
                    itemBuilder: (context, index) {
                      return Image.network(_imageurls[index],fit: BoxFit.cover,);
                    },
                  )

              ),
              Positioned(
                bottom: 10.0,
                left: 170.0,

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        backgroundColor: _currentindex==0?Colors.blue:Colors.grey[300],
                        radius: 5.0,
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: _currentindex==1?Colors.blue:Colors.grey[300],
                      radius: 5.0,

                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        backgroundColor: _currentindex==2?Colors.blue:Colors.grey[300],
                        radius: 5.0,

                      ),
                    ),
                    CircleAvatar(
                      backgroundColor: _currentindex==3?Colors.blue:Colors.grey[300],
                      radius: 5.0,

                    ),
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CircleAvatar(
                        backgroundColor: _currentindex==4?Colors.blue:Colors.grey[300],
                        radius: 5.0,

                      ),
                    ),
                  ],
                ),
              )
            ],


          ),


           ListView.builder(
             controller: _scrollController2,

        shrinkWrap: true,
        itemCount: _titleurls.length,
        itemBuilder: (context, index) {
            if(index==_titleurls.length)
              {
                if(_isMoreData)
              return Center(child: CircularProgressIndicator());
                else return  Center(child: Text("No More Data"));
              }
       return cardview(_imageurls[index],_titleurls[index],_desctexturl[index]);
        },
      ),

        ],
      ))

     /* Container(
        child: ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: _titleurls.length+1,
          itemBuilder: (context, index) {
            if(index==_titleurls.length)
              {
                if(_isMoreData)
              return Center(child: CircularProgressIndicator());
                else return  Center(child: Text("No More Data"));
              }
              }
         return cardview(_imageurls[index],_titleurls[index]);
          },
        ),
      ),*/
    );
  }

  Widget cardview(String _imageurl,String _titleurl,String _desurl) {
    return Container(
      child: new Card(
        margin: new EdgeInsets.symmetric(horizontal: 15.0,vertical: 6.0),
        elevation: 10.0,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            SetData.desurl=_desurl;
            SetData.imageurl=_imageurl;
            SetData.titleurl=_titleurl;

            Navigator.push(context,
              MaterialPageRoute(builder: (context) => ShowContent(),
              ),
            );
          },
          child: Row(
            children: <Widget>[
              Container(
               height: 80,
                width: 120,

                child:  Image.network(
                  "$_imageurl",
                    fit:BoxFit.fill,

                  loadingBuilder: (context,child,progress){
                    return progress==null?child:Center(child: Icon(Icons.image));
                  },
                ),

              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("$_titleurl",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),),
                ),
              )
            ],
          )
        ),
      ),
    );
  }
  Widget DropdownMenu(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down,color: Colors.white,),
        iconSize: 24,
        style: TextStyle(color: Colors.white),
        onChanged: (String newValue) {
          setState(() {
            dropdownValue = newValue;
          });
        },
        items: <String>['Bhilai', 'Raipur', 'Bilaspur', 'Kawardha']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
  void _getMoreData() {
    setState(() {


    _imageurls.add("https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2F7.webp?alt=media&token=2c6c4cfd-537a-4acd-8905-c051ee6f282f");
    _imageurls.add("https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2F8.webp?alt=media&token=585ded3c-4ecd-4f92-b3d0-dd2df123c6e4");
    _imageurls.add("https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2F9.webp?alt=media&token=89bed87c-4c0a-4cbb-b4a6-b32da89296cc");
    _imageurls.add("https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2FRTR4SEBM-770x433.webp?alt=media&token=a34c5cad-3b67-4b35-89fc-50b3957a3048");
    _imageurls.add("https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2FDinxyJ8U0AEIHvH.jpg?alt=media&token=6d248ef8-a933-40d1-b5fd-56a3ac53055c");

    _titleurls.add("In pics: White tiger mauls 22-year-old man to death in Delhi Zoo");
    _titleurls.add("Modi’s most-trusted bureaucrat | India Today Insight");
    _titleurls.add("Andhra cop on lockdown duty offers Ramzan prayers on empty road as colleagues stand guard");
    _titleurls.add("When will Covid-19 outbreak end in India? Researchers risk a May date");
    _titleurls.add("Quarantine Curation: 10 short films to watch on YouTube if you are bored of OTT platforms");

    print("More Data Added");
     _isMoreData=false;
    });

  }

  callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentindex =index;
      print(_currentindex);

    });

  }

  void _onRememberMeChanged(bool value) {
  }
  Future permission() async {
    final PermissionHandler _permissionHandler = PermissionHandler();
    var result = await _permissionHandler.requestPermissions(
        [PermissionGroup.storage]);
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (permission != PermissionStatus.granted) {

    }
  }
  Future _fatchlistcontent()async{
    await Firestore.instance
        .collection('blogs')
        .document('UID')
        .get()
        .then((DocumentSnapshot ds)async {


      for( int i=ds.data['newscount']-1;i>=0;i--)
      {
         await Firestore.instance
            .collection('blogs')
            .document('news'+'$i')
            .get()
            .then((DocumentSnapshot ds) {
          setState(() {
            _titleurls.add(ds.data['title']);
            _desctexturl.add(ds.data['desctexturl']);
            //_imageurls.add(ds.data['imageurls']);
            String imageurls=ds.data['imageurls'];
            var arr=imageurls.split(" ");
            print("+++++++++++++++++++");
            _imageurls.add(arr[1]);

          });


        });
        print(i);

      }
    });

  }


  /*Future downloader(Dio dio, String url,String filename) async {

    try {
      Response response = await dio.get(
          url,
          onReceiveProgress:showDownloadProgress,
          //Received data with List<int>
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }
          ),
          cancelToken: token
      );
      print(response.headers);
      final Directory directory = await getExternalStorageDirectory();
      final File file = File('${directory.path}/$filename');
      var raf = file.openSync(mode: FileMode.write);
      // response.data is List<int> type
      raf.writeFromSync(response.data);
      await raf.close();
      _read('my_file.txt');
    } catch (e) {
      print(e);
    }
  }
  void showDownloadProgress(received, total) {
    double percentage = (received / total * 100).floorToDouble();

    if (total != -1) {
      print((received / total * 100).toStringAsFixed(0) + "%");

    }
  }
  Future<String> _read(String filename) async {
    String text;

    try {
      final Directory directory = await getExternalStorageDirectory();
      final File file = File('${directory.path}/$filename');
      text = await file.readAsString();
      setState(() {
        =text;
      });

      print(text);
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }*/

}

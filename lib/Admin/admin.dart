import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tvf/Admin/userslist.dart';
import 'package:tvf/drawer.dart';
import 'package:tvf/setData.dart';
import 'package:tvf/showContent.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  var dio = Dio();
  CancelToken token = CancelToken();
  List<String> _imageurls = [];
  List<String> _titleurls = [];
  List<String> _desctexturl = [];
  List<String> _videourl = [];
  List<String>thumbnailurl=[];
  List<int> _position = [];
  int fatchedCount;
  bool isdeletd=false;

  List<String>_postUid=[];
  int _newsCount;
  String image;


  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();


  bool _isMoreData = true;
  int _currentindex;
  String dropdownValue = 'Bhilai';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    permission();
    _fatchNewsCount();
    _fatchlistcontent();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent)
        if (_isMoreData) {
          print("adderd");
          _getMoreData();
        }
        else {
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
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Admin"),
            backgroundColor: Color(0xFF002760),
            actions: [
              DropdownMenu(context),
              IconButton(icon: Icon(Icons.home), onPressed: () {}),
              IconButton(
                icon: Icon(Icons.notifications, color: Colors.white,),),
            ],
            bottom: TabBar(
              indicatorColor: Colors.blue,
              indicatorWeight: 3.5,
              tabs: <Widget>[
                Tab(text: 'Post'),
                Tab(text: 'Creators'),
              ],

            ),
          ),

          drawer: Draw(context),

          body: TabBarView(
              children: [
                _imageurls.length == null ? Center(
                    child: CircularProgressIndicator()) :
                RefreshIndicator(
                    onRefresh: () async {
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(
                          builder: (BuildContext context) => AdminDashboard()));
                    }, child: ListView(

                  controller: _scrollController,

                  children: <Widget>[
                isdeletd?Center(child: CircularProgressIndicator()): ListView.builder(
                      controller: _scrollController2,

                      shrinkWrap: true,
                      itemCount: _titleurls.length + 1,
                      itemBuilder: (context, index) {
                        if (index == _titleurls.length) {
                          if (_isMoreData)
                            return Center(child: CircularProgressIndicator());
                          else
                            return Center(child: Text("No More Data"));
                        }


                        return cardview(_imageurls[index], _titleurls[index],
                            _desctexturl[index], _position[index], thumbnailurl[index],_postUid[index],_videourl[index]);
                      },
                    ),

                  ],
                )
                ),
                UsersList()]
          )


      ),
    );
  }

  Widget cardview(String _imageurl, String _titleurl, String _desurl,
      int _position, String imagetitle,String postUid,String videourl) {
    return StreamBuilder(
        stream: Firestore.instance.collection('blogs').document(
            'news' + '$_position').snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            DocumentSnapshot d = snapshot.data;
            return Container(
              child: new Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                margin: new EdgeInsets.symmetric(
                    horizontal: 15.0, vertical: 6.0),
                elevation: 10.0,
                child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      SetData.desurl = _desurl;
                      SetData.imageurl = _imageurl;
                      SetData.titleurl = _titleurl;
                      SetData.psotUid= postUid;
                      SetData.videoUrl=videourl;
                      print(videourl);

                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ShowContent(),
                        ),
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  "$imagetitle",
                                  fit: BoxFit.fill,
                                  height: 80.0,
                                  width: 120.0,

                                  loadingBuilder: (context, child, progress) {
                                    return progress == null ? child : Container(
                                        height: 80,
                                        width: 120,
                                        child: Center(
                                            child: Icon(Icons.image)));
                                  },
                                ),

                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("$_titleurl", style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18
                                  ),),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(
                              8.0, 0.0, 8.0, 8.0),
                          child: Row(

                            children: <Widget>[
                              RaisedButton(
                                color: (d.data['isPublished'])
                                    ? Colors.green
                                    : Colors.grey[200],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  // side: BorderSide(color: Colors.red)
                                ),
                                child: Text('Publish', style: TextStyle(
                                  color: (d.data['isPublished'])
                                      ? Colors.white
                                      : Colors.black,


                                ),
                                ),

                                onPressed: () {
                                  SetTrue(_position);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: RaisedButton(
                                  color: (d.data['isPublished']) ? Colors
                                      .grey[200] : Colors.amber[400],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    //side: BorderSide(color: Colors.red)
                                  ),
                                  child: Text('Suspend', style: TextStyle(
                                    color: (d.data['isPublished']) ? Colors
                                        .black : Colors.white,

                                  ),),

                                  onPressed: () {
                                    SetFalse(_position);
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: RaisedButton(
                                  color: Colors.grey[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    // side: BorderSide(color: Colors.red)
                                  ),
                                  child: Text('Delete', style: TextStyle(
                                    color: Colors.red,


                                  ),),

                                  onPressed: () {
                                    _shownDeleteDialog(_position, _titleurl);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                ),
              ),
            );
          }
          else {
            return Container();
          }

        }
    );

  }

  Widget DropdownMenu(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: Icon(Icons.arrow_drop_down, color: Colors.white,),
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
    if (_newsCount > 0) {
      setState(() {
        _newsCount = fatchedCount-1;
        _fatchlistcontent();
      });
    }
    else {
      print("No More News");
      setState(() {
        _isMoreData = false;
      });
    }
  }

  callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentindex = index;
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

  Future _fatchlistcontent() async {
    int count=0;
    await Firestore.instance
        .collection('blogs')
        .document('UID')
        .get()
        .then((DocumentSnapshot ds) async {
      for (int i = _newsCount; i >=0; i--) {

        try {
          await Firestore.instance
              .collection('blogs')
              .document('news' + '$i')
              .get()
              .then((DocumentSnapshot ds) {
            setState(() {
              _titleurls.add(ds.data['title']);
              _desctexturl.add(ds.data['desctexturl']);
              _position.add(ds.data['position']);
              _imageurls.add(ds.data['imageurls']);
              _postUid.add(ds.data['UID']);
              _videourl.add(ds.data['videourl']);
              thumbnailurl.add(ds.data['thumbnailurl']);
              fatchedCount=i;
              count++;
            });
          });
          print(i);
        }
        catch (e) {
          print("Position Number" + " $i " + "Not Fatched");
          continue;
        }
        if(count==10)
          {
            break;
          }
      }
    });
  }

  void SetTrue(int position) {
    try{ Firestore.instance
        .collection('blogs')
        .document('news' + "$position")
        .updateData({
      'isPublished': true,
      'isSuspended': false,
      'isPending': false
    }

    );}
    catch(e){
      print(e);
    }
  }

  void SetFalse(int position)  {
     try{Firestore.instance
        .collection('blogs')
        .document('news' + "$position")
        .updateData({
      'isPublished': false,
      'isSuspended': true,
      'isPending': false
    }

    );}
    catch(e)
    {
      print(e);
    }
  }

  void deletePost(int position) async {
    try{await Firestore.instance
        .collection('blogs')
        .document('news' + "$position").delete();}
        catch(e)
    {
      print(e);
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(
        builder: (BuildContext context) => AdminDashboard()));
  }

  void _shownDeleteDialog(int position, String title) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: new Text("Are you sure to delete this post ?"),
          content: new Text("$title"),
          actions: <Widget>[
            Row(
              children: <Widget>[
                new RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    // side: BorderSide(color: Colors.red)
                  ),
                  child: new Text("OK"),
                  color: Colors.green,
                  onPressed: () {

                    Navigator.of(context).pop();
                    setState(() {
                      isdeletd=true;
                    });
                    deletePost(position);

                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      // side: BorderSide(color: Colors.red)
                    ),
                    child: new Text("Cancle"),
                    color: Colors.red,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
            // usually buttons at the bottom of the dialog
          ],
        );
      },
    );
  }

  void _fatchNewsCount() async {
    await Firestore.instance
        .collection('blogs')
        .document('UID')
        .get()
        .then((DocumentSnapshot ds) async {
      setState(() {
        _newsCount = ds.data['newscount2'];
      });
    });
  }


/*void CreateData() async {
    for (int i = 43; i <= 49; i++) {
      try{await Firestore.instance
          .collection('blogs')
          .document("news"+"$i")
          .updateData({
        'UID':"vSaF2smriYn7CCgdyXhb"
      }

      );}
      catch(e)
    {
      continue;
    }
      print("added");
    }
  }*/
  }

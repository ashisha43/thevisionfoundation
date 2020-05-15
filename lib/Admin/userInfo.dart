import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tvf/drawer.dart';
import 'package:tvf/setData.dart';
import 'package:tvf/showContent.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  List<String> _imageurls = [];
  List<String> _titleurls = [];
  List<String> _desctexturl = [];
  List<String> _videourl = [];
  List<String>thumbnailurl=[];
  List<int> _position = [];
  String image;
  int publishCount=0;
  int pendingCount=0;
  int suspendedCount=0;
  String userName=" ";
  String userCity=" ";


  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  bool _isMoreData = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //print("________++++++++"+SetData.psotUid);
    firestoreQuery();
    setPunbilsedCount();
    setPendingCount();
    setSuspendedCount();
   setUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User Info"),
        backgroundColor: Color(0xFF002760),
      ),
      drawer: Draw(context),
      body: _imageurls.length==0?Center(child: Center(child: CircularProgressIndicator())):ListView(
        controller: _scrollController,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 10.0, top: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                        child: Icon(Icons.perm_identity),
                        radius: 40.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text("$userName", style: TextStyle(
                                fontSize: 20.0
                            ),),
                            Text("$userCity")
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:15.0),
                        child: RaisedButton(
                          color: Colors.red,

                          shape:RoundedRectangleBorder(
                            borderRadius:BorderRadius.circular(15)    ),
                          onPressed: (){
                              _shownDialog(context);
                          },
                          child: Text("Remove"),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Divider(
                    color: Colors.black,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            new Text("$publishCount"),
                            new Text("Published"),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text("$pendingCount"),
                            Text("Pending"),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text("$suspendedCount"),
                            Text("Suspended"),
                          ],
                        )

                      ],
                    )

                ),
                Divider(
                  color: Colors.black,
                )


              ],
            ),

          ),
          /*RaisedButton(
            child: Text("Querry"),
            onPressed: (){
              firestoreQuarry();
            },
          ),
          RaisedButton(
            child: Text("setTime"),
            onPressed: (){
             SetTime();
            },
          ),*/
          ListView.builder(
            controller: _scrollController2,

            shrinkWrap: true,
            itemCount: _titleurls.length,
            itemBuilder: (context, index) {
              if (index == _titleurls.length) {
                if (_isMoreData)
                  return Center(child: CircularProgressIndicator());
                else
                  return Center(child: Text("No More Data"));
              }
              List<String> arr = thumbnailurl[index].split(" ");
              String imagetitle = arr[1];
              return cardview(
                  _imageurls[index], _titleurls[index], _desctexturl[index],
                  _position[index], imagetitle,_videourl[index]);
            },
          ),

        ],

      ),
    );
  }

  void firestoreQuery() async {

    try {
      Firestore.instance
          .collection('blogs')
          .where("UID", isEqualTo: SetData.psotUid)
          .snapshots()
          .listen((data) =>
          data.documents.forEach((doc) =>
              setState(() {
                _titleurls.add(doc['title']);
                _imageurls.add(doc['imageurls']);
                _position.add(doc['position']);
                _desctexturl.add(doc['desctexturl']);
                _videourl.add(doc['videourl']);
                thumbnailurl.add(doc['thumbnailurl']);

                print(doc['position']);
                print(doc['title']);
              })

            //   print(doc["position"])
          ));
    }
    catch (e) {
      print(e);
    }
    print(_titleurls);
    print(_imageurls);
  }

  void SetTime() async {
    await Firestore.instance
        .collection('blogs')
        .document('news' + "100")
        .updateData({
      'timeStamp': FieldValue.serverTimestamp()
    }

    );
  }

  Widget cardview(String _imageurl, String _titleurl, String _desurl,
      int _position, String imagetitle,String videourl) {
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
                      SetData.videoUrl=videourl;

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
                                        child: Center(child: Icon(Icons.image)));
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
  setPunbilsedCount(){
    try {
      Firestore.instance
          .collection('blogs')
          .where("UID",isEqualTo: SetData.psotUid)
          .where("isPublished", isEqualTo:  true)
          .snapshots()
          .listen((data) =>
          setState(() {
            publishCount=data.documents.length;

          })

        //   print(doc["position"])
      );
      print("**********************************************");
    }
    catch (e) {
      print("nototot");
      print(e);
    }
    print("$publishCount");
  }
  setPendingCount(){
    try {
      Firestore.instance
          .collection('blogs')
          .where("UID",isEqualTo: SetData.psotUid)
          .where("isPending", isEqualTo:  true)
          .snapshots()
          .listen((data) =>
          setState(() {
            pendingCount=data.documents.length;

          })

        //   print(doc["position"])
      );
      print("**********************************************");
    }
    catch (e) {
      print(e);
    }
  }
  setSuspendedCount(){
    try {
      Firestore.instance
          .collection('blogs')
          .where("UID",isEqualTo: SetData.psotUid)
          .where("isSuspended", isEqualTo:  true)
          .snapshots()
          .listen((data) =>
          setState(() {
            suspendedCount=data.documents.length;

          })

        //   print(doc["position"])
      );
      print("**********************************************");
    }
    catch (e) {
      print(e);
    }
  }
  setUserInfo()async{
    print("_______________________"+SetData.psotUid);
   try{
     Firestore.instance.collection("UserRecord").document(SetData.psotUid).get().then((DocumentSnapshot ds){
       setState(() {
         userName=ds.data['firstName'];
         userCity=ds.data['city'];
       });

     });
   }
   catch(e){
     print(e);
   }

  }
  removeUseer()async{
    await Firestore.instance.collection('UserRecord').document(SetData.psotUid).delete();
    print("removed");
  }

  void _shownDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          title: new Text("Are you sure to remove this user ?"),
          content: new Text("press ok to remove this user or press cancle"),
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
                    removeUseer();
                    //  Navigator.popUntil(context, ModalRoute.withName('/AdminDashboard'));
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        '/AdminDashboard',
                        ModalRoute.withName('/AdminDashboard'));
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

    void SetTrue(int position) {
       Firestore.instance
          .collection('blogs')
          .document('news' + "$position")
          .updateData({
        'isPublished': true,
        'isSuspended': false,
        'isPending': false
      }

      );
    }

    void SetFalse(int position)  {
       Firestore.instance
          .collection('blogs')
          .document('news' + "$position")
          .updateData({
        'isPublished': false,
        'isSuspended': true,
        'isPending': false
      }

      );
    }

    void deletePost(int position)  {
      Firestore.instance
          .collection('blogs')
          .document('news' + "$position").delete();
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
                      deletePost(position);
                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context, MaterialPageRoute(
                          builder: (BuildContext context) => UserInfoPage()));
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

  }


/*void CreateData() async {
    for (int i = 0; i < 50; i++) {
      try{await Firestore.instance
          .collection('blogs')
          .document('news' + "$i")
          .updateData({
        'isPending': false,
        "isSuspended": false
      }

      );}
      catch(e)
    {
      continue;
    }
      print("added");
    }
  }*/

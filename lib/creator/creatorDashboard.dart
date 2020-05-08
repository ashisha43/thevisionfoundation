import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tvf/drawer.dart';
import 'package:tvf/setData.dart';
import 'package:tvf/showContent.dart';

class CreatorDashboad extends StatefulWidget {
  @override
  _CreatorDashboadState createState() => _CreatorDashboadState();
}

class _CreatorDashboadState extends State<CreatorDashboad> {
  List<String> _imageurls = [];
  List<String> _titleurls = [];
  List<String> _desctexturl = [];
  List<int> _position = [];
  String image;
  int publishCount=0;
  int pendingCount=0;
  int suspendedCount=0;


  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();
  bool _isMoreData = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firestoreQuery();
    setPunbilsedCount();
    setPendingCount();
    setSuspendedCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Creator Dashboard"),
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
                        child: Text("William James", style: TextStyle(
                            fontSize: 20.0
                        ),),
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
              List<String> arr = _imageurls[index].split(" ");
              String imagetitle = arr[1];
              return cardview(
                  _imageurls[index], _titleurls[index], _desctexturl[index],
                  _position[index], imagetitle);
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
          .where("UID", isEqualTo: "ashish").orderBy(
          "timeStamp", descending: true)
          .snapshots()
          .listen((data) =>
          data.documents.forEach((doc) =>
              setState(() {
                _titleurls.add(doc['title']);
                _imageurls.add(doc['imageurls']);
                _position.add(doc['position']);
                _desctexturl.add(doc['desctexturl']);
                print(doc['position']);
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
      int _position, String imagetitle) {
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: 5.0,
                                      backgroundColor: (d.data['isPublished'])
                                          ? Colors.green
                                          : Colors.grey[200]
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text("Published"),
                                  )
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: 5.0,
                                      backgroundColor: (d.data['isPending'])
                                          ? Colors.amber
                                          : Colors.grey
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text("Pending"),
                                  )
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: 5.0,
                                      backgroundColor: (d.data['isSuspended'])
                                          ? Colors.red
                                          : Colors.grey
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text("Suspended"),
                                  )
                                ],
                              ),
                             /* RaisedButton(
                                  onPressed: () {
                                    CreateData();
                                  }
                              )*/

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
      .where("UID",isEqualTo: "ashish")
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
          .where("UID",isEqualTo: "ashish")
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
          .where("UID",isEqualTo: "ashish")
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
}

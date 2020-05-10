import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tvf/drawer.dart';
import 'package:tvf/setData.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  TextEditingController editingController = TextEditingController();

  //final duplicateItems = List<String>.generate(100, (i) => "Item $i");
  List<String>userName=[];
  List<String>userCity=[];
  List<String> itemsUserName=[];
  List<String>itemsUserCity=[];
  bool isSearchByName=false;
  bool isSearchByCity=false;
  bool isSearchBox=false;
  int userCount=0;
  int listCount=0;
  List<String>postUid=[];

  ScrollController _scrollController=ScrollController();
  ScrollController _scrollController2=ScrollController();

  @override
  void initState() {
    _fatchUserCount();
    _fatchUserInfo();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: _scrollController,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(Icons.supervised_user_circle,
                color: Color(0xFF002760),
                size: 70,),
              Text("Total Users",
                style: TextStyle(
                    fontSize: 30
                ),),
              Text("$userCount",
                style: TextStyle(
                    fontSize: 20
                ),)
            ],
          ),
          Divider(
            color: Colors.black,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: Text("Search By Name"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  // side: BorderSide(color: Colors.red)
                ),
                onPressed: (){
                  setState(() {
                    isSearchByCity=false;
                    isSearchBox=true;
                    isSearchByName=true;
                    editingController.clear();
                    searchByName("");
                    searchByCity("");


                  });
                },
              ),
              RaisedButton(
                child: Text("Search By City"),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  // side: BorderSide(color: Colors.red)
                ),
                onPressed: (){
                  setState(() {
                    isSearchByName=false;
                    isSearchBox=true;
                    isSearchByCity=true;
                   editingController.clear();
                    searchByName("");
                    searchByCity("");


                  });
                },
              )

            ],
          ),
          isSearchBox?Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                isSearchByName?searchByName(value):searchByCity(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),

            ),
          ):Container(),

          ListView.builder(
            controller: _scrollController2,

              shrinkWrap: true,
              itemCount: listCount,
              itemBuilder: (context, index) {
                return cardview(itemsUserName[index],itemsUserCity[index],postUid[index]);
              }

          )

        ],
      ),
    );
  }

  Widget cardview(String username,String userCity,String postUid) {
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
                  setState(() {
                    print(postUid);
                    SetData.psotUid=postUid;
                  });
                   Navigator.of(context).pushNamed("/UserInfoPage");

                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      CircleAvatar(
                          radius: 30.0,
                          child: Icon(Icons.person)
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(username,
                              style: TextStyle(
                                  fontSize: 22.0
                              ),),
                            Text("$userCity", style: TextStyle(
                                fontSize: 18
                            ),),


                          ],
                        ),
                      )
                    ],

                  ),
                )
            )
        )

    );
  }

  void searchByName(String query) {
    List<String> dummyNameList = [];
    dummyNameList.addAll(userName);
    if (query.isNotEmpty) {
      print("onbyname");
      List<String> dummyNameData = [];
      dummyNameList.forEach((item) {
        if (item.contains(query)) {
          dummyNameData.add(item);
        }
      });
      setState(() {
        itemsUserName.clear();
        itemsUserName.addAll(dummyNameData);
        listCount=itemsUserName.length;
      });
      return;
    } else {
      setState(() {
        itemsUserName.clear();
        itemsUserName.addAll(userName);
        listCount=itemsUserName.length;
      });
    }
  }

  void searchByCity(String query) {
    print("incity");
    List<String> dummyCityList = [];

    dummyCityList.addAll(userCity);
    if (query.isNotEmpty) {
      print("onbycity");

      List<String> dummyCityData = [];
      dummyCityList.forEach((item) {
        if (item.contains(query)) {
          dummyCityData.add(item);

        }
      });
      setState(() {
        itemsUserCity.clear();
        itemsUserCity.addAll(dummyCityData);
        listCount=itemsUserCity.length;
      });
      return;
    } else {
      setState(() {
        itemsUserCity.clear();
        itemsUserCity.addAll(userCity);
        listCount=itemsUserCity.length;
      });
    }
  }

/*void CreateData() async {
    for (int i = 0; i < 9; i++) {
      try{await Firestore.instance
          .collection('UserRecord')
          .document()
          .setData({
        'firstName': userName[i],
        "city":city[i]
      }

      );}
      catch(e)
    {
      continue;
    }
      print("added");
    }
  }*/
  _fatchUserCount(){
    Firestore.instance.collection('UserRecord').getDocuments().then((onValue){
      setState(() {
        userCount=onValue.documents.length;
      });

    });
  }
  _fatchUserInfo()async{
   await Firestore.instance.collection('UserRecord').getDocuments().then((onValue){
      onValue.documents.forEach((doc){
        setState(() {

          userName.add(doc["firstName"]);
          userCity.add(doc["city"]);
          postUid.add(doc.documentID);

        });
      });
    });

   itemsUserName.addAll(userName);
   itemsUserCity.addAll(userCity);
   listCount=itemsUserName.length;

  }
}
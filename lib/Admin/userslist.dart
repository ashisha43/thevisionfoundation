import 'package:flutter/material.dart';

class UsersList extends StatefulWidget {
  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  TextEditingController editingController = TextEditingController();
  final duplicateItems = List<String>.generate(100, (i) => "Item $i");
  var items = List<String>();
  @override
  void initState() {
    items.addAll(duplicateItems);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("UsersList"),
      ),
      body: ListView(
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
              Text("100",
                style: TextStyle(
                    fontSize: 20
                ),)
            ],
          ),
          Divider(
            color: Colors.black,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                filterSearchResults(value);
              },
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),

            ),
          ),
          ListView.builder(

              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return cardview(items[index]);
              }

          )

        ],
      ),
    );
  }

  Widget cardview(String item) {
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
                            Text("User name",
                              style: TextStyle(
                                  fontSize: 20.0
                              ),),
                            Text("City: Raipur", style: TextStyle(
                                fontSize: 15
                            ),),
                            Text("$item", style: TextStyle(
                                fontSize: 15
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

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    dummySearchList.addAll(duplicateItems);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(duplicateItems);
      });
    }
  }
}
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvf/main2.dart';
import 'package:tvf/setdata/setdata.dart';
class fulldescedit extends StatefulWidget {
  @override
  _fulldesceditState createState() => _fulldesceditState();
}

class _fulldesceditState extends State<fulldescedit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.fromLTRB(20,20,20,20),
      child: ListView(
        children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(

                height:MediaQuery.of(context).size.height*0.07,
                child:  Text("DESCRIPTION",

                  style: TextStyle( height:2,fontSize: 20,color: Colors.indigo),)
            ),
            SizedBox(width: 140),
            FlatButton(onPressed: ()=>Navigator.pop(context),
                child: Icon(Icons.check,
                color: Colors.indigo,),

            )

          ],
        ),
          Container(
            height:MediaQuery.of(context).size.height*0.8,
            width: MediaQuery. of(context). size. width,

            child: Card(
              color: Colors.white70,
                child:Padding(padding: EdgeInsets.fromLTRB(10,10,10,10),
                  child:   TextField(
                      //textAlign: TextAlign.center,
                      controller: desccontrol,
                      autofocus: false,
                      maxLines: 37,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        hintText: "  DESCRIPTION",
                        suffixIcon: IconButton(
                          onPressed: () => desccontrol.clear(),
                          icon: Icon(Icons.clear),
                          color: Colors.indigo,
                        ),
                      ),
                      onChanged: (val){
                        setdesc(val);
                        print(setdesc.desc);
                      }
                  ),
                )
            ),
          ),
        ],
      )
      ),
      )

        ;
  }
}

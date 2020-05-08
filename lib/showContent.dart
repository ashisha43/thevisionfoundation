import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tvf/drawer.dart';
import 'package:tvf/setData.dart';
class ShowContent extends StatefulWidget {
  @override
  _ShowContentState createState() => _ShowContentState();
}

class _ShowContentState extends State<ShowContent> {

  var dio = Dio();
  CancelToken token = CancelToken();
  TextStyle defaultStyle = TextStyle(fontSize: 18, color: Colors.black);
  String usertext;
  String texturl=SetData.desurl;
  String imageurl=SetData.imageurl;
  String titleurl=SetData.titleurl;
  List<String>arrText=[];
  List<String>images=[];
  String text;
  int _currentindex;
  @override
  void initState() {

    List<String> arr=imageurl.split(" ");
    setState(() {
      for(int i=1;i<arr.length;i++)
      images.add(arr[i]);
    });
    // TODO: implement initState
    super.initState();
    //_fatchlistcontent();
    //downloader(dio, "$texturl","my_file.txt");
    http();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Show Content"),
        backgroundColor: Color(0xFF002760),

      ),
      drawer: Draw(context),
      body: usertext==null?Center(child: CircularProgressIndicator()):
      Container(
          child: ListView(
            children: <Widget>[
              /*RaisedButton(
                child: Text("dwonload"),
                onPressed: (){
                  downloader(dio, "https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2Ftext.txt?alt=media&token=4c02d0df-3acc-4970-8b0e-6bec576fc2dc","my_file.txt");
          },
              ),*/
              /*RaisedButton(
                child: Text("Read"),
                onPressed: (){

                  _read('my_file.txt');

                },
              ),*/
              Text("$titleurl",style:TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold
              ),),
              Stack(
                children: <Widget>[
                  Container(
                      height: MediaQuery.of(context).size.height*.35,
                      width: MediaQuery.of(context).size.width,

                      child: CarouselSlider.builder(
                        itemCount:images.length,

                        options: CarouselOptions(
                          enableInfiniteScroll: images.length==1?false:true,
                          viewportFraction:.95,
                          autoPlay: images.length==1?false:true,
                          enlargeCenterPage: true,
                          onPageChanged: callbackFunction,
                        ),
                        itemBuilder: (context, index) {
                          return Image.network(images[index],fit: BoxFit.cover,);
                        },
                      )

                  ),
                  Positioned(
                    bottom: 10.0,
                    left: 10.0,
                   right: 10.0,
                   child:images.length==1?Container():Container(
                     height: 50,
                     width:double.maxFinite,
                     child: Align(
                       alignment: Alignment.center,
                       child: ListView.builder(
                         scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: images.length,
                          itemBuilder: (context, index) {
                            return  Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: CircleAvatar(
                              backgroundColor: _currentindex==index?Color(0xFF002760):Colors.grey[300],
                              radius: 5.0,
                              ),
                            );
                          },
                        ),
                     ),
                   ),

                  )
                ],


              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                 
                  children: <Widget>[
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage:
                      NetworkImage("https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/images%2Fcirculavtar.jpg?alt=media&token=eb29170f-1f65-42cf-9e5f-9e2ddc870c69"),
                      backgroundColor: Colors.transparent,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text("India Today Web Desk"),
                            Text("New Delhi"),
                            Text("April 28, 2020UPDATED: April 28, 2020 08:10 IST"),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 8.0),
                    child: RichText(
                     text: TextSpan(
                       style: defaultStyle,
                       text: arrText.toString().replaceAll('[', " ").replaceAll(']', " ")

                     ),
                 ),
                  ),

            ],
          ),

      ),
    );
  }


  void http(){
      HttpClient().getUrl(Uri.parse('$texturl'))
        .then((HttpClientRequest request) => request.close())
        .then((HttpClientResponse response) => response.transform(new Utf8Decoder()).listen(onData));

  }


  void onData(String event){
    setState(() {
      usertext=event;
      arrText.add(event);

    });

  }

  callbackFunction(int index, CarouselPageChangedReason reason) {
    setState(() {
      _currentindex =index;
      print(_currentindex);

    });

  }
}

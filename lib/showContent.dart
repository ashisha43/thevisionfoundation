import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

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
  @override
  void initState() {
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
      ),
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
                 Container(
                   height: MediaQuery.of(context).size.height*.35,
                   width: MediaQuery.of(context).size.width,
                   child: Image.network(
                     "$imageurl",

                     loadingBuilder: (context,child,progress){
                       return progress==null?child:Center(child: Center(child: CircularProgressIndicator()));
                     },
                   ),
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

  /*Future<String> _read(String filename) async {
    String text;

    try {
      final Directory directory = await getExternalStorageDirectory();
      final File file = File('${directory.path}/$filename');
        text = await file.readAsString();
        setState(() {
          usertext=text;
        });

      print(text);
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }

  Future<File> _localFile({String path, String type,String yn}) async {

    String _path = 'storage/emulated/0';

    var _newPath = await Directory("storage/emulated/0/CGPSC/"+SetSelectedData.selectedData2).create();
    print("${_newPath.path}/$yn.$type");
    return File("${_newPath.path}/$yn"+SetSelectedData.selectedData2+SetSelectedData.selectedData3+".$type");

  }*/
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
 Future _fatchlistcontent()async{
    Firestore.instance
        .collection('check')
        .document('check')
        .get()
        .then((DocumentSnapshot ds) {
    setState(() {
      usertext2=ds.data['1'];

    });
      print("fatched");

    });}*/
  void http()async{
    await HttpClient().getUrl(Uri.parse('$texturl'))
        .then((HttpClientRequest request) => request.close())
        .then((HttpClientResponse response) => response.transform(new Utf8Decoder()).listen(onData));
  }


  void onData(String event)async{
    setState(() {
      usertext=event;
      arrText.add(event);
      print(arrText.length);

      print("<<<<<<"+usertext+">>>>>>>"
          ".");
    });

  }
}

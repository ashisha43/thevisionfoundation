import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tvf/Admin/admin.dart';
import 'package:tvf/drawer.dart';
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
  List<String> imageCarouselSlider=[];
  int _newsCount;
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
    _fatchNewsCount();
     _fatchlistcontent();

    _scrollController.addListener((){
      if(_scrollController.position.pixels==_scrollController.position.maxScrollExtent)
        if(_isMoreData){
          print("adderd");
          _getMoreData();
        }
      else{
        print("No More Data");
        }


    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Dashboard"),
        backgroundColor: Color(0xFF002760),
        actions: [
          DropdownMenu(context),
          IconButton(icon: Icon(Icons.home), onPressed: () {
          }),
          IconButton(icon: Icon(Icons.notifications,color: Colors.white,),),



        ],
      ),
       drawer:Draw(context),
      body:imageCarouselSlider.length<5?Center(child: CircularProgressIndicator()):
      RefreshIndicator(
    onRefresh: () async {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => ShowNewsDashboard()
          ),
          ModalRoute.withName("/Home")
      );

     return await Future.delayed(Duration(seconds: 2));
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
                      return Image.network(imageCarouselSlider[index],fit: BoxFit.cover,);
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
            itemCount: _titleurls.length+1,
            itemBuilder: (context, index) {
              if(index==_titleurls.length)
              {
                if(_isMoreData)
                  return Center(child: CircularProgressIndicator());
                else return  Center(child: Text("No More Data"));
              }
              List<String> arr=_imageurls[index].split(" ");
              String imagetitle=arr[1];
              return cardview(_imageurls[index],_titleurls[index],_desctexturl[index],imagetitle);
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

  Widget cardview(String _imageurl,String _titleurl,String _desurl,imagetitle) {
    return Container(
      child: new Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    "$imagetitle",
                    fit:BoxFit.fill,
                    height: 80.0,
                    width: 120.0,

                    loadingBuilder: (context,child,progress){
                      return progress==null?child:Container(
                          height:80,
                          width:120,
                          child: Center(child: Icon(Icons.image)));
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
            ),
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
    if(_newsCount>0)
    {
      setState(() {
        _newsCount=_newsCount-10;
        _fatchlistcontent();
      });
    }
    else{
      print("No More News");
      setState(() {
        _isMoreData=false;
      });

    }

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


      for( int i=_newsCount;i>_newsCount-10;i--)
      {
       try{  await Firestore.instance
            .collection('blogs')
            .document('news'+'$i')
            .get()
            .then((DocumentSnapshot ds) {
              if(ds.data['isPublished']){
          setState(() {
            _titleurls.add(ds.data['title']);
            _desctexturl.add(ds.data['desctexturl']);
            _imageurls.add(ds.data['imageurls']);

          });}
              else{
                print("Position Number"+" $i "+"Not Published");
              }

        });
        print(i);}
        catch(e){
         print("Position Number"+" $i "+"Not Fatched");
         continue;

        }


      }
    });
    _fatchCarouselSliderimage();

  }

  void _fatchNewsCount() async{
    await Firestore.instance
        .collection('blogs')
        .document('UID')
        .get()
        .then((DocumentSnapshot ds)async {
      setState(() {
        _newsCount=ds.data['newscount2'];
      });



    });


  }

  void _fatchCarouselSliderimage() {
    for(int i=0;i<5;i++){
      setState(() {
        List<String> arr=_imageurls[i].split(" ");
        imageCarouselSlider.add(arr[1]);
      });

    }

  }

}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(pickdoc());
}
class pickdoc extends StatefulWidget {
  @override
  _pickdocState createState() => _pickdocState();
}
String URL=" https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/blogposts%2FUID%2F4hckhsNnu.jpg?alt=media&token=a29526e5-450a-46f9-8550-1903e92f1730 https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/blogposts%2FUID%2F554E26316.jpg?alt=media&token=a5345d6e-5b93-40bc-a167-71ca2765ea57 https://firebasestorage.googleapis.com/v0/b/sampletvf-8aa59.appspot.com/o/blogposts%2FUID%2F725767453.jpg?alt=media&token=d53b8a42-9201-493c-9078-8528a79bb46e";
List <String> urllist;
bool goturl=false;
class _pickdocState extends State<pickdoc> {

  @override
  void initState() {
    urllist = URL.split(" ");
    print(urllist);
    goturl=true;
    setState(() {
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Imagepicker"),
          actions: <Widget>[ RaisedButton(
            child: Text("SELECT IMAGE"),
          ),
          ],
        ),
        body: FutureBuilder(
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return  goturl!=true? Container():Center(
                  child:
                  new GridView.builder(
                      itemCount: urllist.length,
                      gridDelegate:
                      new SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          child: Image.network(urllist[index],fit: BoxFit.contain),
                        );
                      }
                  )
              );
            }
        )
    );
  }
}

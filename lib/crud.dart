import 'package:cloud_firestore/cloud_firestore.dart';
class CrudMethods{
int newscount=0;
  Future fetchcount()async {
    await Firestore.instance
        .collection('blogs')
        .document('UID')
        .get()
        .then((DocumentSnapshot ds) {
     newscount= ds.data['newscount'];
    });
print("newsCOUNT IS $newscount");
  }
  Future <void> addData(blogData) async{
    print("Add DATA CALLED");
    await fetchcount();
    String docname="news${newscount}";
    Firestore.instance.collection("blogs").document("$docname").setData(blogData).catchError((e){
      print(e);
    });
    newscount=newscount+1;
    //CHECK
    Firestore.instance.collection("blogs").document("UID").updateData({'newscount':newscount}).catchError((e){
      print(e);
    });
    await Firestore.instance
        .collection('blogs')
        .document('UID')
        .get()
        .then((DocumentSnapshot ds) {
      newscount= ds.data['newscount'];
    });
    print("NEWSCOUNT IS $newscount");
    print("Database upload finished");
  }
}
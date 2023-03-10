import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class MyApplication extends StatefulWidget {
  const MyApplication({Key? key}) : super(key: key);

  @override
  State<MyApplication> createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  var userPref=FirebaseFirestore.instance.collection("Application");
String ?id;
  getid()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
   id = await prefs.getString('id');
   setState(() {

   });





  }
  @override
  void initState() {

   getid();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
print (id);
    return
      Scaffold(
        appBar: AppBar(
          title: Text("My Application"),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        body:
        StreamBuilder<dynamic>(
            stream:userPref.where("userid",isEqualTo: id).snapshots(),
            builder:(context,snapshots){

              if(snapshots.hasError){
                return Text("erorr");
              }
              if (snapshots.hasData){
                return ListView.builder(
                  itemCount: snapshots.data.docs!.length,
                  itemBuilder: (context,i)
                  {

                    return
                      Container(
                        height: MediaQuery.of(context).size.height/4,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          //set border radius more than 50% of height and width to make circle
                        ),
                        margin: EdgeInsets.all(30),
                        elevation: 10,
                        // color: Colors.blue,
child:
Column(crossAxisAlignment: CrossAxisAlignment.center,
    children:  [
  Padding(
    padding: EdgeInsets.only(top: 10,right: 10,left: 10),
    child: Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [

            Text("Expected salary :",style: TextStyle(fontWeight: FontWeight.bold),),
            Text(
                "${snapshots.data.docs[i].data()["expected salary"]}")
          ]),

  ),
  Padding(
    padding: EdgeInsets.all(5),
    child:  Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text("Notes :",style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "${snapshots.data.docs[i].data()["notes"]}")
          ]),

  ),
  Padding(
    padding: EdgeInsets.all(5),
    child:  Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text("Start At :",style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "${snapshots.data.docs[i].data()["Start_at"]}")
          ]),

  ),
  Padding(
    padding: EdgeInsets.all(5),
    child:  Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: [
            Text("Created At :",style: TextStyle(fontWeight: FontWeight.bold)),
            Text(
                "${snapshots.data.docs[i].data()["created_at"]}")
          ]),
    ),

  Padding(
    padding: EdgeInsets.all(5),
    child:  Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: [
              Text("Status :",style: TextStyle(fontWeight: FontWeight.bold)),
              if ((snapshots.data.docs[i]
                  .data()["status"])
                  .toString() ==
                  "0")
                Text("Wating")
              else if ((snapshots.data.docs[i]
                  .data()["status"])
                  .toString() ==
                  "1")
                Text("Acceptable")
              else if ((snapshots.data.docs[i]
                    .data()["status"])
                    .toString() ==
                    "2")
                  Text("UnAcceptable"),
            ]),
  ),






]),
                      ),
                    );

                    //   ListTile(
                    //   leading: Icon(Icons.settings_applications_outlined),
                    //  subtitle:Text("${snapshots.data.docs[i].data()["expected salary"]}"),
                    //   title:Text("${snapshots.data.docs[i].data()["notes"]}") ,
                    //   onTap:  (){
                    //   },
                    // );
                  }
                  ,

                );
              }
              return Center(child: CircularProgressIndicator(),);
            }
        ),

      );

  }
}

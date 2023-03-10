import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jobs1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jobs1/UI/Log_In.dart';
import 'package:jobs1/UI/Myapplication.dart';
import 'package:jobs1/UI/Setting.dart';
import 'package:jobs1/UI/addSection.dart';
import 'package:jobs1/UI/sectionDetail.dart';

import 'EditInfo.dart';
import 'Jobs.dart';
import 'Skills.dart';


class Section extends StatefulWidget {
  String role;


  Section(this.role);

  @override
  State<StatefulWidget> createState() {
    return SectionState(this.role);
  }

}

class SectionState extends State<Section> {
  String role;
  SectionState(this.role);
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    if(index==0){

    }
    if(index==1){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>MyApplication()));


    }
    if(index==2){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>Setting(role)));

    }
    setState(() {
      _selectedIndex = index;
      print(_selectedIndex);
    });
  }
  CollectionReference sectionRef = FirebaseFirestore.instance.collection(
      "Section");

signOut() async {
  await FirebaseAuth.instance.signOut();
  Navigator.pushAndRemoveUntil(context,MaterialPageRoute(builder: (context)=>Login()),(Route<dynamic> route) => false);

}
  String? email;
  String? image;
  String? name;

  changeTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var theme = await prefs.getBool('theme');
    if (theme == false)
      await prefs.setBool("theme", true);
    else
      await prefs.setBool("theme", false);
    setState(() {

    });

  }
  getEmail() async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      email = await prefs.getString('email');
      var userPref = FirebaseFirestore.instance.collection("Users");
      var query = await userPref.where("email", isEqualTo: email).get();
      //image = query.docs[0]["image"];
      name = query.docs[0]["name"];
      print("hiiiii");
    }
  catch(e){
    print("hiiiii");
      print(e);
  }


    setState(() {});
    print(name);
  }

  getDetail() async {
    await getEmail();



  }

@override
  void initState() {
  getDetail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return
      (role=="manger")?
      Scaffold(
        drawer: Drawer(

          child:
          Container(
            width:MediaQuery.of(context).size.width/2,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.black,

                      height: MediaQuery.of(context).size.height/3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          image != null
                              ? Center(
                            child: Container(
                                height: MediaQuery.of(context).size.height / 6,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill, image: NetworkImage(image!)),
                                )),
                          )
                              :
                            Container(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 2,
                                      child: Container(

//height: MediaQuery.of(context).size.height,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,

                                          //borderRadius: BorderRadius.circular(100)
                                  //  ,
                                            image: DecorationImage(

                                            fit: BoxFit.fill, image:AssetImage("images/job.jpg")),

                                        ),
                                        // child: Icon(
                                        //   color: Colors.white,
                                        //   Icons.person,
                                        //   size: MediaQuery.of(context).size.width / 4,
                                        // ),
                                      ),


                            ),


Padding(padding: EdgeInsets.only(top: 10)),

  Center(
    child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

      Center(child: Text("${name!}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),




      Card(
          margin: EdgeInsets.all(5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            //set border radius more than 50% of height and width to make circle
          ),
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("${role!}",style: TextStyle(color: Colors.black,fontSize: 15),),
          ))
    ]),
  ),
                       // Center(child: Text("        ${name!}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                          // Padding(padding: EdgeInsets.only(top: 10)),
                          // Center(child: Text("        ${role!}",style: TextStyle(color: Colors.white),)),
                          Padding(padding: EdgeInsets.only(top: 10))
                          ,Center(child: Text("${email!}",style: TextStyle(color: Colors.white,fontSize: 10),)),
                

                        ],
                      ),
                    ),



                    Container(

                      height: MediaQuery.of(context).size.height / 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Row(children: [
                        Padding(padding: EdgeInsets.only(right: 5)),
                        Icon(
                          Icons.account_tree,
                          color: Colors.black,
                          size: 30,
                        ),
                       Padding(padding: EdgeInsets.only(right: 30)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width/1.8,
                          child:
                            InkWell(
                              child: Text(
                                  "Section"
                                      ,style: TextStyle(fontSize: 20),
                              ),
                              onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => MyApplication()));
        } ,
                            )
                          // ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //       backgroundColor:Colors.black ,
                          //     ),
                          //     onPressed: () {
                          //       Navigator.push(context,
                          //           MaterialPageRoute(builder: (context) => MyApplication()));
                          //     }, child: Text("Section")),
                        ),
                      ]),
                    ),

                    Container(

                      height: MediaQuery.of(context).size.height / 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Row(children: [
                        Icon(
                          Icons.settings,
                          color: Colors.black,
                          size: 30,
                        ),
                      Padding(padding: EdgeInsets.only(right: 36)),
                      SizedBox(
                          width: MediaQuery.of(context).size.width/1.8,
                          child:
                          InkWell(
                            child: Text(
                              "Setting"
                              ,style: TextStyle(fontSize: 20),
                            ),
                            onTap:  () { Navigator.push(context,MaterialPageRoute(builder: (context)=>Setting(role)));}
                          )),
                        // Padding(padding: EdgeInsets.only(right: 20)),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width / 1.8,
                        //   child: ElevatedButton(
                        //       style: ElevatedButton.styleFrom(
                        //         backgroundColor:Colors.black ,
                        //       ),
                        //       onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context)=>Setting()));}, child: Text("Setting")),
                        // ),
                      ]),
                    ),
                    Container(

                      height: MediaQuery.of(context).size.height / 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Row(children: [
                        Icon(
                          Icons.logout_sharp,
                          color: Colors.black,
                          size: 30,
                        ),
                        Padding(padding: EdgeInsets.only(right: 36)),
                        SizedBox(
                            width: MediaQuery.of(context).size.width/1.8,
                            child:
                            InkWell(
                                child: Text(
                                  "Logout"
                                  ,style: TextStyle(fontSize: 20),
                                ),
                                onTap:  () async{
                                  signOut();
                                          SharedPreferences prefs = await SharedPreferences.getInstance();
                                          prefs.remove('email');
                                          prefs.remove('id');
                                          prefs.remove('theme');
                                 }
                            )),
                        // Padding(padding: EdgeInsets.only(right: 20)),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width / 1.8,
                        //   child: ElevatedButton(
                        //       style: ElevatedButton.styleFrom(
                        //         backgroundColor:Colors.black ,
                        //       ),
                        //       onPressed: () async {
                        //         signOut();
                        //         SharedPreferences prefs = await SharedPreferences.getInstance();
                        //         prefs.remove('email');
                        //         prefs.remove('id');
                        //         prefs.remove('theme');
                        //       },
                        //       child: Text("Logout")),
                        // ),
                      ]),
                    ),
                  ],
                )),
          ),
        ),
        appBar: AppBar(backgroundColor: Colors.black,
        title: Text("Section"),
        centerTitle: true,
        actions: [

          // IconButton(onPressed: (){
          //   Navigator.push(context,MaterialPageRoute(builder: (context)=>Setting()));
          // }, icon:Icon(Icons.settings)),
        ]),
        backgroundColor: Colors.black,
      body: Container(color: Colors.black,child:StreamBuilder<dynamic>(stream: sectionRef.snapshots(),
            builder:(context,snapshots){

              if(snapshots.hasError){
                return Text("erorr");
              }
              if(snapshots.hasData){
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            //childAspectRatio: 3 / 2,
                          ),
                          itemCount: snapshots.data.docs!.length,
                          itemBuilder: (BuildContext context, int postion) {
                            return  Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)
                              ),
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 2,
                                padding: EdgeInsets.only(top: 6, bottom: 2.0, left: 5.0, right: 5.0),
                                child: InkWell(
                                  child: Column(children: [
                                    //Padding(padding: EdgeInsets.only(top: 10)),
                                    Container(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 5,

                                      //margin: EdgeInsets.only(top: 50),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          image: DecorationImage(
                                              image: NetworkImage("${snapshots.data.docs[postion].data()["image"]}"), fit: BoxFit.fill)),
                                    ),
                                    Container(
                                      //color: Colors.grey,
                                      child: Center(
                                        child: Text(
                                          "${snapshots.data.docs[postion].data()["name"]}" ,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  onTap: () {
                                    showDialog(context: context, builder: (
                                        BuildContext context) {
                                      return
                                        AlertDialog(
                                          elevation: 50,
                                        backgroundColor: Colors.white,
                                        icon:   Icon(Icons.select_all),
                                          title: Text("please select"),
                                          actions: [
                                            InkWell(
                                              child: Row(
                                                
                                                children: [
                                                  Icon(Icons.update),
                                                  Padding(padding: EdgeInsets.only(left: 10)),
                                                  Text("Update Section")
                                                ],
                                              )
                                              , onTap: () {
                                              Navigator.push(context,MaterialPageRoute(builder: (context)=>SectionDetail(snapshots.data.docs[postion].id,"${snapshots.data.docs[postion].data()["image"]}", "${snapshots.data.docs[postion].data()["name"]}" )));
                                            },
                                            ),
                                            Padding(padding: EdgeInsets.all(10),),
                                            InkWell(
                                              child: Row(
                                                children: [
                                                  Icon(Icons.work),
                                                  Padding(padding: EdgeInsets.only(left: 10)),
                                                  Text("show Jobs")
                                                ],
                                              ),
                                              onTap: () {
                                                Navigator.push(context,MaterialPageRoute(builder: (context)=>Jobs("${snapshots.data.docs[postion].id}",role.toString(),"${snapshots.data.docs[postion].data()["name"]}")));
                                              },
                                            )
                                            //onTap: uplodImages(),

                                          ],
                                        );
                                    });

                                  },
                                ));
                            // return _buildCard(
                            // snapshots.data.docs[postion].data()["title"],
                            //  " ${snapshots.data.docs[postion].data()["image"]}",
                            // context);

                          },
                        )),
                    SizedBox(height: 15.0)
                  ],
                );

              }

              return Center(child: CircularProgressIndicator());
            }
        ) ,),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          onPressed: (){
      Navigator.push(context,MaterialPageRoute(builder: (context)=>AddSection()));
    },child: Icon(Icons.add)),



      ):
      Scaffold(
          drawer: Drawer(

            child:
            Container(
              width:MediaQuery.of(context).size.width/2,
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child:
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.black,

                        height: MediaQuery.of(context).size.height/3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            image != null
                                ? Center(
                              child: Container(
                                  height: MediaQuery.of(context).size.height / 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.fill, image: NetworkImage(image!)),
                                  )),
                            )
                                :
                            Container(
                              height: MediaQuery.of(context).size.height / 6,
                              width: MediaQuery.of(context).size.width / 2,
                              child: Container(

//height: MediaQuery.of(context).size.height,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,

                                  //borderRadius: BorderRadius.circular(100)
                                  //  ,
                                  image: DecorationImage(

                                      fit: BoxFit.fill, image:AssetImage("images/job.jpg")),

                                ),
                                // child: Icon(
                                //   color: Colors.white,
                                //   Icons.person,
                                //   size: MediaQuery.of(context).size.width / 4,
                                // ),
                              ),


                            ),


                            Padding(padding: EdgeInsets.only(top: 10)),

                            Center(
                              child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [

                                    Center(child: Text("${name!}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),




                                    Card(
                                        margin: EdgeInsets.all(5),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(50),
                                          //set border radius more than 50% of height and width to make circle
                                        ),
                                        elevation: 5,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text("${role!}",style: TextStyle(color: Colors.black,fontSize: 15),),
                                        ))
                                  ]),
                            ),
                            // Center(child: Text("        ${name!}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),)),
                            // Padding(padding: EdgeInsets.only(top: 10)),
                            // Center(child: Text("        ${role!}",style: TextStyle(color: Colors.white),)),
                            Padding(padding: EdgeInsets.only(top: 10))
                            ,Center(child: Text("${email!}",style: TextStyle(color: Colors.white,fontSize: 10),)),


                          ],
                        ),
                      ),



                      Container(

                        height: MediaQuery.of(context).size.height / 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Row(children: [
                          Padding(padding: EdgeInsets.only(right: 5)),
                          Icon(
                            Icons.account_tree,
                            color: Colors.black,
                            size: 30,
                          ),
                          Padding(padding: EdgeInsets.only(right: 30)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width/1.8,
                              child:
                              InkWell(
                                child: Text(
                                  "Section"
                                  ,style: TextStyle(fontSize: 20),
                                ),
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => MyApplication()));
                                } ,
                              )
                            // ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //       backgroundColor:Colors.black ,
                            //     ),
                            //     onPressed: () {
                            //       Navigator.push(context,
                            //           MaterialPageRoute(builder: (context) => MyApplication()));
                            //     }, child: Text("Section")),
                          ),
                        ]),
                      ),

                      Container(

                        height: MediaQuery.of(context).size.height / 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Row(children: [
                          Icon(
                            Icons.settings,
                            color: Colors.black,
                            size: 30,
                          ),
                          Padding(padding: EdgeInsets.only(right: 36)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width/1.8,
                              child:
                              InkWell(
                                  child: Text(
                                    "Setting"
                                    ,style: TextStyle(fontSize: 20),
                                  ),
                                  onTap:  () { Navigator.push(context,MaterialPageRoute(builder: (context)=>Setting(role)));}
                              )),
                          // Padding(padding: EdgeInsets.only(right: 20)),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width / 1.8,
                          //   child: ElevatedButton(
                          //       style: ElevatedButton.styleFrom(
                          //         backgroundColor:Colors.black ,
                          //       ),
                          //       onPressed: () { Navigator.push(context,MaterialPageRoute(builder: (context)=>Setting()));}, child: Text("Setting")),
                          // ),
                        ]),
                      ),
                      Container(

                        height: MediaQuery.of(context).size.height / 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Row(children: [
                          Icon(
                            Icons.logout_sharp,
                            color: Colors.black,
                            size: 30,
                          ),
                          Padding(padding: EdgeInsets.only(right: 36)),
                          SizedBox(
                              width: MediaQuery.of(context).size.width/1.8,
                              child:
                              InkWell(
                                  child: Text(
                                    "Logout"
                                    ,style: TextStyle(fontSize: 20),
                                  ),
                                  onTap:  () async{
                                    signOut();
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.remove('email');
                                    prefs.remove('id');
                                    prefs.remove('theme');
                                  }
                              )),
                          // Padding(padding: EdgeInsets.only(right: 20)),
                          // SizedBox(
                          //   width: MediaQuery.of(context).size.width / 1.8,
                          //   child: ElevatedButton(
                          //       style: ElevatedButton.styleFrom(
                          //         backgroundColor:Colors.black ,
                          //       ),
                          //       onPressed: () async {
                          //         signOut();
                          //         SharedPreferences prefs = await SharedPreferences.getInstance();
                          //         prefs.remove('email');
                          //         prefs.remove('id');
                          //         prefs.remove('theme');
                          //       },
                          //       child: Text("Logout")),
                          // ),
                        ]),
                      ),
                    ],
                  )),
            ),
          ),
        appBar: AppBar(backgroundColor: Colors.black,

            actions: [

            ]),

        backgroundColor: Colors.black,
        body:
        Container(color: Colors.black,child:StreamBuilder<dynamic>(stream: sectionRef.snapshots(),
            builder:(context,snapshots){

              if(snapshots.hasError){
                return Text("erorr");
              }
              if(snapshots.hasData){
                return ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    SizedBox(height: 15.0),
                    Container(
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                        child: GridView.builder(
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            //childAspectRatio: 3 / 2,
                          ),
                          itemCount: snapshots.data.docs!.length,
                          itemBuilder: (BuildContext context, int postion) {
                            return
                              Container(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height / 4,
                                padding: EdgeInsets.only(top: 2.0, bottom: 2.0, left: 5.0, right: 5.0),
                                child: InkWell(
                                  child: Column(children: [
                                    //Padding(padding: EdgeInsets.only(top: 10)),
                                    Container(
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height / 5,

                                      //margin: EdgeInsets.only(top: 50),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(30),
                                          image: DecorationImage(
                                              image: NetworkImage("${snapshots.data.docs[postion].data()["image"]}"), fit: BoxFit.fill)),
                                    ),
                                    Container(
                                      //color: Colors.grey,
                                      child: Center(
                                        child: Text(
                                          "${snapshots.data.docs[postion].data()["name"]}" ,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            //fontWeight: FontWeight.bold
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]),
                                  onTap: () {
                                    showDialog(context: context, builder: (

                                        BuildContext context) {
                                      return
                                        AlertDialog(
                                          elevation: 50,
                                          backgroundColor: Colors.white,
                                          icon:   Icon(Icons.select_all),
                                          title: Text("please select"),
                                          actions: [

                                            Padding(padding: EdgeInsets.all(10),),
                                            InkWell(
                                              child: Row(
                                                children: [
                                                  Icon(Icons.work),
                                                  Padding(padding: EdgeInsets.only(left: 10)),
                                                  Text("show Jobs")
                                                ],
                                              ),
                                              onTap: () {
                                                Navigator.push(context,MaterialPageRoute(builder: (context)=>Jobs("${snapshots.data.docs[postion].id}",role,"${snapshots.data.docs[postion].data()["name"]}")));
                                              },
                                            )
                                            //onTap: uplodImages(),

                                          ],
                                        );
                                    });

                                  },
                                ));


                          },
                        )),
                    SizedBox(height: 15.0)
                  ],
                );

              }

              return Center(child: CircularProgressIndicator());
            }
        ) ,),
          bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.work),
                label: 'My application',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: _onItemTapped,
          )


      )

    ;
    }

  }
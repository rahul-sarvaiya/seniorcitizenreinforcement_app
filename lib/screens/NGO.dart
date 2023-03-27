import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:seniorcitizen/constant.dart';
import 'package:seniorcitizen/screens/NavBar.dart';

import 'Login.dart';
class Ngo extends StatefulWidget {
  const Ngo({Key? key}) : super(key: key);

  @override
  State<Ngo> createState() => _NgoState();
}

class _NgoState extends State<Ngo> {
  Query db=FirebaseDatabase.instance.ref().child('Government Schemes').child("NGO");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget listItem({required ngos}){
      return Container(
        margin: EdgeInsets.only(bottom: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            color: kPrimaryTextColor,
          ),
          child: Column(
            children: [
              Container(
                color: kPrimaryTextColor,
                child: Image.network(
                  ngos['img'],
                  width: size.width * 0.6,
                  height: size.height*0.16,
                ),
              ),
              Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(13),
                        bottomLeft: Radius.circular(13)),
                    color: kPrimaryColor,
                  ),
                  child: Column(
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text(ngos['name'] ,style: TextStyle(color: textColor2,fontWeight: FontWeight.bold,fontSize: 16.5) ,),
                          ]
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text("Contact No.: " ,style: TextStyle(color: textColor2,fontWeight: FontWeight.bold,fontSize: 14) ,),
                            Text(ngos['contact'] ,style: TextStyle(color: textColor2,fontSize: 13),)
                          ]
                      ),
                      SizedBox(
                        height: 1.5,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:[
                            Text("City: " ,style: TextStyle(color: textColor2,fontWeight: FontWeight.bold,fontSize: 14) ,),
                            Text(ngos['city'] ,style: TextStyle(color: textColor2,fontSize: 13),)
                          ]
                      ),
                    ],
                  ))
            ],
          ));
    }
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        iconTheme: IconThemeData(color: textColor),
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Transform.translate(
            offset: Offset(-40, 1.2),
            child: Text(
              "Senior Citizen Reinforcemnt",
              style: TextStyle(
                  color: textColor,
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold),
            )),
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 35, left: 20, right: 20),
          padding: EdgeInsets.all(30),
          decoration: BoxDecoration(
              color: appbar2,
              borderRadius: BorderRadius.all(Radius.circular(13))),
        ),
        actions: [
          Padding(padding: EdgeInsets.only(right: 25),
              child:IconButton(onPressed: () {
                FirebaseAuth.instance.signOut().then((value) {
                  Navigator.pushReplacement(this.context,
                      MaterialPageRoute(builder: (context) => Login()));
                });
              }, icon: Icon(Icons.logout,size: 21.0,)))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(22),
              child: Text("NGO",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),textAlign:TextAlign.right,),
            ),
            Expanded(
                child: FirebaseAnimatedList(
                  padding: EdgeInsets.only(left: 22,right: 22),
                  shrinkWrap: true,
                  query: db,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,Animation<double> animation, int index) {
                    Map ngos=snapshot.value as Map;
                    ngos['key']=snapshot.key;
                    return listItem(ngos: ngos);
                  },
                ))
          ],
        ),
      ),
      drawer: NavBar(),
    );
  }
}

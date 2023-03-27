import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:seniorcitizen/constant.dart';
import 'package:seniorcitizen/screens/NavBar.dart';

import 'Login.dart';
class Schemes extends StatefulWidget {
  const Schemes({Key? key}) : super(key: key);

  @override
  State<Schemes> createState() => _SchemesState();
}

class _SchemesState extends State<Schemes> {
  Query db=FirebaseDatabase.instance.ref().child('Government Schemes').child("Schemes");


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget listItem({required Map schemes}) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          color: kPrimaryTextColor,
        ),
        child: Column(
          children: [
            Container(
              color: kPrimaryTextColor,
              child: Image.network(
                schemes['img'],
                width: size.width*0.57,
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
                    Text(schemes['name'],
                      style: TextStyle(color: textColor2,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.5),),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Source: ", style: TextStyle(color: textColor2,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),),
                          Text(schemes['source'], style: TextStyle(
                              color: textColor2, fontSize: 13),)
                        ]
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      schemes['des'],
                      textAlign: TextAlign.justify,
                      style: TextStyle(color: textColor2, fontSize: 11.5),
                    )
                  ],
                ))
          ],
        ),
        margin:EdgeInsets.only(bottom: 13) ,
      );
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
              child: Text("Government Schemes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: textColor),textAlign:TextAlign.right,),
            ),
            Expanded(
                child: FirebaseAnimatedList(
                      padding: EdgeInsets.only(left: 22,right: 22),
                      shrinkWrap: true,
                      query: db,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,Animation<double> animation, int index) {
                        Map schemes=snapshot.value as Map;
                        schemes['key']=snapshot.key;
                        return listItem(schemes: schemes);
                      },
                ))
          ],
        ),
      ),
      drawer: NavBar(),
    );
  }
}

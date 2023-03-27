import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:seniorcitizen/constant.dart';
import 'package:seniorcitizen/screens/NavBar.dart';

import 'Login.dart';
class LegalGuidance extends StatefulWidget {
  const LegalGuidance({Key? key}) : super(key: key);

  @override
  State<LegalGuidance> createState() => _LegalGuidanceState();
}

class _LegalGuidanceState extends State<LegalGuidance> {
  Query db=FirebaseDatabase.instance.ref().child('Government Schemes').child("LegalGuidance");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget listItem({required legalguidance}){
      return Container(
        margin: EdgeInsets.only(bottom: 13),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(13)),
            color: kPrimaryColor,
          ),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      bottomLeft: Radius.circular(13)),
                  color: kPrimaryTextColor,
                ),
                child: Image.network(
                  legalguidance['img'],
                  height: size.height*0.14,
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Column(
                    children: [
                      Row(
                          children:[
                            Text(legalguidance['name'] ,style: TextStyle(color: textColor2,fontWeight: FontWeight.bold,fontSize: 15))
                          ]
                      ),
                      SizedBox(
                        height: 1.5,
                      ),
                      Row(
                          children:[
                            Text("Location: " ,style: TextStyle(color: textColor2,fontWeight: FontWeight.bold,fontSize: 14) ,),
                            Text(legalguidance['location'] ,style: TextStyle(color: textColor2,fontSize: 13),)
                          ]
                      ),
                      SizedBox(
                        height: 1.5,
                      ),
                      Row(
                          children:[
                            Text("Experience: " ,style: TextStyle(color: textColor2,fontWeight: FontWeight.bold,fontSize: 14) ,),
                            Text(legalguidance["experience"] ,style: TextStyle(color: textColor2,fontSize: 13),)
                          ]
                      ),
                      SizedBox(
                        height: 1.5,
                      ),
                      Row(
                          children:[
                            Text("Conatct No.: " ,style: TextStyle(color: textColor2,fontWeight: FontWeight.bold,fontSize: 14) ,),
                            Text(legalguidance["contact"] ,style: TextStyle(color: textColor2,fontSize: 13),)
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
              child: Text("Legal Guidance",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),textAlign:TextAlign.right,),
            ),
            Expanded(
                child: FirebaseAnimatedList(
                  padding: EdgeInsets.only(left: 22,right: 22),
                  shrinkWrap: true,
                  query: db,
                  itemBuilder: (BuildContext context, DataSnapshot snapshot,Animation<double> animation, int index) {
                    Map legalguidance=snapshot.value as Map;
                    legalguidance['key']=snapshot.key;
                    return listItem(legalguidance: legalguidance);
                  },
                ))
          ],
        ),
      ),
      drawer: NavBar(),
    );
  }
}

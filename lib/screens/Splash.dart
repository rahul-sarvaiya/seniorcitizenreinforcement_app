import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seniorcitizen/constant.dart';
import 'package:seniorcitizen/screens/Login.dart';
import 'package:seniorcitizen/screens/Profile.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    final user= auth.currentUser;
    if(user !=null){
      _navigation();
    }else{
      _navigation2();
    }

  }
  _navigation()async{
    await Future.delayed(Duration(milliseconds: 3000),(){});
    Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context)=>Profile()));
  }
  _navigation2()async{
    await Future.delayed(Duration(milliseconds: 3000),(){});
    Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context)=>Login()));
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/helping.jpg",
              width: size.width * 0.7,
            ),
            SizedBox(height: size.height * 0.03),
            Text(
              "SENIOR CITIZEN REINFORCEMENT APP",
              style: TextStyle(fontWeight: FontWeight.bold,color: kPrimaryTextColor,fontSize: 14),
            ),
          ],
        )));
  }
}

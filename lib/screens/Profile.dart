import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seniorcitizen/constant.dart';
import 'package:seniorcitizen/screens/Login.dart';
import 'package:seniorcitizen/screens/NavBar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

String name="Username";
String email = "Username@gamil.com";
String age="60";
String contact = "9045768099";
int count=0;

class _ProfileState extends State<Profile> {


  Future<void> getData()async {
    setState(() {

    });
  }
  bool update = true;
  bool trigger=false;
  final _formfield = GlobalKey<FormState>();
  final emailcontroller = TextEditingController(text: name);
  final usernamecontroller = TextEditingController(text: email);
  final agecontroller = TextEditingController(text: age);
  final mobilecontroller = TextEditingController(text: contact);

  @override
  void initState() {
    // TODO: implement initState
      if (user != null) {
        final uid = user!.uid;
        dbref = FirebaseDatabase.instance.ref().child("Users").child(uid).child("username");
        Stream<DatabaseEvent> stream = dbref.onValue;
        stream.listen((DatabaseEvent event) {
          name=event.snapshot.value.toString();// DataSnapshot
        });
        usernamecontroller.text=name;
        dbref2 = FirebaseDatabase.instance.ref().child("Users").child(uid).child("email");
        Stream<DatabaseEvent> stream2 = dbref2.onValue;
        stream2.listen((DatabaseEvent event) {
          email=event.snapshot.value.toString();
          // DataSnapshot
        });
        emailcontroller.text=email;
        dbref3 = FirebaseDatabase.instance.ref().child("Users").child(uid).child("age");
        Stream<DatabaseEvent> stream3 = dbref3.onValue;
        stream3.listen((DatabaseEvent event) {
          age=event.snapshot.value.toString();// DataSnapshot
        });
        agecontroller.text=age;

        dbref4 = FirebaseDatabase.instance.ref().child("Users").child(uid).child("contact");
        Stream<DatabaseEvent> stream4 = dbref4.onValue;
        stream4.listen((DatabaseEvent event) {
          contact=event.snapshot.value.toString();// DataSnapshot
        });
        mobilecontroller.text=contact;
      }
      super.initState();
  }
  late DatabaseReference dbref;
  late DatabaseReference dbref2;
  late DatabaseReference dbref3;
  late DatabaseReference dbref4;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    getData();
    return Scaffold(
      backgroundColor: kPrimaryColor3,
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
          Padding(
              padding: EdgeInsets.only(right: 25),
              child: IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pushReplacement(this.context,
                          MaterialPageRoute(builder: (context) => Login()));
                    });
                  },
                  icon: Icon(
                    Icons.logout,
                    size: 21.0,
                  )))
        ],
      ),
      body:Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: _formfield,
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: 22, right: 22, top: 18, bottom: 0),
                      child: Container(
                          padding: const EdgeInsets.only(
                              left: 40, right: 40, top: 25, bottom: 90),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(40),
                                bottomLeft: Radius.circular(40),
                                topRight: Radius.circular(12),
                                topLeft: Radius.circular(12)),
                            color: Colors.white,
                          ),
                          width: double.infinity,
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "assets/images/helping.jpg",
                                width: size.width * 0.65,
                              ),
                            ],
                          ))),
                  Container(
                    transform: Matrix4.translationValues(0.0, -65.0, 0.0),
                    padding: EdgeInsets.only(
                        right: 40, left: 40, bottom: 13, top: 0),
                    child: Container(
                        padding: const EdgeInsets.only(
                            left: 25, bottom: 30, right: 25, top: 30),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: kPrimaryColor,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            const SizedBox(
                              height: 8,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              enabled: trigger,
                              controller: usernamecontroller,
                              decoration: const InputDecoration(
                                labelText: "Enter Name",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                prefixIcon: Icon(Icons.person),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              enabled: trigger,
                              controller: emailcontroller,
                              decoration: const InputDecoration(
                                labelText: "Enter email",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                prefixIcon: Icon(Icons.email),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: agecontroller,
                              decoration: const InputDecoration(
                                labelText: "Enter Age",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                prefixIcon: Icon(Icons.numbers),
                              ),
                              validator: (value){
                                bool emailValid = RegExp("^[5-9]+[0-9]").hasMatch(value!);
                                if(value!.isEmpty){
                                  return("Enter age");
                                }else if(agecontroller.text.length!=2) {
                                  return ("Age should be greater than 50");
                                }else if(!emailValid){
                                  return("Age should be greater than 50");
                                }
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.name,
                              controller: mobilecontroller,
                              decoration: const InputDecoration(
                                labelText: "Enter Mobile No.",
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                prefixIcon: Icon(Icons.call),
                              ),
                              validator: (value){
                                bool emailValid = RegExp("^[7-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]+[0-9]").hasMatch(value!);
                                if(value!.isEmpty){
                                  return("Enter contact number");
                                }else if(mobilecontroller.text.length!=10){
                                  return("Enter valid contact number");
                                }else if(!emailValid){
                                  return("Enter valid contact number");
                                }
                              },
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        )),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -57.0, 0.0),
                    padding:
                        EdgeInsets.only(right: 40, left: 40, bottom: 0, top: 0),
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if(_formfield.currentState!.validate()){
                          print("success");
                            Map<String,String> userss={
                              'username': usernamecontroller.text,
                              'email': emailcontroller.text,
                              'age': agecontroller.text,
                              'contact': mobilecontroller.text
                            };
                            final user = FirebaseAuth.instance.currentUser;
                            if (user != null) {
                              final uid = user.uid;
                              final DatabaseReference ref=FirebaseDatabase.instance.ref().child("Users").child(uid);
                              ref.set(userss);
                              setState(() {
                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Profile()));
                              });
                            }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: btn,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "UPDATE PROFILE",
                        style: TextStyle(
                            fontSize: 15,
                            color: textColor,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
      drawer: NavBar(),
    );
  }
}
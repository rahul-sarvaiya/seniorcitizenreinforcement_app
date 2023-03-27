import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:seniorcitizen/constant.dart';
import 'package:seniorcitizen/screens/Login.dart';
import 'package:seniorcitizen/screens/Profile.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  late DatabaseReference dbref;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbref=FirebaseDatabase.instance.ref().child("Users");
  }
  final _formfield = GlobalKey<FormState>();
  final emailcontroller= TextEditingController();
  final usernamecontroller= TextEditingController();
  final passwardcontroller= TextEditingController();
  bool passToggle=true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(30),
            height: size.height,
            width: double.infinity,
            color: white,
            child:Form(
              key: _formfield,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding: const EdgeInsets.only(
                          left: 25, bottom: 30, right: 25, top: 30),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        color: headnav,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "SIGN UP",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                fontSize: 18
                            ),
                          ),
                          SizedBox(height: size.height * 0.03),
                          TextFormField(
                            controller: usernamecontroller,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              labelText: "Enter Name",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return("Enter Username");
                              }else if(usernamecontroller.text.length<5){
                                return("Enter username length >= 5");
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: emailcontroller,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: "Enter email",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                              prefixIcon: Icon(Icons.email),
                            ),
                            validator: (value){
                              bool emailValid = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+").hasMatch(value!);
                              if(value!.isEmpty){
                                return("Enter Email");
                              }else if(!emailValid){
                                return("Enter Valid Email");
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: passwardcontroller,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: passToggle,
                            decoration: InputDecoration(
                              labelText: "Enter Password",
                              border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: InkWell(
                                onTap: (){
                                  setState(() {
                                    passToggle = !passToggle;
                                  });
                                },
                                child: Icon(passToggle ? Icons.visibility : Icons.visibility_off),
                              ),
                            ),
                            validator: (value){
                              if(value!.isEmpty){
                                return("Enter Password");
                              }else if(passwardcontroller.text.length<5){
                                return("Enter password length >= 5");
                              }
                            },
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if(_formfield.currentState!.validate()){
                                  print("success");
                                  FirebaseAuth.instance.createUserWithEmailAndPassword(
                                      email: emailcontroller.text,
                                      password: passwardcontroller.text
                                  ).then((value){
                                    print("created");
                                    Map<String,String> userss={
                                      'username': usernamecontroller.text,
                                      'email': emailcontroller.text
                                    };
                                    emailcontroller.clear();
                                    usernamecontroller.clear();
                                    passwardcontroller.clear();
                                    String name=emailcontroller.text;
                                    final user = FirebaseAuth.instance.currentUser;
                                    if (user != null) {
                                      final uid = user.uid;
                                      dbref.child(uid).set(userss);
                                    }
                                    Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context)=>Profile()));
                                  }).onError((error, stackTrace){
                                    print("error ${error.toString()}");
                                    Fluttertoast.showToast(msg: error.toString(),
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 2,
                                      backgroundColor: kPrimaryColor,
                                      textColor: textColor,
                                      fontSize: 14
                                    );
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: btn,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                "SIGN UP",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: textColor,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.only(
                          left: 0, bottom: 0, right: 0, top: 15),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(this.context, MaterialPageRoute(builder: (context)=>Login()));
                                  },
                                  child: const Text(
                                    "Already have an account? Login",
                                    style: TextStyle(color: textColor),
                                  ))
                            ],
                          ),
                        ],
                      ))
                ]))));
  }
}
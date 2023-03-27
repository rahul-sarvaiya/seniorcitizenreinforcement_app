import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seniorcitizen/constant.dart';
import 'package:seniorcitizen/screens/Login.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);
  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  final _formfield = GlobalKey<FormState>();
  final emailcontroller= TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Container(
            padding: const EdgeInsets.all(30),
            height: size.height,
            width: double.infinity,
            color: white,
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
                      child:Form(
                          key: _formfield,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "FORGOT PASSWORD",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: textColor,
                                fontSize: 18
                            ),
                          ),
                          SizedBox(height: 25),
                          Row(
                            children:[
                              Text("Reset Password will be send on Email",
                              style: TextStyle(color: textColor),
                            ),
                           ]
                          ),
                          SizedBox(height: 12),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: emailcontroller,
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
                          Container(
                            height: 50,
                            width: double.infinity,

                            child: ElevatedButton(
                              onPressed: () {
                                if(_formfield.currentState!.validate()){
                                  print("success");
                                  FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text).then((value){
                                    Navigator.pop(context);
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
                                "SEND EMAIL",
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
                      ))),
                ])));
  }
}

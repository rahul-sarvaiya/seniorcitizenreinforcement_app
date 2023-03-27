import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:seniorcitizen/constant.dart';
import 'package:seniorcitizen/screens/LegalGuidance.dart';
import 'package:seniorcitizen/screens/LegalRights.dart';
import 'package:seniorcitizen/screens/NGO.dart';
import 'package:seniorcitizen/screens/Profile.dart';
import 'package:seniorcitizen/screens/Schemes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => _NavBarState();

}

bool pro = true;
bool lg = false;
bool lr = false;
bool ngo = false;
bool schemes = false;

String name="Username";
String email = "Username@gamil.com";

class _NavBarState extends State<NavBar> {
  void initState()  {
    // TODO: implement initState
    if (user != null) {
      final uid = user!.uid;
      dbref = FirebaseDatabase.instance.ref().child("Users").child(uid).child("username");
      Stream<DatabaseEvent> stream = dbref.onValue;
      stream.listen((DatabaseEvent event) {
        name=event.snapshot.value.toString();// DataSnapshot
      });

      dbref2 = FirebaseDatabase.instance.ref().child("Users").child(uid).child("email");
      Stream<DatabaseEvent> stream2 = dbref2.onValue;
      stream2.listen((DatabaseEvent event) {
        email=event.snapshot.value.toString();// DataSnapshot
      });
    }

    super.initState();
  }
  late DatabaseReference dbref;
  late DatabaseReference dbref2;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  @override


  void navigation(String Name) async {

    if (Name == "Profile") {
      pro = true;
      lg = false;
      lr = false;
      ngo = false;
      schemes = false;
      Navigator.pushReplacement(
          this.context, MaterialPageRoute(builder: (context) => Profile()));
    } else if (Name == "LegalGuidance") {
      pro = false;
      lg = true;
      lr = false;
      ngo = false;
      schemes = false;
      Navigator.pushReplacement(this.context,
          MaterialPageRoute(builder: (context) => LegalGuidance()));
    } else if (Name == "LegalRights") {
      pro = false;
      lg = false;
      lr = true;
      ngo = false;
      schemes = false;
      Navigator.pushReplacement(
          this.context, MaterialPageRoute(builder: (context) => LegalRights()));
    } else if (Name == "Schemes") {
      pro = false;
      lg = false;
      lr = false;
      ngo = false;
      schemes = true;
      Navigator.pushReplacement(
          this.context, MaterialPageRoute(builder: (context) => Schemes()));
    } else if (Name == "Ngo") {
      pro = false;
      lg = false;
      lr = false;
      ngo = true;
      schemes = false;
      Navigator.pushReplacement(
          this.context, MaterialPageRoute(builder: (context) => Ngo()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: headnav,
      child: ListView(
        padding: EdgeInsets.only(top: 30, left: 10, right: 10),
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              backgroundColor: appbar2,
              child: ClipOval(
                child: Image.asset("assets/images/logoo.png",width: double.infinity,height: double.infinity),
              ),
            ),
            decoration: BoxDecoration(color: headnav),

          ),
          Container(
            transform: Matrix4.translationValues(0.0, -10.0, 0.0),
            child: Divider(
              color: kPrimaryTextColor,
              indent: 12,
              thickness: 0.55,
              endIndent: 12,
            ),
          ),

          ListTile(
            leading: Icon(Icons.person),
            title: Text("Profile"),
            selected: pro,
            selectedColor: kPrimaryTextColor,
            selectedTileColor: appbar,
            onTap: () => navigation("Profile"),
          ),
          ListTile(
              leading: Icon(Icons.handshake),
              title: Text("Legal Guidance"),
              selected: lg,
              selectedColor: kPrimaryTextColor,
              selectedTileColor: appbar,
              onTap: () => navigation("LegalGuidance")),
          ListTile(
            leading: Icon(Icons.menu_book),
            title: Text("Legal Rights"),
            selected: lr,
            selectedColor: kPrimaryTextColor,
            selectedTileColor: appbar,
            onTap: () => navigation("LegalRights"),
          ),
          ListTile(
              leading: Icon(Icons.account_balance),
              title: Text("Government Schemes"),
              selected: schemes,
              selectedColor: kPrimaryTextColor,
              selectedTileColor: appbar,
              onTap: () => navigation("Schemes")),
          ListTile(
            leading: Icon(Icons.nordic_walking),
            title: Text("NGO"),
            selected: ngo,
            selectedColor: kPrimaryTextColor,
            selectedTileColor: appbar,
            onTap: () => navigation("Ngo"),
          ),
        ],
      ),
    );
  }
}

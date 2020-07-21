import 'package:bellasareas/main.dart';
import 'package:bellasareas/model/user.dart';
import 'package:bellasareas/screen/add_property_screen.dart';
import 'package:bellasareas/screen/edit_view_screen.dart';
import 'package:bellasareas/screen/lands_building_screen.dart';
import 'package:bellasareas/screen/login.dart';
import 'package:bellasareas/screen/login_signup.dart';
import 'package:bellasareas/screen/overview_screen.dart';
import 'package:bellasareas/screen/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isLogin = false;
  User user;
  String name= "Nabin Dangol";
  String email= "nabindeveloper@gmail.com";
 
 @override
  Widget build(BuildContext context) {
   
  return SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter,
                //end: Alignment.bottomCenter,
                colors: [
                  Colors.purple[900],
                  Colors.purple[600],
                  Colors.purple[400],
                ]),
          ),
          padding: EdgeInsets.only(top: 40, left: 20, bottom: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              //-----------Profile------------------
              Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.greenAccent,
                    backgroundImage: isLogin
                        ? NetworkImage(
                        "https://www.tni.org/files/styles/content_full_width/public/mspp.jpeg?itok=iWMByTJ3")
                        : AssetImage(
                      "assets/images/bellasareas.PNG",
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      isLogin
                          ? Container():
                           Text(
                        "Developed By:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline),
                      ),
                      Text(
                        isLogin?user.name:
                        name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(isLogin?user.email:email,
                          style: TextStyle(color: Colors.white))
                    ],
                  )
                ],
              ),

              //----------App Drawer Menu Items------------
              Column(
                children: <Widget>[
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(OverViewScreen.routeName);
                    },
                    leading: Icon(
                      Icons.home,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Home",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          LandBuildingScreenHomePage.routeName,
                          arguments: "Lands");
                    },
                    leading: Icon(
                      Icons.map,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Lands",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          LandBuildingScreenHomePage.routeName,
                          arguments: "Buildings");
                    },
                    leading: FaIcon(
                      FontAwesomeIcons.building,
                      color: Colors.white,
                    ),
                    title: Text(
                      "Buildings",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(SearchScreen.routeName);
                    },
                    leading: Icon(Icons.search, color: Colors.white),
                    title: Text(
                      "Search",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      isLogin?
                      Navigator.of(context)
                          .pushNamed(EditViewScreenHomePage.routeName):
                      Navigator.of(context).pushNamed(Login.routName);
                    },
                    leading:
                    FaIcon(FontAwesomeIcons.landmark, color: Colors.white),
                    title: Text(
                      "Your Property",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  ListTile(
                    onTap: () {
                      isLogin?
                      Navigator.of(context)
                          .pushNamed(EditAddPropertyScreen.routeName):
                      Navigator.of(context).pushNamed(Login.routName);
                    },
                    leading: Icon(Icons.add, color: Colors.white),
                    title: Text(
                      "Add Property",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
              isLogin
                  ? GestureDetector(
                onTap: () {
                  setState(() {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context)=>HomePage()));
                  });
                },
                child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
                  : Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed(Login.routName);
                    },
                    child: Text("Log In",
                        style:
                        TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 16,
                    color: Colors.white,
                    width: 2,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.of(context).pushNamed(SignUp.routeName,arguments: "signup");
                    },
                    child: Text("Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                  )
                ],
              )
            ],
          ),
        ),
      );
    }
  }


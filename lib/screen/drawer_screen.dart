import 'package:bellasareas/screen/edit_add_property_screen.dart';
import 'package:bellasareas/screen/lands_building_screen.dart';
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
  bool isLogin = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.purple,
      padding: EdgeInsets.only(top: 40, left: 20, bottom: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
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
                      ? Container()
                      : Text(
                          "Developed By:",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline),
                        ),
                  Text(
                    isLogin ? "User Name" : "Nabin Dangol",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(isLogin ? "userEmail.com" : "nabindangol2@gmail.com",
                      style: TextStyle(color: Colors.white))
                ],
              )
            ],
          ),
          Column(
            children: <Widget>[
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(OverViewScreen.routeName);
                },
                leading: Icon(Icons.home),
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
                leading: Icon(Icons.map),
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
                leading: FaIcon(FontAwesomeIcons.building),
                title: Text(
                  "Buildings",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(SearchScreen.routeName);
                },
                leading: Icon(Icons.search),
                title: Text(
                  "Search",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(EditAddPropertyScreen.routeName);
                },
                leading: FaIcon(FontAwesomeIcons.landmark),
                title: Text(
                  "Your Property",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              ListTile(
                onTap: () {},
                leading: Icon(Icons.add),
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
                      isLogin = false;
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
                        setState(() {
                          isLogin = true;
                        });
                      },
                      child: Text("Log In",
                          style: TextStyle(color: Colors.white, fontSize: 16)),
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
                    Text("Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 16))
                  ],
                )
        ],
      ),
    );
  }
}

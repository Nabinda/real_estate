import 'dart:convert';
import 'package:bellasareas/model/user.dart';
import 'package:bellasareas/provider/auth_provider.dart';
import 'package:bellasareas/screen/add_property_screen.dart';
import 'package:bellasareas/screen/edit_view_screen.dart';
import 'package:bellasareas/screen/lands_building_screen.dart';
import 'package:bellasareas/screen/login.dart';
import 'package:bellasareas/screen/overview_screen.dart';
import 'package:bellasareas/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  bool isInit = true;
  User user;
  String name= "";
  String email= "";
  @override
  void didChangeDependencies() {
  if(isInit){
      getUserData();
    }
  isInit = false;
    super.didChangeDependencies();
  }
  void getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedData =
    json.decode(prefs.getString("userData")) as Map<String, Object>;
    setState(() {
      email = extractedData['email'];
      name = extractedData['name'];
    });
  }
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

                    backgroundImage: NetworkImage(
                        "https://www.tni.org/files/styles/content_full_width/public/mspp.jpeg?itok=iWMByTJ3")

                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(email,
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

                      Navigator.of(context)
                          .pushNamed(EditViewScreenHomePage.routeName);

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
                      Navigator.of(context)
                          .pushNamed(EditAddPropertyScreen.routeName);
                    },
                    leading: Icon(Icons.add, color: Colors.white),
                    title: Text(
                      "Add Property",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
             GestureDetector(
                onTap: () async{
                  Navigator.of(context).pop();
                  await Provider.of<Auth>(context, listen: false).logout();
                  Navigator.of(context).pushReplacementNamed(Login.routName);
                },
                child: Text(
                  "Log Out",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              )
            ],
          ),
        ),
      );
    }
  }


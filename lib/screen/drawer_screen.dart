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
import 'package:bellasareas/utils/custom_theme.dart' as style;

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
            gradient: style.CustomTheme.purpleGradient,
          ),
          padding: EdgeInsets.only(top: 40, left: 20, bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                      Text(name, style: style.CustomTheme.header,),
                      SizedBox(
                        height: 2,
                      ),
                      Text(email,
                          style: style.CustomTheme.kTextStyle)
                    ],
                  )
                ],
              ),

              //----------App Drawer Menu Items------------
              Column(
                children: <Widget>[
                  MenuItem(Icons.home,"Home",() {
                    Navigator.of(context).pushNamed(OverViewScreen.routeName);
                  }),
                  MenuItem(Icons.map,"Lands",() {
                    Navigator.of(context).pushNamed(LandBuildingScreenHomePage.routeName,
                        arguments: "Lands");
                  }),
                  MenuItem(FontAwesomeIcons.building,"Building",() {
                    Navigator.of(context).pushNamed(LandBuildingScreenHomePage.routeName,
                        arguments: "Buildings");
                  }),
                  MenuItem(Icons.search,"Search",() {
                    Navigator.of(context).pushNamed(SearchScreen.routeName);
                  }),
                  MenuItem(FontAwesomeIcons.landmark,"Your Property",() {
                    Navigator.of(context)
                        .pushNamed(EditViewScreenHomePage.routeName);
                  }),
                  MenuItem(FontAwesomeIcons.plus,"Add Property",() {
                    Navigator.of(context)
                        .pushNamed(EditAddPropertyScreen.routeName);
                  }),
                ],
              ),
             GestureDetector(
                onTap: () async{
                  await Provider.of<Auth>(context, listen: false).logout();
                  Navigator.of(context).pushReplacementNamed(Login.routName);
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Log Out",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      );
    }
  }
class MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Function callback;
  MenuItem(this.icon, this.label, this.callback);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 210,
      child: ListTile(
        onTap: callback,
        leading: Icon(icon, color: Colors.white),
        title: Text(
          label,
          style: style.CustomTheme.kTextStyle,
        ),
      ),
    );
  }
}


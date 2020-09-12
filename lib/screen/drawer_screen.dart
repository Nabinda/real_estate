import 'dart:convert';
import 'package:bellasareas/model/user.dart';
import 'package:bellasareas/provider/auth_provider.dart';
import 'package:bellasareas/screen/add_property_screen.dart';
import 'package:bellasareas/screen/edit_view_screen.dart';
import 'package:bellasareas/screen/lands_building_screen.dart';
import 'package:bellasareas/screen/login.dart';
import 'package:bellasareas/screen/overview_screen.dart';
import 'package:bellasareas/screen/wishlist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:bellasareas/utils/custom_theme.dart' as style;

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isInit = true;
  User user;
  void showErrorDialog(String errorDialog) {
    showCupertinoDialog(
        context: context,
        builder: (ctx) {
          return CupertinoAlertDialog(
            title: Text(errorDialog),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }
  void flogOut() async {
    String _returnValue =
        await Provider.of<AuthProvider>(context, listen: false).logOut();
    if (_returnValue == "success") {
      Navigator.of(context).pushNamedAndRemoveUntil(
          Login.routName, (Route<dynamic> route) => false);
    } else {
      showErrorDialog("An Error Occurred. Please try again Later.");
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context,listen: false);
    String name = provider.userName;
    String email = provider.email;
    String profileUrl = provider.imageUrl;
    return Container(
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
                      profileUrl)),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: style.CustomTheme.header,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(email, style: style.CustomTheme.kTextStyle)
                ],
              )
            ],
          ),

          //----------App Drawer Menu Items------------
          Column(
            children: <Widget>[
              MenuItem(Icons.home, "Home", () {
                Navigator.of(context).pushNamed(OverViewScreen.routeName);
              }),
              MenuItem(Icons.map, "Lands", () {
                Navigator.of(context).pushNamed(LandBuildingScreen.routeName,
                    arguments: "Lands");
              }),
              MenuItem(FontAwesomeIcons.building, "Building", () {
                Navigator.of(context).pushNamed(LandBuildingScreen.routeName,
                    arguments: "Buildings");
              }),
              MenuItem(Icons.save, "WishList", () {
                Navigator.of(context).pushNamed(WishList.routeName);
              }),
              MenuItem(FontAwesomeIcons.landmark, "Your Property", () {
                Navigator.of(context).pushNamed(EditViewScreen.routeName);
              }),
              MenuItem(FontAwesomeIcons.plus, "Add Property", () {
                Navigator.of(context)
                    .pushNamed(EditAddPropertyScreen.routeName);
              }),
            ],
          ),
          GestureDetector(
            onTap: () async {
              flogOut();
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

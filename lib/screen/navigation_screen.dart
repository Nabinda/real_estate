//import 'package:bellasareas/screen/drawer_screen.dart';
//import 'package:bellasareas/widgets/app_bar.dart';
//import 'package:flutter/material.dart';
//
//class NavigationScreen extends StatefulWidget {
//  static const routeName = "/Navigation_screen";
//  final String title;
//  final Widget widget;
//  final IconData icon;
//  final Function function;
//  NavigationScreen(this.title,this.widget,this.icon,this.function);
//  @override
//  _NavigationScreenState createState() => _NavigationScreenState(title,widget,icon,function);
//}
//
//class _NavigationScreenState extends State<NavigationScreen> {
//  final String title;
//  final Widget rWidget;
//  final IconData icon;
//  final Function function;
//  _NavigationScreenState(this.title,this.rWidget,this.icon,this.function);
//  @override
//  Widget build(BuildContext context) {
//    return Stack(
//      children: <Widget>[DrawerScreen(), CustomAppBar(title,rWidget,icon,function)],
//    );
//  }
//}

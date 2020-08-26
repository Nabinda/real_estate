//import 'package:bellasareas/screen/wishlist_screen.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:bellasareas/utils/custom_theme.dart' as style;
//class CustomAppBar extends StatefulWidget {
//  final String title;
//  final Widget widget;
//  final IconData icon;
//  final Function function;
//  CustomAppBar(this.title,this.widget,this.icon,this.function);
//  @override
//  _CustomAppBarState createState() => _CustomAppBarState(title,widget,icon,function);
//}
//
//class _CustomAppBarState extends State<CustomAppBar> {
//  final String title;
//  final Widget rWidget;
//  final IconData icon;
//  final Function function;
//  _CustomAppBarState(this.title,this.rWidget,this.icon,this.function);
//  double xOffSet = 0;
//  double yOffSet = 0;
//  double scaleFactor = 1;
//  bool isDrawerOpen = false;
//  void openDrawer() {
//    setState(() {
//      xOffSet = 200;
//      yOffSet = 130;
//      scaleFactor = 0.6;
//      isDrawerOpen = true;
//    });
//  }
//  void closeDrawer() {
//    setState(() {
//      xOffSet = 0;
//      yOffSet = 0;
//      scaleFactor = 1;
//      isDrawerOpen = false;
//    });
//  }
//  @override
//  Widget build(BuildContext context) {
//    return AnimatedContainer(
//      height: MediaQuery.of(context).size.height,
//      transform: Matrix4.translationValues(xOffSet, yOffSet, 0)
//        ..scale(scaleFactor),
//      duration: Duration(milliseconds: 500),
//      decoration: BoxDecoration(
//        gradient: style.CustomTheme.homeGradient,
//        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
//      ),
//      child: Column(
//        children: <Widget>[
//          SizedBox(height: 30),
//          //Custom App Bar
//          Container(
//            margin: EdgeInsets.symmetric(horizontal: 10),
//            decoration: BoxDecoration(
//                boxShadow: style.CustomTheme.textFieldBoxShadow,
//                color: Colors.white,
//                borderRadius: BorderRadius.all(Radius.circular(10.0))),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                isDrawerOpen
//                    ? IconButton(
//                  icon: Icon(
//                    Icons.arrow_back_ios,
//                    color: Colors.purple[500],
//                  ),
//                  onPressed: () {
//                    closeDrawer();
//                  },
//                )
//                    : IconButton(
//                  icon: Icon(
//                    Icons.menu,
//                    color: Colors.purple[500],
//                  ),
//                  onPressed: () {
//                    openDrawer();
//                  },
//                ),
//                Text(
//                  title,
//                  style: style.CustomTheme.headerBlack,
//                ),
//                IconButton(
//                  icon: Icon(
//                    icon,
//                    color: Colors.purple[500],
//                  ),
//                  onPressed: function,
//                )
//              ],
//            ),
//          ),
//          SizedBox(
//            height: 10,
//          ),
//          //Body Part
//          rWidget,
//        ],
//      ),
//    );
//  }
//}

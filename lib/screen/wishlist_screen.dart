import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bellasareas/utils/custom_theme.dart' as style;
import 'package:shimmer/shimmer.dart';

import 'drawer_screen.dart';

class WishList extends StatelessWidget {
  static const routeName = "/wishList_screen";
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final deviceHeight =
        MediaQuery.of(context).size.height;
    final property =
        Provider.of<PropertyProvider>(context, listen: false).wishList;
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(gradient: style.CustomTheme.homeGradient),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: DrawerScreen(),
          ),
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Positioned(
                  left: 8,
                  child: IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: (){
                      DrawerScreen();
                      _scaffoldKey.currentState.openDrawer();
                    },
                  ),
                ),Positioned(
                  top: 2,
                  right: 8,
                  child: IconButton(
                      icon: Icon(Icons.search,size: 30,),
                      onPressed: (){
                        Navigator.of(context).pushNamed(SearchScreen.routeName);}
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.only(left: 90,top: 20),
                        width: MediaQuery.of(context).size.width,
                        height: deviceHeight*0.2- AppBar().preferredSize.height,
                        child: Text(
                          " WishList",
                          style: style.CustomTheme.headerBlackMedium,
                        )),
                    FutureBuilder(
                      future:
                      Provider.of<PropertyProvider>(context, listen: false)
                          .fetchAndSetProperty(),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox(
                            child: Shimmer.fromColors(
                              baseColor: Color(0xffd3d1ff),
                              highlightColor:Color(0xffba68c8),
                              child: Text("Loading"),
                            ),
                          );
                        } else {
                          return Text("Loading");
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

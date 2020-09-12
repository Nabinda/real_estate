import 'package:bellasareas/provider/auth_provider.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/screen/search_screen.dart';
import 'package:bellasareas/widgets/overview_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bellasareas/utils/custom_theme.dart' as style;
import 'package:shimmer/shimmer.dart';

class OverViewScreen extends StatefulWidget {
  static const routeName = "/overViewScreen";
  @override
  _OverViewScreenState createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    Provider.of<AuthProvider>(context, listen: false).getUserInfo();
    Provider.of<AuthProvider>(context,listen: false).addToPrefs();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    final deviceHeight =
        MediaQuery.of(context).size.height;
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
                ),
                Positioned(
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
                      height: deviceHeight*0.25- AppBar().preferredSize.height,
                        child: Text(
                      "Buy or Sell \n Property",
                      style: style.CustomTheme.headerBlackMedium,
                    )),
                    FutureBuilder(
                      future:
                          Provider.of<PropertyProvider>(context, listen: false)
                              .fetchAndSetProperty(false),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox(
                            child: Shimmer.fromColors(
                              baseColor: Color(0xffd3d1ff),
                              highlightColor:Color(0xffba68c8),
                              child: OverViewItem(),
                            ),
                          );
                        } else {
                          return OverViewItem();
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

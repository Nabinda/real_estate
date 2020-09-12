
import 'package:bellasareas/screen/search_screen.dart';
import 'package:bellasareas/utils/custom_theme.dart' as style;
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/screen/add_property_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
class EditViewScreen extends StatefulWidget {
  static const routeName = "/edit_screen";
  @override
  _EditViewScreenState createState() => _EditViewScreenState();
}

class _EditViewScreenState extends State<EditViewScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
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
                      icon: Icon(Icons.add,size: 30),
                      onPressed: (){
                        Navigator.of(context).pushNamed(EditAddPropertyScreen.routeName);
                       }
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left: 70,top: 20),
                        height: deviceHeight*0.25- AppBar().preferredSize.height,
                        child: Text(
                          "Your Property",
                          style: style.CustomTheme.headerBlackMedium,
                        )),
                    FutureBuilder(
                      future:
                      Provider.of<PropertyProvider>(context, listen: false)
                          .fetchAndSetProperty(true),
                      builder: (ctx, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return SizedBox(
                            child: Shimmer.fromColors(
                              baseColor: Color(0xffd3d1ff),
                              highlightColor:Color(0xffba68c8),
                              child: Text(""),
                            ),
                          );
                        }else if(!snapshot.hasData){
                          return Center(child: Text("Add Your Property First!!!",style: style.CustomTheme.header,));
                        }
                        else {
                          return Text("Your Property");
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

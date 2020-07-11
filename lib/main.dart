import 'package:bellasareas/provider/category_provider.dart';
import 'package:bellasareas/provider/district_provider.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/screen/edit_add_property_screen.dart';
import 'package:bellasareas/screen/edit_view_screen.dart';
import 'package:bellasareas/screen/lands_building_screen.dart';
import 'package:bellasareas/screen/overview_screen.dart';
import 'package:bellasareas/screen/property_details_screen.dart';
import 'package:bellasareas/screen/search_screen.dart';
import 'package:bellasareas/screen/wishlist_screen.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_page_transition/flutter_page_transition.dart';
import 'package:flutter_page_transition/page_transition_type.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(SplashClass());
}

class SplashClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PropertyProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DistrictProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          OverViewScreen.routeName: (ctx) => HomePage(),
          SearchScreen.routeName: (ctx) => SearchScreenHomePage(),
          LandBuildingScreenHomePage.routeName: (ctx) =>
              LandBuildingScreenHomePage(),
          PropertyDetailsScreen.routeName: (ctx) => PropertyDetailsScreen(),
          EditAddPropertyScreen.routeName: (ctx) => EditAddPropertyScreen(),
          EditViewScreenHomePage.routeName: (ctx) => EditViewScreenHomePage(),
          WishList.routeName: (ctx) => WishList(),
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[DrawerScreen(), OverViewScreen()],
      ),
    );
  }
}

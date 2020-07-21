import 'package:bellasareas/provider/auth_provider.dart';
import 'package:bellasareas/provider/category_provider.dart';
import 'package:bellasareas/provider/district_provider.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/screen/add_property_screen.dart';
import 'package:bellasareas/screen/edit_view_screen.dart';
import 'package:bellasareas/screen/lands_building_screen.dart';
import 'package:bellasareas/screen/login.dart';
import 'package:bellasareas/screen/login_signup.dart';
import 'package:bellasareas/screen/overview_screen.dart';
import 'package:bellasareas/screen/property_details_screen.dart';
import 'package:bellasareas/screen/search_screen.dart';
import 'package:bellasareas/screen/wishlist_screen.dart';
import 'package:flutter/material.dart';
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
        ChangeNotifierProvider(
          create: (_) => Auth(),
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
          SignUp.routeName: (ctx) => SignUp(),
          Login.routName:(ctx) => Login(),
          HomePage.routeName:(ctx) => HomePage(),
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  static const routeName = "/main_page";
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

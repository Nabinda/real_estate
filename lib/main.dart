import 'package:bellasareas/provider/auth_provider.dart';
import 'package:bellasareas/provider/category_provider.dart';
import 'package:bellasareas/provider/district_provider.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/screen/add_property_screen.dart';
import 'package:bellasareas/screen/edit_view_screen.dart';
import 'package:bellasareas/screen/lands_building_screen.dart';
import 'package:bellasareas/screen/login.dart';
import 'package:bellasareas/screen/signup.dart';
import 'package:bellasareas/screen/overview_screen.dart';
import 'package:bellasareas/screen/property_details_screen.dart';
import 'package:bellasareas/screen/search_screen.dart';
import 'package:bellasareas/screen/wishlist_screen.dart';
import 'package:flare_splash_screen/flare_splash_screen.dart';
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
          create: (_) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, PropertyProvider>(update: (BuildContext context, Auth auth, PropertyProvider previousProperty) {
          return PropertyProvider(auth.token,auth.userId,previousProperty==null?[]:previousProperty.properties);
        },

        ),
        ChangeNotifierProvider(
          create: (_) => CategoryProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => DistrictProvider(),
        ),

      ],
      child: Consumer<Auth>(
        builder: (ctx,auth,_){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: SplashBetween(),
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
          );
        },
      ),
    );
  }
}
class SplashBetween extends StatefulWidget {
  @override
  _SplashBetweenState createState() => _SplashBetweenState();
}

class _SplashBetweenState extends State<SplashBetween> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashScreen.navigate(
        name: "assets/images/splash.flr",
        fit: BoxFit.contain,
        transitionsBuilder: (ctx, animation, second, child) {
          var begin = Offset(1.0, 0.0);
          var end = Offset.zero;
          var tween = Tween(begin: begin, end: end)
              .chain(CurveTween(curve: Curves.easeIn));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        backgroundColor: Colors.purple[700],
        startAnimation: "go",
        loopAnimation: "go",
        until: () => Future.delayed(Duration(seconds: 3)),
        alignment: Alignment.center,
        next: (_) => HomePage(),
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
  bool isInit = true;
  bool isLogin = false;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      checkLogin();
    }
    isInit = false;
  }

  void checkLogin() async {
    isLogin = await Provider.of<Auth>(context).tryAutoLogin();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLogin?Stack(
        children: <Widget>[DrawerScreen(), OverViewScreen()],
      ):Login(),
    );
  }
}

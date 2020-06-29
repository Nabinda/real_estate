import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/screen/lands_building_screen.dart';
import 'package:bellasareas/screen/overview_screen.dart';
import 'package:bellasareas/screen/property_details_screen.dart';
import 'package:bellasareas/screen/search_screen.dart';
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
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
            accentColor: Colors.greenAccent, primaryColor: Colors.green),
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        routes: {
          OverViewScreen.routeName: (ctx) => HomePage(),
          SearchScreen.routeName: (ctx) => SearchScreenHomePage(),
          LandBuildingScreenHomePage.routeName: (ctx) =>
              LandBuildingScreenHomePage(),
          PropertyDetailsScreen.routeName: (ctx) => PropertyDetailsScreen()
        },
//        onGenerateRoute: (RouteSettings routeSettings) {
//          return new PageRouteBuilder<dynamic>(
//              settings: routeSettings,
//              pageBuilder: (BuildContext context, Animation<double> animation,
//                  Animation<double> secondaryAnimation) {
//                switch (routeSettings.name) {
//                  case "PropertyDetailScreen":
//                    return PropertyDetailsScreen();
//                  default:
//                    return null;
//                }
//              },
//              transitionDuration: const Duration(milliseconds: 300),
//              transitionsBuilder: (BuildContext context,
//                  Animation<double> animation,
//                  Animation<double> secondaryAnimation,
//                  Widget child) {
//                return effectMap[PageTransitionType.slideInLeft](
//                    Curves.easeOutCirc, animation, secondaryAnimation, child);
//              });
//        },
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

//class SplashBetween extends StatefulWidget {
//  @override
//  _SplashBetweenState createState() => _SplashBetweenState();
//}
//
//class _SplashBetweenState extends State<SplashBetween> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: SplashScreen.navigate(
//          name: "assets/images/splash.flr2d",
//          startAnimation: "Untitled",
//          loopAnimation: "Untitled",
//          until: () => Future.delayed(Duration(seconds: 3)),
//          alignment: Alignment.center,
//          next: (_) => OverViewScreen()),
//    );
//  }
//}

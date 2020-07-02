import 'package:bellasareas/screen/wishlist_screen.dart';
import 'package:bellasareas/widgets/property_grid_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OverViewScreen extends StatefulWidget {
  static const routeName = "/overViewScreen";
  @override
  _OverViewScreenState createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  double xOffSet = 0;
  double yOffSet = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  void openDrawer() {
    setState(() {
      xOffSet = 200;
      yOffSet = 130;
      scaleFactor = 0.6;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffSet = 0;
      yOffSet = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: MediaQuery.of(context).size.height,
      transform: Matrix4.translationValues(xOffSet, yOffSet, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          //Custom App Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[800],
                    offset: Offset(0, 5),
                    blurRadius: 10.0,
                  ),
                ],
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                isDrawerOpen
                    ? IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.purple[500],
                        ),
                        onPressed: () {
                          closeDrawer();
                        },
                      )
                    : IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: Colors.purple[500],
                        ),
                        onPressed: () {
                          openDrawer();
                        },
                      ),
                Text(
                  "Bellas Areas",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(
                    Icons.save,
                    color: Colors.purple[500],
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(WishList.routeName);
                  },
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //Body Part
          Container(
              height: MediaQuery.of(context).size.height * 0.87,
              child: PropertyGridView()),
        ],
      ),
    );
  }
}

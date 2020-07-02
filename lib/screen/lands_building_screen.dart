import 'package:bellasareas/model/property.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/screen/wishlist_screen.dart';
import 'package:bellasareas/widgets/property_grid_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum SortOption { Highest, Lowest }

class LandBuildingScreenHomePage extends StatefulWidget {
  static const routeName = "/land_screen";
  @override
  _LandBuildingScreenHomePageState createState() =>
      _LandBuildingScreenHomePageState();
}

class _LandBuildingScreenHomePageState
    extends State<LandBuildingScreenHomePage> {
  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      body: Stack(
        children: <Widget>[DrawerScreen(), LandBuildingScreen(category)],
      ),
    );
  }
}

class LandBuildingScreen extends StatefulWidget {
  final category;
  LandBuildingScreen(this.category);
  @override
  _LandBuildingScreenState createState() => _LandBuildingScreenState(category);
}

class _LandBuildingScreenState extends State<LandBuildingScreen> {
  final category;
  _LandBuildingScreenState(this.category);
  List<Property> property;
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
    category == "Lands"
        ? property =
            Provider.of<PropertyProvider>(context, listen: false).landProperties
        : property = Provider.of<PropertyProvider>(context, listen: false)
            .buildingProperties;
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
          //-------------Sorting Part-----------
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 15.0),
                  child: Text(
                    "Available Properties",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.purple),
                  )),
              PopupMenuButton(
                itemBuilder: (_) => [
                  PopupMenuItem(
                    child: Text("By Highest"),
                    value: SortOption.Highest,
                  ),
                  PopupMenuItem(
                    child: Text("By Lowest"),
                    value: SortOption.Lowest,
                  ),
                ],
                onSelected: (SortOption sortOption) {
                  setState(() {
                    if (sortOption == SortOption.Highest) {
                      print(property);
                    } else {
                      property.sort((Property a, Property b) {
                        print(a.price);
                        return b.price.toInt().compareTo(a.price.toInt());
                      });
                    }
                  });
                },
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.sort,
                      color: Colors.white,
                    ),
                    Text(
                      "Sort By",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          //-------------------------Body Part------------------
          property.isEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  alignment: Alignment.center,
                  child: Text(
                    "All the Properties are Sold!!!",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) => PropertyGridItem(
                      category: property[index].category,
                      id: property[index].id,
                      imageURL: property[index].images[0],
                      price: property[index].price,
                      location: property[index].location,
                    ),
                    itemCount: property.length,
                  )),
        ],
      ),
    );
  }
}

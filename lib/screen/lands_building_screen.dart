import 'package:bellasareas/model/property.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/widgets/property_grid_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    List<Property> property;
    category == "Lands"
        ? property = Provider.of<PropertyProvider>(context).landProperties
        : property = Provider.of<PropertyProvider>(context).buildingProperties;
    return Scaffold(
      body: Stack(
        children: <Widget>[DrawerScreen(), LandBuildingScreen(property)],
      ),
    );
  }
}

class LandBuildingScreen extends StatefulWidget {
  final property;
  LandBuildingScreen(this.property);
  @override
  _LandBuildingScreenState createState() => _LandBuildingScreenState(property);
}

class _LandBuildingScreenState extends State<LandBuildingScreen> {
  final property;
  _LandBuildingScreenState(this.property);
  double xOffSet = 0;
  double yOffSet = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: MediaQuery.of(context).size.height,
      transform: Matrix4.translationValues(xOffSet, yOffSet, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          //Custom App Bar
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                isDrawerOpen
                    ? IconButton(
                        icon: Icon(Icons.arrow_back_ios),
                        onPressed: () {
                          setState(() {
                            xOffSet = 0;
                            yOffSet = 0;
                            isDrawerOpen = false;
                            scaleFactor = 1;
                          });
                        },
                      )
                    : IconButton(
                        icon: Icon(Icons.menu),
                        onPressed: () {
                          setState(() {
                            xOffSet = 200;
                            yOffSet = 130;
                            scaleFactor = 0.6;
                            isDrawerOpen = true;
                          });
                        },
                      ),
                Text(
                  "Bellas Areas",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  icon: Icon(Icons.save),
                  onPressed: () {},
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //Body Part
          property.isEmpty
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.85,
                  alignment: Alignment.center,
                  child: Text(
                    "All the Properties are Sold!!!",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : Container(
                  height: MediaQuery.of(context).size.height * 0.87,
                  child: ListView.builder(
                    itemBuilder: (ctx, index) => PropertyGridItem(
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

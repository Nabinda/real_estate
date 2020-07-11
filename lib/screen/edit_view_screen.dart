import 'package:bellasareas/model/property.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/screen/edit_add_property_screen.dart';
import 'package:bellasareas/screen/wishlist_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditViewScreenHomePage extends StatefulWidget {
  static const routeName = "/edit_screen";
  @override
  _EditViewScreenHomePageState createState() => _EditViewScreenHomePageState();
}

class _EditViewScreenHomePageState extends State<EditViewScreenHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[DrawerScreen(), EditViewScreen()],
      ),
    );
  }
}

class EditViewScreen extends StatefulWidget {
  @override
  _EditViewScreenState createState() => _EditViewScreenState();
}

class _EditViewScreenState extends State<EditViewScreen> {
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
    List<Property> property =
        Provider.of<PropertyProvider>(context, listen: false).properties;
    return AnimatedContainer(
      height: MediaQuery.of(context).size.height,
      transform: Matrix4.translationValues(xOffSet, yOffSet, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
      ),
      child: Column(children: <Widget>[
        SizedBox(height: 30),
        //Custom App Bar
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.grey[800],
                    offset: Offset(0, 5),
                    blurRadius: 10.0),
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
                "Your Property",
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
          height: 20,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.85,
          child: ListView.builder(
              itemBuilder: (ctx, index) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 5),
                  child: ListTile(
                    leading: Image.network(
                      property[index].images[0],
                      height: 90,
                      width: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      property[index].location,
                      style: TextStyle(fontSize: 14),
                    ),
                    trailing: Container(
                      width: 100,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              size: 16,
                              color: Colors.purple,
                            ),
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                  EditAddPropertyScreen.routeName,
                                  arguments: property[index].id);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.delete,
                              size: 16,
                              color: Colors.purple,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
              itemCount: property.length),
        ),
      ]),
    );
  }
}
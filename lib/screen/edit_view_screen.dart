
import 'package:bellasareas/utils/custom_theme.dart' as style;
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/screen/add_property_screen.dart';
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
  @override
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
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<PropertyProvider>(context,listen: false)
        .fetchAndSetProperty(true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: MediaQuery.of(context).size.height,
      transform: Matrix4.translationValues(xOffSet, yOffSet, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        gradient: style.CustomTheme.homeGradient,
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
      ),
      child: Column(children: <Widget>[
        SizedBox(height: 30),
        //Custom App Bar
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              boxShadow: style.CustomTheme.textFieldBoxShadow,
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
                style: style.CustomTheme.headerBlack,
              ),
              IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.purple[500],
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(EditAddPropertyScreen.routeName);
                },
              )
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        FutureBuilder(
          future: _refreshProducts(context),
          builder: (ctx, snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? Center(
              child: CircularProgressIndicator(),
            )
                : RefreshIndicator(
              onRefresh: () => _refreshProducts(context),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Consumer<PropertyProvider>(
                  builder: (ctx, property, _) {
                    return Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.8,
                      child:
                      property.properties.isEmpty?
                          Center(child: Text("Add Your Properties First !!!",style:style.CustomTheme.header,))
                          :
                      ListView.builder(
                          itemBuilder: (ctx, index) {
                            return Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: EdgeInsets.symmetric(vertical: 5),
                              child: ListTile(
                                leading: Image.network(
                                  property.properties[index].images[0],
                                  height: 90,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                                title: Text(
                                  property.properties[index].location,
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
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: Text("Are you sure?"),
                                              content: Text(
                                                  "Do you want to edit this property?"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("NO"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text("YES"),
                                                  onPressed: () {
                                                    Navigator.of(context).pushNamed(
                                                        EditAddPropertyScreen.routeName,
                                                        arguments: property.properties[index].id);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );

                                        },
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          size: 16,
                                          color: Colors.purple,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: Text("Are you sure?"),
                                              content: Text(
                                                  "Do you want to delete this property?"),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("NO"),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                ),
                                                FlatButton(
                                                  child: Text("YES"),
                                                  onPressed: () {
                                                    Provider.of<PropertyProvider>(context,
                                                        listen: false)
                                                        .removeProperty(property.properties[index].id);
                                                  },
                                                ),
                                              ],
                                            ),
                                          );

                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: property.properties.length),

                    );
                  },
                ),
              ),
            );
          },
        ),

  ]),
    );
  }
}

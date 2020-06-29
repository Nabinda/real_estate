import 'package:bellasareas/model/property.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

//------------------For App Drawer-------------------
class SearchScreenHomePage extends StatefulWidget {
  @override
  _SearchScreenHomePageState createState() => _SearchScreenHomePageState();
}

class _SearchScreenHomePageState extends State<SearchScreenHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[DrawerScreen(), SearchScreen()],
      ),
    );
  }
}

//---------------------Search Screen-----------------------
class SearchScreen extends StatefulWidget {
  static const routeName = "/search_screen";
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> categories = ["All", "Lands", "Buildings"];
  String selectedCategory = "All";
  List<String> locations = ["All", "Kathmandu", "Pokhara", "Butwal"];
  String selectedLocation = "Kathmandu";
  List<String> priceRange = [
    "All",
    "1000000-1500000",
    "1500000-2000000",
    "2000000-3000000"
  ];
  String selectedPriceRange = "All";
  double xOffSet = 0;
  double yOffSet = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  bool isSearch = false;
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
          //------------------Custom App Bar
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
                            scaleFactor = 1;
                            isDrawerOpen = false;
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
          //------------------Body Part
          Column(
            children: <Widget>[
              //-----------Search Filters--------------
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //--------------DropDown Of Category-------------
                    Container(
                      width: MediaQuery.of(context).size.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Category:",
                            style: TextStyle(fontSize: 14),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 5),
                            child: DropdownButton<String>(
                              items: categories.map((dropdownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropdownStringItem,
                                  child: Expanded(
                                    flex: 1,
                                    child: Text(
                                      dropdownStringItem,
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: selectedCategory,
                              onChanged: (value) {
                                setState(() {
                                  selectedCategory = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //--------------DropDown of Locations-------------
                    Container(
                      width: MediaQuery.of(context).size.width * 0.28,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Location:",
                            style: TextStyle(fontSize: 14),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 2),
                            child: DropdownButton<String>(
                              items: locations.map((dropdownStringItem) {
                                return DropdownMenuItem<String>(
                                  value: dropdownStringItem,
                                  child: Expanded(
                                    flex: 1,
                                    child: Text(
                                      dropdownStringItem,
                                      style: TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: selectedLocation,
                              onChanged: (value) {
                                setState(() {
                                  selectedLocation = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    //----------DropDown for PriceRange-----------------
                    Expanded(
                      flex: 1,
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.28,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Price Range:",
                              style: TextStyle(fontSize: 14),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                left: 10,
                              ),
                              child: DropdownButton<String>(
                                items: priceRange.map((dropdownStringItem) {
                                  return DropdownMenuItem<String>(
                                    value: dropdownStringItem,
                                    child: Expanded(
                                      child: Text(
                                        dropdownStringItem,
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  );
                                }).toList(),
                                value: selectedPriceRange,
                                onChanged: (value) {
                                  setState(() {
                                    selectedPriceRange = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.greenAccent,
                    borderRadius: BorderRadius.circular(15.0)),
                width: 130,
                child: ListTile(
                  title: Text(
                    "Search",
                  ),
                  trailing: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                ),
              ),
              Divider(),
              isSearch
                  ? Container()
                  : Center(
                      child: Icon(
                      Icons.search,
                      color: Colors.grey.withOpacity(0.5),
                      size: 300,
                    ))
            ],
          ),
        ],
      ),
    );
  }
}

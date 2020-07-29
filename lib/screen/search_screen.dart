import 'package:bellasareas/model/property.dart';
import 'package:bellasareas/provider/category_provider.dart';
import 'package:bellasareas/provider/district_provider.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/widgets/category_dropdown.dart';
import 'package:bellasareas/widgets/district_dropdown.dart';
import 'package:bellasareas/widgets/property_grid_item.dart';
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

  List<String> priceRange = [
    "All",
    "1000000 and above",
    "1500000 and above",
    "2000000 and above"
  ];
  String selectedPriceRange = "All";
  double xOffSet = 0;
  double yOffSet = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  bool isSearch = false;
  List<Property> filterProperty = <Property>[];
//-----------------------Search Result Generator-----------------
  void addToFilterProperty(BuildContext context) {
    final provider = Provider.of<PropertyProvider>(context, listen: false);
    List<Property> property =
        Provider.of<PropertyProvider>(context, listen: false).properties;
    String selectedLocation =
        Provider.of<DistrictProvider>(context, listen: false).selectedDistrict;
    String selectedCategory =
        Provider.of<CategoryProvider>(context, listen: false).selectedCategory;
    setState(() {
      isSearch = true;
    });
    filterProperty.clear();
    property.forEach((property) {
      if (property.category.toLowerCase() == selectedCategory.toLowerCase() &&
          property.location.toLowerCase() == selectedLocation.toLowerCase()) {
        filterProperty.add(provider.findById(property.id));
      }
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
          //------------------Custom App Bar
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
                Container()
              ],
            ),
          ),
          //------------------Body Part-------------------
          Column(
            children: <Widget>[
              SizedBox(
                height: 40,
              ),
              //-----------Search Filters--------------
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    //--------------DropDown Of Category-------------
                    Row(
                      children: <Widget>[
                        Text(
                          "Category:",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        CategoryDropDown(),
                      ],
                    ),
                    //--------------DropDown of Locations-------------
                    Row(
                      children: <Widget>[
                        Text(
                          "Location:",
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        DistrictDropDown(),
                      ],
                    ),
                    //----------DropDown for PriceRange-----------------
//                    Row(
//                      children: <Widget>[
//                        Text(
//                          "Price Range:",
//                          style: TextStyle(fontSize: 14, color: Colors.white),
//                        ),
//                        SizedBox(
//                          width: 5,
//                        ),
//                        Container(
//                          padding: EdgeInsets.only(
//                            left: 10,
//                          ),
//                          child: DropdownButton<String>(
//                            dropdownColor: Colors.blueGrey,
//                            items: priceRange.map((dropdownStringItem) {
//                              return DropdownMenuItem<String>(
//                                value: dropdownStringItem,
//                                child: Text(
//                                  dropdownStringItem,
//                                  style: TextStyle(
//                                      fontSize: 14, color: Colors.white),
//                                ),
//                              );
//                            }).toList(),
//                            value: selectedPriceRange,
//                            onChanged: (value) {
//                              setState(() {
//                                selectedPriceRange = value;
//                              });
//                            },
//                          ),
//                        ),
//                      ],
//                    ),
                  ],
                ),
              ),
              //-------------Search Button------------------
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0, 1),
                        blurRadius: 2),
                  ],
                  gradient: LinearGradient(colors: [
                    Colors.purple[900],
                    Colors.purple[600],
                    Colors.purple[300],
                  ]),
                  borderRadius: BorderRadius.circular(15),
                ),
                width: 130,
                child: ListTile(
                  onTap: () {
                    addToFilterProperty(context);
                  },
                  title: Text(
                    "Search",
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                ),
              ),
              Divider(),
              //----------Search Results here-------------------
              isSearch
                  ? filterProperty.isEmpty
                      ? Center(
                          child: Text(
                            "NO RESULT FOUND!!!",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : Container(
                          height: MediaQuery.of(context).size.height * 0.55,
                          child: ListView.builder(
                            itemBuilder: (ctx, index) => PropertyGridItem(
                              category: filterProperty[index].category,
                              location: filterProperty[index].location,
                              price: filterProperty[index].price,
                              imageURL: filterProperty[index].images[0],
                              id: filterProperty[index].id,
                            ),
                            itemCount: filterProperty.length,
                          ))
                  : Center(
                      child: Icon(
                      Icons.search,
                      color: Colors.white.withOpacity(0.4),
                      size: 300,
                    ))
            ],
          ),
        ],
      ),
    );
  }
}

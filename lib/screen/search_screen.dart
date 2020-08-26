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
import 'package:bellasareas/utils/custom_theme.dart' as style;
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
        gradient: style.CustomTheme.homeGradient,
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
      ),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30),
          //------------------Custom App Bar
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
                  "Bellas Areas",
                  style: style.CustomTheme.headerBlack,
                ),
                Container()
              ],
            ),
          ),
          //------------------Body Part-------------------
          Column(
            children: <Widget>[
              SizedBox(
                height: 10,
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
                          style: style.CustomTheme.kTextStyle,
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
                          style: style.CustomTheme.kTextStyle,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        DistrictDropDown(),
                      ],
                    ),
                  ],
                ),
              ),
              //-------------Search Button------------------
              Container(
                decoration: style.CustomTheme.buttonDecoration,
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
              //----------Search Results here-------------------
              isSearch
                  ? filterProperty.isEmpty
                      ? Container(
                height: MediaQuery.of(context).size.height * 0.55,
                        child: Center(
                            child: Text(
                              "NO RESULT FOUND!!!",
                              style: style.CustomTheme.header,
                            ),
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

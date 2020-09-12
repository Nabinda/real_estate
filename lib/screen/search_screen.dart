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
  List<String> priceRange = [
    "All",
    "1000000 and above",
    "1500000 and above",
    "2000000 and above"
  ];
  String selectedPriceRange = "All";
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
    final deviceHeight =
        MediaQuery.of(context).size.height;
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(gradient: style.CustomTheme.homeGradient),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Positioned(
                left: 8,
                child: IconButton(
                  icon: Icon(Icons.arrow_back_ios,color: style.CustomTheme.iconColor,),
                  onPressed: (){
                  Navigator.pop(context);
                  },
                ),
              ),

              //------------------Body Part-------------------
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      padding: EdgeInsets.only(left: 40,top: 15),
                      height: deviceHeight*0.1,
                      child: Text(
                        "Search Property",
                        style: style.CustomTheme.headerBlackMedium,
                      )),
                  //-----------Search Filters--------------
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
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
        ),
      ),
    );
  }
}

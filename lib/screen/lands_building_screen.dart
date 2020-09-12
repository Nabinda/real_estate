import 'package:bellasareas/model/property.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/screen/search_screen.dart';
import 'package:bellasareas/widgets/property_grid_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bellasareas/utils/custom_theme.dart' as style;

enum SortOption { Highest, Lowest }

class LandBuildingScreen extends StatefulWidget {
  static const routeName = "/land_screen";

  @override
  _LandBuildingScreenState createState() => _LandBuildingScreenState();
}

class _LandBuildingScreenState extends State<LandBuildingScreen> {
  List<Property> property;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<PropertyProvider>(context, listen: false);
    final category = ModalRoute.of(context).settings.arguments;final deviceHeight =
        MediaQuery.of(context).size.height;
    category == "Lands"
        ? property =
            Provider.of<PropertyProvider>(context, listen: false).landProperties
        : property = Provider.of<PropertyProvider>(context, listen: false)
            .buildingProperties;
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(gradient: style.CustomTheme.homeGradient),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: DrawerScreen(),
          ),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Positioned(
                left: 8,
                child: IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: (){
                    DrawerScreen();
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
              ),
              Positioned(
                top: 2,
                right: 8,
                child: IconButton(
                    icon: Icon(Icons.search,size: 30,),
                    onPressed: (){
                      Navigator.of(context).pushNamed(SearchScreen.routeName);}
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.only(left: 90,top: 20),
                      height: deviceHeight*0.17,
                      child: Text(
                        "Available \n \t \t Property",
                        style: style.CustomTheme.headerBlackMedium,
                      )),
                  //-------------Sorting Part-----------
                  Container(
                    height: deviceHeight*0.05,
                    padding: EdgeInsets.only(right: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        PopupMenuButton(
                          color: style.CustomTheme.circularColor1,
                          itemBuilder: (_) => [
                            PopupMenuItem<SortOption>(
                              child: Text("By Highest",style: style.CustomTheme.kTextStyle,),
                              value: SortOption.Highest,
                            ),
                            PopupMenuItem<SortOption>(
                              child: Text("By Lowest",style: style.CustomTheme.kTextStyle,),
                              value: SortOption.Lowest,
                            ),
                          ],
                          onSelected: (SortOption sortOption) {
                            setState(() {
                              if (sortOption == SortOption.Highest) {
                                provider.highestToLowest();
                              } else {
                                provider.lowestToHighest();
                              }
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.sort,
                                color: style.CustomTheme.iconColor,
                              ),
                              Text(
                                "Sort By",
                                style: style.CustomTheme.kTextBlackStyle,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  //-------------------------Body Part------------------
                  FutureBuilder(
                    future: Provider.of<PropertyProvider>(context,listen: false).fetchAndSetProperty(false),
                    builder: (ctx,_){
                      return property.isEmpty
                          ? Container(
                        height: MediaQuery.of(context).size.height * 0.74,
                        alignment: Alignment.center,
                        child: Text(
                          "All the Properties are Sold!!!",
                          style: TextStyle(color: Colors.white,fontSize: 20),
                        ),
                      )
                          : Container(
                          height: MediaQuery.of(context).size.height * 0.74,
                          child: ListView.builder(
                            itemBuilder: (ctx, index) => PropertyGridItem(
                              category: property[index].category,
                              id: property[index].id,
                              imageURL: property[index].images[0],
                              price: property[index].price,
                              location: property[index].location,
                            ),
                            itemCount: property.length,
                          ));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

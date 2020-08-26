import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/widgets/property_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bellasareas/utils/custom_theme.dart' as style;

class WishList extends StatelessWidget {
  static const routeName = "/wishList_screen";
  @override
  Widget build(BuildContext context) {
    final property =
        Provider.of<PropertyProvider>(context, listen: false).wishList;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: style.CustomTheme.homeGradient
        ),
        height: MediaQuery.of(context).size.height,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              //----------------------Custom App Bar-----------------
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                decoration: BoxDecoration(
                    boxShadow: style.CustomTheme.textFieldBoxShadow,
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.purple[500],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    Text(
                      "WishList",
                      style:
                         style.CustomTheme.headerBlack,
                    ),
                    Container(
                      width: 50,
                    )
                  ],
                ),
              ),
              property.isEmpty
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Center(
                        child: Text(
                          "Your WishList is Empty!!!!",
                          style: style.CustomTheme.header,
                        ),
                      ),
                    )
                  : Container(
                      height: MediaQuery.of(context).size.height * 0.87,
                      child: ListView.builder(
                        itemBuilder: (ctx, index) => PropertyTileView(
                          id: property[index].id,
                          imageURL: property[index].images[0],
                          price: property[index].price,
                          location: property[index].location,
                          category: property[index].category,
                        ),
                        itemCount: property.length,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

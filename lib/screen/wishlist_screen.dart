import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/widgets/property_tile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishList extends StatelessWidget {
  static const routeName = "/wishList_screen";
  @override
  Widget build(BuildContext context) {
    final property =
        Provider.of<PropertyProvider>(context, listen: false).wishList;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: <Widget>[
              //----------------------Custom App Bar-----------------
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                          style: TextStyle(color: Colors.white, fontSize: 18),
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

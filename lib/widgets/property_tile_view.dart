import 'package:bellasareas/model/property.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/property_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropertyTileView extends StatelessWidget {
  final String id;
  final String imageURL;
  final String location;
  final double price;
  final Category category;
  PropertyTileView(
      {@required this.id,
      @required this.imageURL,
      @required this.location,
      @required this.price,
      @required this.category});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(PropertyDetailsScreen.routeName, arguments: id);
        },
        child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            child: Dismissible(
              direction: DismissDirection.endToStart,
              key: ValueKey(id),
              background: Container(
                color: Colors.red,
                child: Text(
                  "Delete",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 20),
              ),
              onDismissed: (direction) {
                Provider.of<PropertyProvider>(context, listen: false)
                    .removeWishList(id);
              },
              confirmDismiss: (direction) {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text("Are you sure?"),
                    content: Text(
                        "Do you want to remove this property from the wishlist ?"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("NO"),
                        onPressed: () {
                          Navigator.pop(context, false);
                        },
                      ),
                      FlatButton(
                        child: Text("YES"),
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Row(
                children: <Widget>[
                  Hero(
                    tag: 'property$id',
                    child: FadeInImage(
                      placeholder: AssetImage("assets/images/bellasareas.PNG"),
                      image: NetworkImage(imageURL),
                      width: 100,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        category == Category.building ? "Building" : "Land",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Location: $location",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Price:" + price.toString(),
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}

import 'package:bellasareas/model/property.dart';
import 'package:bellasareas/screen/property_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ScreenArguments {}

class PropertyGridItem extends StatelessWidget {
  final String id;
  final String imageURL;
  final String location;
  final double price;
  final Category category;
  PropertyGridItem(
      {@required this.id,
      @required this.imageURL,
      @required this.location,
      @required this.price,
      @required this.category});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .pushNamed(PropertyDetailsScreen.routeName, arguments: id);
//        Navigator.of(context).push(PageTransition(
//            type: PageTransitionType.slideInLeft,
//            child: PropertyDetailsScreen()));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 13.0, right: 10.0),
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.9,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
                child: Hero(
                  tag: 'property$id',
                  child: FadeInImage(
                    placeholder: AssetImage("assets/images/bellasareas.PNG"),
                    image: NetworkImage(imageURL),
                    width: MediaQuery.of(context).size.width * 0.46,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              height: 130,
              width: MediaQuery.of(context).size.width * 0.47,
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0))),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    category == Category.land
                        ? "Land on Sale"
                        : "Building on Sale",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.location_on),
                      SizedBox(
                        width: 5,
                      ),
                      Flexible(
                        child: Text(
                          "location,location,location",
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Rs",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(price.toString())
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
//Old Design
//Container(
//        decoration: BoxDecoration(
//            borderRadius: BorderRadius.only(
//                topRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
//            boxShadow: [
//              BoxShadow(
//                  color: Colors.grey[600],
//                  offset: Offset(4.0, 4.0),
//                  blurRadius: 5.0,
//                  spreadRadius: 1.0),
//              BoxShadow(
//                  color: Colors.white,
//                  offset: Offset(-2.0, -2.0),
//                  blurRadius: 15.0,
//                  spreadRadius: 1.0)
//            ]),
//        width: MediaQuery.of(context).size.width * 0.95,
//        margin: EdgeInsets.only(
//            left: MediaQuery.of(context).size.width * 0.025,
//            right: MediaQuery.of(context).size.width * 0.025,
//            bottom: 10),
//        child: Card(
//          shape: RoundedRectangleBorder(
//            borderRadius: BorderRadius.circular(15),
//          ),
//          child: Stack(
//            children: <Widget>[
//              ClipRRect(
//                borderRadius: BorderRadius.all(Radius.circular(15)),
//                child: Hero(
//                  tag: 'property$id',
//                  child: FadeInImage(
//                    placeholder: AssetImage("assets/images/bellasareas.PNG"),
//                    image: NetworkImage(
//                      imageURL,
//                    ),
//                    width: MediaQuery.of(context).size.width * 0.95,
//                    height: 250,
//                    fit: BoxFit.cover,
//                  ),
//                ),
//              ),
//              Positioned(
//                bottom: 0,
//                child: Container(
//                  height: 30,
//                  width: MediaQuery.of(context).size.width * 0.93,
//                  color: Colors.black.withOpacity(0.6),
//                  child: Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Container(
//                        padding: EdgeInsets.only(left: 5.0),
//                        child: Row(
//                          children: <Widget>[
//                            Icon(
//                              Icons.location_on,
//                              color: Colors.white,
//                            ),
//                            Text(
//                              location,
//                              style:
//                                  TextStyle(fontSize: 18, color: Colors.white),
//                            ),
//                          ],
//                        ),
//                      ),
//                      Text(
//                        "Price: Rs $price",
//                        style: TextStyle(fontSize: 18, color: Colors.white),
//                      )
//                    ],
//                  ),
//                ),
//              )
//            ],
//          ),
//        ),
//      )

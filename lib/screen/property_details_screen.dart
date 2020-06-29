import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/widgets/property_detail.dart';
import 'package:bellasareas/widgets/property_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PropertyDetailsScreen extends StatelessWidget {
  static const routeName = "/property_details_screen";
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final property = Provider.of<PropertyProvider>(context).findById(id);
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Hero(
                        tag: id,
                        child: PropertyImageSlider(id),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Card(
                    elevation: 5,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                    child: ListTile(
                      leading: Icon(
                        Icons.location_on,
                        size: 20,
                      ),
                      title: Text(
                        property.location,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    elevation: 5,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                    child: ListTile(
                      leading: Text(
                        "Rs",
                        style: TextStyle(fontSize: 20),
                      ),
                      title: Text(
                        property.price.toString(),
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  PropertyDetail(id),
//            =============Owner Information;
                  Card(
                    elevation: 5,
                    margin: EdgeInsets.only(
                        top: 10.0, left: 30.0, right: 30.0, bottom: 40.0),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Owner Information",
                            style: TextStyle(fontSize: 20),
                          ),
                          Divider(
                            thickness: 2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Name :",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                property.ownerName,
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Email :",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                property.ownerEmail,
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 7.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                width: 15.0,
                              ),
                              Text(
                                "Contact :",
                                style: TextStyle(fontSize: 18),
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                property.ownerContact,
                                style: TextStyle(fontSize: 18),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: RaisedButton.icon(
                    elevation: 1,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: Colors.greenAccent,
                    onPressed: () {},
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: Text(
                      "Add to WishList",
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/widgets/property_detail.dart';
import 'package:bellasareas/widgets/property_image_slider.dart';
import 'package:flutter/cupertino.dart';
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
          fit: StackFit.expand,
          overflow: Overflow.clip,
          children: <Widget>[
            SingleChildScrollView(
              child: Stack(
                children: <Widget>[
                  //--------------to give height for stack------------------------
                  Container(
                    height: MediaQuery.of(context).size.height + 250,
                  ),
                  //-----------Image Slider Section----------------------------
                  Container(
                    child: Stack(
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
                  ),
                  //------------------------Other Information--------------------
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.55,
                    left: 0,
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white,
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Card(
                                elevation: 5,
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Icon(
                                        Icons.location_on,
                                        size: 20,
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        property.location,
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                )),
                            Card(
                                elevation: 5,
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                child: Container(
                                  height: 50,
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        "Rs.",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        property.price.toString(),
                                        style: TextStyle(fontSize: 20),
                                      )
                                    ],
                                  ),
                                )),
                            PropertyDetail(id),
//            =============Owner Information;
                            Card(
                              elevation: 5,
                              margin: EdgeInsets.only(
                                  top: 10.0,
                                  left: 30.0,
                                  right: 30.0,
                                  bottom: 40.0),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.75,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
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
                    ),
                  ),
                ],
              ),
            ),
            //------------------Fixed Bottom Screen Button--------------------------
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                child: RaisedButton.icon(
                    elevation: 1,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    color: Colors.purple,
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

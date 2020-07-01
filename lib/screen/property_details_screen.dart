import 'package:bellasareas/model/property.dart';
import 'package:bellasareas/provider/property_provider.dart';
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
          fit: StackFit.expand,
          overflow: Overflow.clip,
          children: <Widget>[
            Stack(
              children: <Widget>[
                //--------------to give height for stack------------------------
                Container(
                  height: MediaQuery.of(context).size.height,
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
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.45,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: Colors.white,
                    ),
                    child: Container(
                      margin: EdgeInsets.only(
                          top: 10.0, left: 30.0, right: 30.0, bottom: 40.0),
                      padding: EdgeInsets.only(bottom: 30),
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: ListView(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                              elevation: 5,
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: Container(
                                height: 50,
                                width: MediaQuery.of(context).size.width * 0.7,
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
                                width: MediaQuery.of(context).size.width * 0.7,
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
//--------------------------Property Information-----------------
                          Card(
                            elevation: 5,
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    "Property Information",
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
                                        "Area :",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        property.area,
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
                                        "Road Access :",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        property.roadAccess.toString(),
                                        style: TextStyle(fontSize: 18),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 7.0,
                                  ),
                                  property.category == Category.building
                                      ? Column(
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                SizedBox(
                                                  width: 15.0,
                                                ),
                                                Text(
                                                  "Floors :",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  property.floors.toString(),
                                                  style:
                                                      TextStyle(fontSize: 18),
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
                                                  "Bathrooms :",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  property.bathrooms.toString(),
                                                  style:
                                                      TextStyle(fontSize: 18),
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
                                                  "Total Rooms :",
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                                SizedBox(
                                                  width: 10.0,
                                                ),
                                                Text(
                                                  property.totalRooms
                                                      .toString(),
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                )
                                              ],
                                            ),
                                          ],
                                        )
                                      : Container(),
                                ],
                              ),
                            ),
                          ),
//            =============Owner Information==================
                          Card(
                            elevation: 5,
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
                  ),
                ),
              ],
            ),
            //------------------Fixed Bottom Screen Button--------------------------
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 40,
                color: Colors.grey.withOpacity(0.5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: RaisedButton.icon(
                          color: Colors.purple,
                          elevation: 1,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
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
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: RaisedButton.icon(
                          color: Colors.purple,
                          elevation: 1,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {},
                          icon: Icon(
                            Icons.phone,
                            color: Colors.white,
                          ),
                          label: Text(
                            "Contact",
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

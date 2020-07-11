import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/widgets/property_image_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailsScreen extends StatelessWidget {
  static const routeName = "/property_details_screen";

  Future<void> _makePhoneCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _sendMail(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    void showToast(String msg, {int duration, int gravity}) {
      Toast.show(msg, context, duration: duration, gravity: gravity);
    }

    final provider = Provider.of<PropertyProvider>(context);
    final id = ModalRoute.of(context).settings.arguments;
    final property =
        Provider.of<PropertyProvider>(context, listen: false).findById(id);
    final contact = property.ownerContact;
    final email = property.ownerEmail;

    chooseOption(BuildContext context) {
      return showDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Container(
                padding: EdgeInsets.all(8.0),
                alignment: Alignment.center,
                height: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.call,
                              color: Colors.purple,
                              size: 100,
                            ),
                            Text("Phone")
                          ],
                        ),
                        onPressed: () {
                          _makePhoneCall('tel:$contact');
                          Navigator.of(context).pop();
                        }),
                    FlatButton(
                      child: Column(
                        children: <Widget>[
                          Icon(
                            Icons.email,
                            color: Colors.purple,
                            size: 100,
                          ),
                          Text("Mail")
                        ],
                      ),
                      onPressed: () {
                        _sendMail('mailto:$email');
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            );
          });
    }

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
                      PropertyImageSlider(id),
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
                      color: Colors.blueGrey,
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
                                  property.category == "Buildings"
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
                margin: EdgeInsets.only(bottom: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple[100],
                              offset: Offset(0, 10),
                              blurRadius: 10.0,
                            ),
                          ],
                          gradient: LinearGradient(colors: [
                            Colors.purple[900],
                            Colors.purple[600],
                            Colors.purple[300],
                          ]),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            provider.addWishList(id);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              Text(
                                "Add to WishList",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple[100],
                              offset: Offset(0, 10),
                              blurRadius: 10.0,
                            ),
                          ],
                          gradient: LinearGradient(colors: [
                            Colors.purple[900],
                            Colors.purple[600],
                            Colors.purple[300],
                          ]),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: FlatButton(
                          onPressed: () {
                            chooseOption(context);
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.phone,
                                color: Colors.white,
                              ),
                              Text(
                                "Contact",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                        ),
                      ),
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

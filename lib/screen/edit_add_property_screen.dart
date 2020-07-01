import 'dart:io';
import 'package:bellasareas/provider/category_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/widgets/category_dropdown.dart';
import 'package:bellasareas/widgets/district_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class EditAddPropertyScreen extends StatefulWidget {
  static const routeName = "/edit_add_property_screen";
  @override
  _EditAddPropertyScreenState createState() => _EditAddPropertyScreenState();
}

class _EditAddPropertyScreenState extends State<EditAddPropertyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[DrawerScreen(), EditAddProperty()],
      ),
    );
  }
}

class EditAddProperty extends StatefulWidget {
  @override
  _EditAddPropertyState createState() => _EditAddPropertyState();
}

class _EditAddPropertyState extends State<EditAddProperty> {
  bool isImage = false;
  List<File> images = List<File>();
  final _form = GlobalKey<FormState>();
  double xOffSet = 0;
  double yOffSet = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;

  var initValues = {
    "category": "",
    "location": "",
    "roadAccess": "",
    "images": "",
    "area": "",
    "floor": "",
    "bathroom": "",
    "price": ""
  };

  void openDrawer() {
    setState(() {
      xOffSet = 200;
      yOffSet = 130;
      scaleFactor = 0.6;
      isDrawerOpen = true;
    });
  }

  void closeDrawer() {
    setState(() {
      xOffSet = 0;
      yOffSet = 0;
      scaleFactor = 1;
      isDrawerOpen = false;
    });
  }

//-----------------to get image from storage----------
  Future getImage(bool isCamera) async {
    File image;

    if (isCamera) {
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }

    setState(() {
      images.add(image);
      images != null ? isImage = true : isImage = false;
    });
  }

//------------Delete the particular uploaded image--------------
  void clearImage(int index) {
    setState(() {
      images.removeAt(index);
    });
  }

//-----------------pick option to get image------------
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
                            Icons.photo,
                            color: Colors.purple,
                            size: 100,
                          ),
                          Text("Gallery")
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                        getImage(false);
                      }),
                  FlatButton(
                    child: Column(
                      children: <Widget>[
                        Icon(
                          Icons.camera,
                          color: Colors.purple,
                          size: 100,
                        ),
                        Text("Camera")
                      ],
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      getImage(true);
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final selectedCategory =
        Provider.of<CategoryProvider>(context).selectedCategory;
    return AnimatedContainer(
      height: MediaQuery.of(context).size.height,
      transform: Matrix4.translationValues(xOffSet, yOffSet, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 30),
            //---------------------------------Custom App Bar
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  isDrawerOpen
                      ? IconButton(
                          icon: Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            closeDrawer();
                          },
                        )
                      : IconButton(
                          icon: Icon(Icons.menu),
                          onPressed: () {
                            openDrawer();
                          },
                        ),
                  Text(
                    "Add Property",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: Icon(Icons.check),
                    onPressed: () {},
                  )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //-----------------Body Part--------------
            IgnorePointer(
              ignoring: isDrawerOpen,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Categories:",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      CategoryDropDown(),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Location:",
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      DistrictDropDown(),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Images",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      GestureDetector(
                        onTap: () {
                          chooseOption(context);
                        },
                        child: Container(
                          child: RaisedButton.icon(
                              onPressed: () {
                                chooseOption(context);
                              },
                              color: Colors.purpleAccent,
                              label: Text(
                                "Add",
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.add,
                                color: Colors.white,
                              )),
                        ),
                      ),
                    ],
                  ),
                  images.length != 0
                      ? Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width * 0.85,
                          child: Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: images.length,
                                itemBuilder: (ctx, index) => Stack(
                                      alignment: Alignment.topRight,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.all(0.0),
                                          width: 100,
                                          height: 150,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 1, color: Colors.grey),
                                          ),
                                          alignment: Alignment.center,
                                          child: Image.file(
                                            images[index],
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                        Positioned(
                                          top: -10,
                                          right: -10,
                                          child: IconButton(
                                            onPressed: () {
                                              clearImage(index);
                                            },
                                            icon: Icon(
                                              Icons.clear,
                                              color: Colors.red,
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                          ),
                        )
                      : Container(),
                  Form(
                    key: _form,
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.85,
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 18),
                            maxLines: 1,
                            decoration: InputDecoration(
                              labelText: "Area (in anna)",
                            ),
                            initialValue: initValues['area'],
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 18),
                            maxLines: 1,
                            decoration: InputDecoration(
                                labelText: "Total Price(in Rs.)"),
                            initialValue: initValues['price'],
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            style: TextStyle(fontSize: 18),
                            maxLines: 1,
                            decoration: InputDecoration(
                                labelText: "Road Access(in km)"),
                            initialValue: initValues['roadAccess'],
                          ),
                          selectedCategory == "Lands"
                              ? Container()
                              : Column(
                                  children: <Widget>[
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(fontSize: 18),
                                      maxLines: 1,
                                      decoration:
                                          InputDecoration(labelText: "Floors"),
                                      initialValue: initValues['floor'],
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(fontSize: 18),
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                          labelText: "Bathrooms"),
                                      initialValue: initValues['bathroom'],
                                    ),
                                    TextFormField(
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(fontSize: 18),
                                      maxLines: 1,
                                      decoration: InputDecoration(
                                          labelText: "Total Rooms"),
                                      initialValue: initValues['bathroom'],
                                    ),
                                  ],
                                ),
                        ],
                      ),
                    ),
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

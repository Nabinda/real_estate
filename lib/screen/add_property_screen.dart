import 'dart:convert';
import 'dart:io';
import 'package:bellasareas/model/property.dart';
import 'package:bellasareas/provider/category_provider.dart';
import 'package:bellasareas/provider/district_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:bellasareas/screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/utils/custom_theme.dart' as style;
import 'package:bellasareas/widgets/category_dropdown.dart';
import 'package:bellasareas/widgets/district_dropdown.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditAddPropertyScreen extends StatefulWidget {
  static const routeName = "/edit_add_property_screen";
  @override
  _EditAddPropertyScreenState createState() => _EditAddPropertyScreenState();
}

class _EditAddPropertyScreenState extends State<EditAddPropertyScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
      getUserData();
      final id = ModalRoute.of(context).settings.arguments;
      if (id != null) {
        _editedProperty =
            Provider.of<PropertyProvider>(context, listen: false).findById(id);
        initValues = {
          "category": _editedProperty.category,
          "location": _editedProperty.location,
          "roadAccess": _editedProperty.roadAccess.toString(),
          "images": "",
          "area": _editedProperty.area,
          "floor": _editedProperty.floors.toString(),
          "bathroom": _editedProperty.bathrooms.toString(),
          "price": _editedProperty.price.toString(),
          "totalRooms": _editedProperty.totalRooms.toString(),
        };

        Provider.of<CategoryProvider>(context, listen: false).updateSelected =
            initValues["category"];
        Provider.of<DistrictProvider>(context, listen: false).updateSelected =
            initValues["location"];
      }
    }
    isInit = false;
  }

  void getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final extractedData =
        json.decode(prefs.getString("userData")) as Map<String, Object>;
    setState(() {
      email = extractedData['email'];
      name = extractedData['name'];
      contact = extractedData['contact'];
    });
  }

  bool isInit = true;
  String email;
  String name;
  String contact;
  bool isImage = false;
  List<PickedFile> images = List<PickedFile>();
  final _form = GlobalKey<FormState>();
  bool isLoading = false;

  Map<String, dynamic> initValues = {
    "category": "Lands",
    "location": "Kathmandu",
    "roadAccess": "",
    "images": "",
    "area": "",
    "floor": "",
    "bathroom": "",
    "price": "",
    "totalRooms": "",
  };
  var _editedProperty = Property(
      id: null,
      roadAccess: 0,
      area: "",
      ownerName: "",
      ownerEmail: "",
      ownerContact: "",
      category: "",
      price: 0,
      location: "",
      images: [],
      totalRooms: "",
      floors: "",
      bathrooms: "");

//-----------------to get image from mobile storage----------
  Future<void> getImage(bool isCamera) async {
    PickedFile image;
    final _imagePicker = ImagePicker();
    if (isCamera) {
      image = await _imagePicker.getImage(
          source: ImageSource.camera, imageQuality: 50);
    } else {
      image = await _imagePicker.getImage(
          source: ImageSource.gallery, imageQuality: 50);
    }

    setState(() {
      if (image != null) {
        images.add(image);
      }
      images.length != 0 ? isImage = true : isImage = false;
    });
  }

//------------Delete the particular uploaded image--------------
  void clearImage(int index) {
    setState(() {
      images.removeAt(index);
      images.length != 0 ? isImage = true : isImage = false;
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

  //-------Save form------------------
  Future<void> _saveForm() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }

    _form.currentState.save();
    setState(() {
      isLoading = true;
    });
    if (_editedProperty.id != null) {
      try {
        await Provider.of<PropertyProvider>(context, listen: false)
            .updateProperty(_editedProperty.id, _editedProperty, images);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Error Occurred"),
                  content: Text(
                      "Something has occurred! Property couldn't be updated"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ));
      }
    } else {
      try {
        await Provider.of<PropertyProvider>(context, listen: false)
            .addProperty(context, _editedProperty, images);
      } catch (error) {
        await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text("Error Occurred"),
                  content: Text(
                      "Something has occurred! Property couldn't be added"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("OK"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ));
      }
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context).selectedCategory;
    final selectedLocation =
        Provider.of<DistrictProvider>(context).selectedDistrict;
    final deviceHeight =
        MediaQuery.of(context).size.height;
    return Container(
      height: deviceHeight,
      decoration: BoxDecoration(gradient: style.CustomTheme.homeGradient),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: DrawerScreen(),
          ),
          backgroundColor: Colors.transparent,
          body: isLoading
              ? Container(
                  width: double.infinity,
                  height: deviceHeight * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircularProgressIndicator(
                        backgroundColor: style.CustomTheme.circularColor1,
                        valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white.withOpacity(0.4)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Adding...",
                        style: style.CustomTheme.header,
                      )
                    ],
                  ))
              : SingleChildScrollView(
                  child: Stack(
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
                        top: 8,
                        right: 8,
                        child: GestureDetector(
                          onTap: _saveForm,
                          child: Icon(Icons.check,size: 30,),
                        ),
                      ),
                      Column(
                        children: <Widget>[
                          Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.only(left: 90,top: 20),
                              child: Text(
                                "Add Your \n \t Property",
                                style: style.CustomTheme.headerBlackMedium,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Categories:",
                                style: style.CustomTheme.kTextStyle,
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
                                style: style.CustomTheme.kTextStyle,
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
                          //----------------Image Adding-----------------------------
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "Images",
                                style: style.CustomTheme.kTextStyle,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Container(
                                width: 130,
                                decoration: style.CustomTheme.buttonDecoration,
                                child: ListTile(
                                  onTap: () {
                                    chooseOption(context);
                                  },
                                  title: Text(
                                    "Add",
                                    style: style.CustomTheme.kTextStyle,
                                  ),
                                  leading: Icon(
                                    Icons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          isImage
                              ? Container(
                                  margin: EdgeInsets.only(top: 8.0),
                                  height: 150,
                                  width: MediaQuery.of(context).size.width * 0.82,
                                  child: Expanded(
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: images.length,
                                        itemBuilder: (ctx, index) => Stack(
                                              alignment: Alignment.topRight,
                                              children: <Widget>[
                                                Container(
                                                  padding: EdgeInsets.all(0.0),
                                                  width: 150,
                                                  height: 150,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 1, color: Colors.grey),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Image.file(
                                                    File(images[index].path),
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
                                                      color: Colors.purpleAccent,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )),
                                  ),
                                )
                              : Container(
                                  height: 0,
                                  width: 0,
                                ),
                          //----------------------Form of other Information-------------------
                          Container(
                            width: MediaQuery.of(context).size.width * 0.85,
                            padding: EdgeInsets.symmetric(vertical: 10.0),
                            child: Form(
                              key: _form,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(
                                    height: 10,
                                  ),
                                  TextFormField(
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                    style: style.CustomTheme.kTextStyle,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white)),
                                        labelText: "Area (in anna)",
                                        labelStyle: style.CustomTheme.kTextStyle),
                                    initialValue: initValues['area'],
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Should not be empty";
                                      }
                                      if (double.tryParse(value) == null) {
                                        return "Value must be in numeric term";
                                      }
                                      if (double.parse(value) <= 0) {
                                        return "Value should not be less than zero";
                                      }
                                      return null;
                                    },
                                    onSaved: (userInput) {
                                      _editedProperty = Property(
                                          id: _editedProperty.id,
                                          roadAccess: _editedProperty.roadAccess,
                                          area: userInput,
                                          category: category,
                                          price: _editedProperty.price,
                                          location: selectedLocation,
                                          images: _editedProperty.images,
                                          totalRooms: _editedProperty.totalRooms,
                                          floors: _editedProperty.floors,
                                          bathrooms: _editedProperty.bathrooms);
                                    },
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  TextFormField(
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                    style: style.CustomTheme.kTextStyle,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white)),
                                        labelText: "Total Price (in Rs)",
                                        labelStyle: style.CustomTheme.kTextStyle),
                                    initialValue: initValues['price'],
                                    onSaved: (value) {
                                      _editedProperty = Property(
                                          area: _editedProperty.area,
                                          images: _editedProperty.images,
                                          location: _editedProperty.location,
                                          price: double.parse(value),
                                          category: _editedProperty.category,
                                          roadAccess: _editedProperty.roadAccess,
                                          id: _editedProperty.id);
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Should not be empty";
                                      }
                                      if (double.tryParse(value) == null) {
                                        return "Value must be in numeric term";
                                      }
                                      if (double.parse(value) <= 0) {
                                        return "Value should not be less than zero";
                                      }
                                      return null;
                                    },
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),
                                  TextFormField(
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return "Should not be empty";
                                      }
                                      if (double.tryParse(value) == null) {
                                        return "Value must be in numeric term";
                                      }
                                      if (double.parse(value) <= 0) {
                                        return "Value should not be less than zero";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      _editedProperty = Property(
                                        area: _editedProperty.area,
                                        images: _editedProperty.images,
                                        location: _editedProperty.location,
                                        price: _editedProperty.price,
                                        category: _editedProperty.category,
                                        roadAccess: double.parse(value),
                                        id: _editedProperty.id,
                                        ownerName: name,
                                        ownerEmail: email,
                                        ownerContact: contact,
                                      );
                                    },
                                    cursorColor: Colors.white,
                                    keyboardType: TextInputType.number,
                                    style: style.CustomTheme.kTextStyle,
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(color: Colors.white)),
                                        labelText: "Road Access(in km)",
                                        labelStyle: style.CustomTheme.kTextStyle),
                                    initialValue: initValues['roadAccess'],
                                  ),
                                  SizedBox(
                                    height: 7,
                                  ),

                                  //------------------------Further form for gathering building information-------------------
                                  category == "Lands"
                                      ? Container()
                                      : Column(
                                          children: <Widget>[
                                            TextFormField(
                                              onSaved: (value) {
                                                _editedProperty = Property(
                                                    area: _editedProperty.area,
                                                    images: _editedProperty.images,
                                                    location: _editedProperty.location,
                                                    price: _editedProperty.price,
                                                    category: _editedProperty.category,
                                                    roadAccess:
                                                        _editedProperty.roadAccess,
                                                    id: _editedProperty.id,
                                                    floors: value);
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Should not be empty";
                                                }
                                                if (double.tryParse(value) == null) {
                                                  return "Value must be in numeric term";
                                                }
                                                if (double.parse(value) <= 0) {
                                                  return "Value should not be less than zero";
                                                }
                                                return null;
                                              },
                                              cursorColor: Colors.white,
                                              keyboardType: TextInputType.number,
                                              style: style.CustomTheme.kTextStyle,
                                              maxLines: 1,
                                              decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white)),
                                                  labelText: "Floors",
                                                  labelStyle:
                                                      style.CustomTheme.kTextStyle),
                                              initialValue: initValues['floor'],
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            TextFormField(
                                              onSaved: (value) {
                                                _editedProperty = Property(
                                                    area: _editedProperty.area,
                                                    images: _editedProperty.images,
                                                    location: _editedProperty.location,
                                                    price: _editedProperty.price,
                                                    floors: _editedProperty.floors,
                                                    category: _editedProperty.category,
                                                    roadAccess:
                                                        _editedProperty.roadAccess,
                                                    id: _editedProperty.id,
                                                    bathrooms: value);
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Should not be empty";
                                                }
                                                if (double.tryParse(value) == null) {
                                                  return "Value must be in numeric term";
                                                }
                                                if (double.parse(value) <= 0) {
                                                  return "Value should not be less than zero";
                                                }
                                                return null;
                                              },
                                              cursorColor: Colors.white,
                                              keyboardType: TextInputType.number,
                                              style: style.CustomTheme.kTextStyle,
                                              maxLines: 1,
                                              decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white)),
                                                  labelText: "Bathrooms",
                                                  labelStyle:
                                                      style.CustomTheme.kTextStyle),
                                              initialValue: initValues['bathroom'],
                                            ),
                                            SizedBox(
                                              height: 7,
                                            ),
                                            TextFormField(
                                              onSaved: (value) {
                                                _editedProperty = Property(
                                                    area: _editedProperty.area,
                                                    images: _editedProperty.images,
                                                    location: _editedProperty.location,
                                                    price: _editedProperty.price,
                                                    category: _editedProperty.category,
                                                    roadAccess:
                                                        _editedProperty.roadAccess,
                                                    floors: _editedProperty.floors,
                                                    bathrooms: _editedProperty.bathrooms,
                                                    id: _editedProperty.id,
                                                    ownerName: name,
                                                    ownerEmail: email,
                                                    ownerContact: contact,
                                                    totalRooms: value);
                                              },
                                              validator: (value) {
                                                if (value.isEmpty) {
                                                  return "Should not be empty";
                                                }
                                                if (double.tryParse(value) == null) {
                                                  return "Value must be in numeric term";
                                                }
                                                if (double.parse(value) <= 0) {
                                                  return "Value should not be less than zero";
                                                }
                                                return null;
                                              },
                                              cursorColor: Colors.white,
                                              keyboardType: TextInputType.number,
                                              style: style.CustomTheme.kTextStyle,
                                              maxLines: 1,
                                              decoration: InputDecoration(
                                                  focusedBorder: OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.white)),
                                                  labelText: "Total Rooms",
                                                  labelStyle:
                                                      style.CustomTheme.kTextStyle),
                                              initialValue: initValues['totalRooms'],
                                            ),
                                          ],
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}

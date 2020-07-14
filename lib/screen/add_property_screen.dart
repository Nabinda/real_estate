import 'dart:io';
import 'package:bellasareas/model/property.dart';
import 'package:bellasareas/provider/category_provider.dart';
import 'package:bellasareas/provider/district_provider.dart';
import 'package:bellasareas/screen/drawer_screen.dart';
import 'package:flutter/material.dart';
import 'package:bellasareas/provider/property_provider.dart';
import 'package:bellasareas/screen/overview_screen.dart';
import 'package:bellasareas/widgets/category_dropdown.dart';
import 'package:bellasareas/widgets/district_dropdown.dart';
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
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isInit) {
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

  bool isInit = true;

  bool isImage = false;
  List<File> images = List<File>();
  final _form = GlobalKey<FormState>();
  double xOffSet = 0;
  double yOffSet = 0;
  double scaleFactor = 1;
  bool isDrawerOpen = false;
  bool isLoading = false;

  var initValues = {
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
      totalRooms: 0,
      floors: 0,
      bathrooms: 0);

//-----------------to get image from mobile storage----------
  Future getImage(bool isCamera) async {
    File image;

    if (isCamera) {
      image = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 50);
    } else {
      image = await ImagePicker.pickImage(
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
            .updateProperty(_editedProperty.id, _editedProperty);
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
    Navigator.of(context).pushNamed(OverViewScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final category = Provider.of<CategoryProvider>(context).selectedCategory;
    final selectedLocation =
        Provider.of<DistrictProvider>(context).selectedDistrict;
    return AnimatedContainer(
      height: MediaQuery.of(context).size.height,
      transform: Matrix4.translationValues(xOffSet, yOffSet, 0)
        ..scale(scaleFactor),
      duration: Duration(milliseconds: 500),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
      ),
      child: isLoading
          ? Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.9,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(
                    backgroundColor: Colors.red,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Adding...",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ))
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30),
                  //---------------------------------Custom App Bar-------------------
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10),
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
                        _editedProperty.id != null
                            ? IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.purple[500],
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              )
                            : isDrawerOpen
                                ? IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Colors.purple[500],
                                    ),
                                    onPressed: () {
                                      closeDrawer();
                                    },
                                  )
                                : IconButton(
                                    icon: Icon(
                                      Icons.menu,
                                      color: Colors.purple[500],
                                    ),
                                    onPressed: () {
                                      openDrawer();
                                    },
                                  ),
                        Text(
                          "Bellas Areas",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.check,
                            color: Colors.purple[500],
                          ),
                          onPressed: () {
                            if (images.isEmpty) {
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                        title: Text("Add Image"),
                                        content:
                                            Text("You need add Image first"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("OK"),
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                          )
                                        ],
                                      ));
                            } else {
                              _saveForm();
                            }
                          },
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Container(
                              width: 130,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0, 1),
                                      blurRadius: 2),
                                ],
                                gradient: LinearGradient(colors: [
                                  Colors.purple[900],
                                  Colors.purple[600],
                                  Colors.purple[300],
                                ]),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                onTap: () {
                                  chooseOption(context);
                                },
                                title: Text(
                                  "Add",
                                  style: TextStyle(color: Colors.white),
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
                                color: Colors.blueGrey,
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
                                                      width: 1,
                                                      color: Colors.grey),
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
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      labelText: "Area (in anna)",
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
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
                                        ownerName: _editedProperty.ownerName,
                                        ownerEmail: _editedProperty.ownerEmail,
                                        ownerContact:
                                            _editedProperty.ownerContact,
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
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      labelText: "Total Price (in Rs)",
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
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
                                        id: _editedProperty.id);
                                  },
                                  cursorColor: Colors.white,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                  maxLines: 1,
                                  decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.white)),
                                      labelText: "Road Access(in km)",
                                      labelStyle:
                                          TextStyle(color: Colors.white)),
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
                                                  images:
                                                      _editedProperty.images,
                                                  location:
                                                      _editedProperty.location,
                                                  price: _editedProperty.price,
                                                  category:
                                                      _editedProperty.category,
                                                  roadAccess: _editedProperty
                                                      .roadAccess,
                                                  id: _editedProperty.id,
                                                  floors: int.parse(value));
                                            },
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Should not be empty";
                                              }
                                              if (double.tryParse(value) ==
                                                  null) {
                                                return "Value must be in numeric term";
                                              }
                                              if (double.parse(value) <= 0) {
                                                return "Value should not be less than zero";
                                              }
                                              return null;
                                            },
                                            cursorColor: Colors.white,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                labelText: "Floors",
                                                labelStyle: TextStyle(
                                                    color: Colors.white)),
                                            initialValue: initValues['floor'],
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          TextFormField(
                                            onSaved: (value) {
                                              _editedProperty = Property(
                                                  area: _editedProperty.area,
                                                  images:
                                                      _editedProperty.images,
                                                  location:
                                                      _editedProperty.location,
                                                  price: _editedProperty.price,
                                                  category:
                                                      _editedProperty.category,
                                                  roadAccess: _editedProperty
                                                      .roadAccess,
                                                  id: _editedProperty.id,
                                                  bathrooms: int.parse(value));
                                            },
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Should not be empty";
                                              }
                                              if (double.tryParse(value) ==
                                                  null) {
                                                return "Value must be in numeric term";
                                              }
                                              if (double.parse(value) <= 0) {
                                                return "Value should not be less than zero";
                                              }
                                              return null;
                                            },
                                            cursorColor: Colors.white,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                labelText: "Bathrooms",
                                                labelStyle: TextStyle(
                                                    color: Colors.white)),
                                            initialValue:
                                                initValues['bathroom'],
                                          ),
                                          SizedBox(
                                            height: 7,
                                          ),
                                          TextFormField(
                                            onSaved: (value) {
                                              _editedProperty = Property(
                                                  area: _editedProperty.area,
                                                  images:
                                                      _editedProperty.images,
                                                  location:
                                                      _editedProperty.location,
                                                  price: _editedProperty.price,
                                                  category:
                                                      _editedProperty.category,
                                                  roadAccess: _editedProperty
                                                      .roadAccess,
                                                  id: _editedProperty.id,
                                                  totalRooms: int.parse(value));
                                            },
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return "Should not be empty";
                                              }
                                              if (double.tryParse(value) ==
                                                  null) {
                                                return "Value must be in numeric term";
                                              }
                                              if (double.parse(value) <= 0) {
                                                return "Value should not be less than zero";
                                              }
                                              return null;
                                            },
                                            cursorColor: Colors.white,
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white),
                                            maxLines: 1,
                                            decoration: InputDecoration(
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color:
                                                                Colors.white)),
                                                labelText: "Total Rooms",
                                                labelStyle: TextStyle(
                                                    color: Colors.white)),
                                            initialValue:
                                                initValues['totalRooms'],
                                          ),
                                        ],
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

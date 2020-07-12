import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:bellasareas/model/property.dart';
import 'package:flutter/material.dart';

class PropertyProvider extends ChangeNotifier {
  List<Property> _property = [
    Property(
      id: "1",
      location: "Kathmandu",
      area: "0-0-4-0",
      roadAccess: 0.2,
      bathrooms: 4,
      floors: 3,
      totalRooms: 20,
      price: 2000000,
      category: "Buildings",
      images: [
        "https://www.buildingplanner.in/images/ready-plans/34N1002.jpg",
        "https://i.pinimg.com/originals/15/80/00/158000569778be8206e39ee8af249028.jpg",
        "https://sbdnepal.com/wp-content/uploads/2019/01/Building-Design-Innovative-and-Functional.jpg"
      ],
      ownerContact: "9800223355",
      ownerEmail: "abc@def.com",
      ownerName: "ABC",
    ),
    Property(
      id: "2",
      location: "Kaski",
      area: "0-0-4-0",
      roadAccess: 0.2,
      bathrooms: 4,
      floors: 3,
      totalRooms: 20,
      price: 200000,
      category: "Buildings",
      images: [
        "https://www.buildingplanner.in/images/ready-plans/34N1002.jpg",
        "https://i.pinimg.com/originals/15/80/00/158000569778be8206e39ee8af249028.jpg",
        "https://sbdnepal.com/wp-content/uploads/2019/01/Building-Design-Innovative-and-Functional.jpg"
      ],
      ownerContact: "9800223355",
      ownerEmail: "abc@def.com",
      ownerName: "ABC",
    ),
    Property(
      id: "3",
      location: "Lalitpur",
      price: 20000,
      category: "Buildings",
      images: [
        "https://www.buildingplanner.in/images/ready-plans/34N1002.jpg",
        "https://i.pinimg.com/originals/15/80/00/158000569778be8206e39ee8af249028.jpg",
        "https://sbdnepal.com/wp-content/uploads/2019/01/Building-Design-Innovative-and-Functional.jpg"
      ],
      ownerContact: "9800223355",
      ownerEmail: "abc@def.com",
      ownerName: "ABC",
      area: "0-0-4-0",
      roadAccess: 0.2,
      bathrooms: 4,
      floors: 3,
      totalRooms: 20,
    ),
    Property(
      id: "4",
      ownerName: "XYZ",
      ownerEmail: "XYZ@xyz.com",
      ownerContact: "98203652133",
      category: "Lands",
      price: 88888,
      location: "Kathmandu",
      images: [
        "https://www.tni.org/files/styles/content_full_width/public/mspp.jpeg?itok=iWMByTJ3",
        "https://upload.wikimedia.org/wikipedia/commons/c/c4/Pennsylvania_State_Game_Lands_Number_226_sign.JPG",
        "https://lh3.googleusercontent.com/proxy/QB-rj-wbg6tNrpVyvUTbrC0EzlboAm1Q3w3AI3lKmSNuawuHQ2aeEDE1MqjK51flE8UlF98QkEQ6pRMaZ40JCgZNnPYm9F9DoGtrc4Y5o9M8efdXrpuXnIuu1Py5lctnAFzVcEo"
      ],
      area: "0-0-4-0",
      roadAccess: 0.2,
    )
  ];
  List<Property> _wishList = [
    Property(
      id: "1",
      location: "Kathmandu",
      area: "0-0-4-0",
      roadAccess: 0.2,
      bathrooms: 4,
      floors: 3,
      totalRooms: 20,
      price: 2000000,
      category: "Buildings",
      images: [
        "https://www.buildingplanner.in/images/ready-plans/34N1002.jpg",
        "https://i.pinimg.com/originals/15/80/00/158000569778be8206e39ee8af249028.jpg",
        "https://sbdnepal.com/wp-content/uploads/2019/01/Building-Design-Innovative-and-Functional.jpg"
      ],
      ownerContact: "9800223355",
      ownerEmail: "abc@def.com",
      ownerName: "ABC",
    ),
  ];
  List<Property> get wishList {
    return [..._wishList];
  }

  void addWishList(String id) {
    print("from addwishlist : " + "$id");
    print(_wishList);
    bool _value = false;
    _wishList.forEach((element) {
      if (element.id == id) {
        print("alreay exist");
        _value = true;
      }
    });
    if (!_value) {
      _wishList.add(findById(id));
      notifyListeners();
      print("new value added to list");
      print(_wishList);
    }
  }

  void removeWishList(id) {
    _wishList.removeWhere((property) => property.id == id);
    notifyListeners();
  }

  List<Property> get properties {
    return [..._property];
  }

  Property findById(String id) {
    return _property.firstWhere((property) => property.id == id);
  }

  List<String> getImageURL(String id) {
    return _property.firstWhere((property) => property.id == id).images;
  }

  void highestToLowest() {
    _property.sort((b, a) => a.price.compareTo(b.price));
  }

  void lowestToHighest() {
    _property.sort((b, a) => b.price.compareTo(a.price));
  }

  List<Property> get landProperties {
    return [..._property.where((property) => property.category == "Lands")];
  }

  List<Property> get buildingProperties {
    return [..._property.where((property) => property.category == "Buildings")];
  }

  void addProperty(Property property) {
    final newProperty = Property(
        id: DateTime.now().toString(),
        images: [],
        location: property.location,
        price: property.price,
        bathrooms: property.bathrooms,
        floors: property.floors,
        totalRooms: property.totalRooms);
    _property.add(newProperty);
    notifyListeners();
  }

  void updateProperty(String id, Property property) {
    final propertyIndex = _property.indexWhere((property) => property.id == id);
    if (propertyIndex >= 0) {
      _property[propertyIndex] = property;
      notifyListeners();
    }
  }

  Future uploadPhoto(BuildContext context, List<File> images) async {
    String uploadFileUrl = "gs://bellasareas.appspot.com";

    List<String> fileName;
    for (int i = 0; i != images.length; i++) {
      fileName.add('property/${basename(images[i].path)}');
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName[0]);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(images[0]);
      await uploadTask.onComplete;
    }
  }

  List<Property> search(String category, String location) {
    return [
      ..._property
//      ..._property.where((property) =>
//          property.category == category && property.location == location.trim())
    ];
  }
}

import 'dart:convert';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:bellasareas/model/property.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PropertyProvider extends ChangeNotifier {
   final String authToken;
   final String userId;
  List<Property> _property = [];
  PropertyProvider(this.authToken,this.userId,this._property);
  String propertyId;
  List<Property> _wishList = [];
  List<Property> get properties {
    return [..._property];
  }

  List<Property> get wishList {
    return [..._wishList];
  }

  Property findById(String id) {
    return _property.firstWhere((property) => property.id == id);
  }

  List<String> getImageURL(String id) {
    return _property.firstWhere((property) => property.id == id).images;
  }

  List<Property> get landProperties {
    return [..._property.where((property) => property.category == "Lands")];
  }

  List<Property> get buildingProperties {
    return [..._property.where((property) => property.category == "Buildings")];
  }

//---------------------Add to WishList-------------------
  void addWishList(String id) {
    bool _value = false;
    _wishList.forEach((element) {
      if (element.id == id) {
        _value = true;
        throw HttpException("Already added to WishList");
      }
    });
    if (!_value) {
 _wishList.add(findById(id));
        notifyListeners();

    }
  }

//----------------Remove from WishList-------------
  void removeWishList(String id) {
  _wishList.removeWhere((property) => property.id == id);
    notifyListeners();
  }

//-----------Remove Property------------------
  Future<void> removeProperty(String id) async {
    final url = "https://bellasareas.firebaseio.com/properties/$id.json?auth=$authToken";
    final existingPropertyIndex =
        properties.indexWhere((property) => property.id == id);
    var existingProperty = _property[existingPropertyIndex];
    _property.removeWhere((property) => property.id == id);
    notifyListeners();
    try {
      final response = await http.delete(url);
      if (response.statusCode >= 400) {
        _property.insert(existingPropertyIndex, existingProperty);
        notifyListeners();
        throw HttpException("Could not delete Property");
      } else {
        existingProperty = null;
      }
    } catch (error) {
      _property.insert(existingPropertyIndex, existingProperty);
      notifyListeners();
      throw HttpException("Could not delete Property");
    }
  }

//-----------------Sorting Function-----------------
  void highestToLowest() {
    _property.sort((b, a) => a.price.compareTo(b.price));
  }

  void lowestToHighest() {
    _property.sort((b, a) => b.price.compareTo(a.price));
  }
  //--------------END OF SORTING FUNCTION-----------------

//-----------------add Property-------------
  Future<void> addProperty(
      BuildContext context, Property property, List<File> images) async {
    final url = "https://bellasareas.firebaseio.com/properties.json?auth=$authToken";
    List<String> fileName = [];
    List<String> imageURL = [];
    for (int i = 0; i != images.length; i++) {
      fileName.add('property/${basename(images[i].path)}');
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName[i]);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(images[i]);
      var downloadURL =
          await (await uploadTask.onComplete).ref.getDownloadURL();
      imageURL.add(downloadURL.toString());
    }
    try {
      final response = await http.post(url,
          body: json.encode({
            "images": imageURL,
            "location": property.location,
            "price": property.price,
            "bathrooms": property.bathrooms,
            "floors": property.floors,
            "category": property.category,
            "roadAccess": property.roadAccess,
            "area": property.area,
            "totalRooms": property.totalRooms,
            "ownerContact": property.ownerContact,
            "ownerEmail": property.ownerEmail,
            "ownerName": property.ownerName,
            "creatorId":userId
          }));
      propertyId = json.decode(response.body)['name'];
      final newProperty = Property(
          ownerName: property.ownerName,
          ownerEmail: property.ownerName,
          ownerContact: property.ownerName,
          id: propertyId,
          images: imageURL,
          location: property.location,
          price: property.price,
          bathrooms: property.bathrooms,
          floors: property.floors,
          category: property.category,
          roadAccess: property.roadAccess,
          area: property.area,
          totalRooms: property.totalRooms);
      _property.add(newProperty);
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }


//---------------------update Property------------
  Future<void> updateProperty(
      String id, Property property, List<File> images) async {
    final propertyIndex = _property.indexWhere((property) => property.id == id);
    List<String> fileName = [];
    List<String> imageURL = [];
    for (int i = 0; i != images.length; i++) {
      fileName.add('property/${basename(images[i].path)}');
      StorageReference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(fileName[i]);
      StorageUploadTask uploadTask = firebaseStorageRef.putFile(images[i]);
      var downloadURL =
          await (await uploadTask.onComplete).ref.getDownloadURL();
      print("------------------Updated Image URL----------------------");
      print(downloadURL.toString());
      imageURL.add(downloadURL.toString());
    }
    try {
      if (propertyIndex >= 0) {
        final url = "https://bellasareas.firebaseio.com/properties/$id.json?auth=$authToken";
        await http.patch(url,
            body: json.encode({
              "images": imageURL,
              "location": property.location,
              "price": property.price,
              "bathrooms": property.bathrooms,
              "floors": property.floors,
              "category": property.category,
              "roadAccess": property.roadAccess,
              "area": property.area,
              "totalRooms": property.totalRooms,
              "ownerContact": property.ownerContact,
              "ownerEmail": property.ownerEmail,
              "ownerName": property.ownerName,
            }));
        _property[propertyIndex] = property;
        notifyListeners();
      }
    } catch (error) {
      throw error;
    }
  }

//---------------Upload photo to firebase Storage----------------------
//   Future uploadPhoto(BuildContext context, List<File> images) async {
//     List<String> fileName = [];
// //    final StorageReference firebaseStorageRef =
// //        FirebaseStorage.instance.ref().child('myImages.jpg');
// //    final StorageUploadTask task = firebaseStorageRef.putFile(images[0]);

//     for (int i = 0; i != images.length; i++) {
//       fileName.add('property/$propertyId/${basename(images[i].path)}');
//       print(fileName[i]);
//       StorageReference firebaseStorageRef =
//           FirebaseStorage.instance.ref().child(fileName[i]);
//       StorageUploadTask uploadTask = firebaseStorageRef.putFile(images[i]);
//       await uploadTask.onComplete;
//     }
//   }

//--------------Fetch Properties from firebase----------
  Future<void> fetchAndSetProperty([bool filterUser = false]) async {
    final filterString =
    filterUser ? 'orderBy="creatorId"&equalTo="$userId"' : "";
    final url = "https://bellasareas.firebaseio.com/properties.json?auth=$authToken&$filterString";
    print("User Id:"+userId);
    print(url);
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Property> loadedProperty = [];
      extractedData.forEach((propertyId, propertyData) {
        loadedProperty.add(Property(
            id: propertyId,
            location: propertyData["location"],
            images: List.from(propertyData['images']),
            bathrooms: propertyData["bathrooms"],
            floors: propertyData["floors"],
            ownerContact: propertyData["ownerContact"],
            ownerEmail: propertyData["ownerEmail"],
            ownerName: propertyData["ownerName"],
            totalRooms: propertyData["totalRooms"],
            price: propertyData["price"],
            category: propertyData["category"],
            area: propertyData["area"],
            roadAccess: propertyData["roadAccess"]));
      });
      _property = loadedProperty;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}

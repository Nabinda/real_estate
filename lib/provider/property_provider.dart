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
      category: Category.building,
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
      location: "Pokhara",
      area: "0-0-4-0",
      roadAccess: 0.2,
      bathrooms: 4,
      floors: 3,
      totalRooms: 20,
      price: 2000000,
      category: Category.building,
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
      location: "Biratnagar",
      price: 2000000,
      category: Category.building,
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
      category: Category.land,
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
  List<Property> get properties {
    return [..._property];
  }

  Property findById(String id) {
    return _property.firstWhere((property) => property.id == id);
  }

  List<String> getImageURL(String id) {
    return _property.firstWhere((property) => property.id == id).images;
  }

  List<Property> get landProperties {
    return [
      ..._property.where((property) => property.category == Category.land)
    ];
  }

  List<Property> get buildingProperties {
    return [
      ..._property.where((property) => property.category == Category.building)
    ];
  }
}

import 'package:flutter/material.dart';

class Property {
  final String id;
  final String location;
  final List<String> images;
  final String ownerContact;
  final String ownerName;
  final String ownerEmail;
  final double price;
  final String category;
  final String area;
  final double roadAccess;
  final String floors;
  final String bathrooms;
  final String totalRooms;

  Property({
    @required this.id,
    @required this.location,
    @required this.images,
     this.ownerContact,
     this.ownerName,
     this.ownerEmail,
    @required this.price,
    @required this.category,
    @required this.area,
    @required this.roadAccess,
    this.floors,
    this.bathrooms,
    this.totalRooms,
  });
}

import 'package:flutter/material.dart';

enum Category { land, building }

class Property {
  final String id;
  final String location;
  final List<String> images;
  final String ownerContact;
  final String ownerName;
  final String ownerEmail;
  final double price;
  final Category category;
  final Map<String, Object> details;
  Property({
    @required this.id,
    @required this.location,
    @required this.images,
    @required this.ownerContact,
    @required this.ownerName,
    @required this.ownerEmail,
    @required this.price,
    @required this.category,
    @required this.details,
  });
}

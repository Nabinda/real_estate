import 'package:flutter/cupertino.dart';

class User{
  final String id;
  final String name;
  final String contact;
  final String email;
  User({
    @required this.id,
    @required this.name,
    @required this.contact,
    @required this.email
  });
}
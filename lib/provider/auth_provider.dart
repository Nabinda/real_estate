import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  String _userId;
  String _email;
  String _userName;
  String _imageUrl;
  String _contact;
  Future<void> getUserInfo() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    _userId = user.uid;
    await Firestore.instance.collection("users").document(_userId).get().then((userInfo){
      _email = userInfo["Email"];
      _userName = userInfo["Name"];
      _contact = userInfo["Contact"];
      _imageUrl = userInfo["ProfileUrl"];
    });
  }
  String get userId {
    return _userId;
  }

  String get email {
    return _email;
  }

  String get userName {
    return _userName;
  }

  String get imageUrl {
    return _imageUrl;
  }

  String get contact {
    return _contact;
  }
  Future<void> updateVerification() async{
    var user = await _firebaseAuth.currentUser();
    await Firestore.instance.collection('users').document(userId).updateData({
      "isVerified":true
    }).catchError((error){
      print("Error on Updating Verification:"+error.toString());
    });
  }
  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("userData")) {
      return false;
    }
    final extractedData =
    json.decode(prefs.getString("userData")) as Map<String, Object>;
    _userName = extractedData['Name'];
    _email = extractedData['Email'];
    _contact = extractedData['Contact'];
    _userId = extractedData['userId'];
    _imageUrl = extractedData['ProfileUrl'];
    notifyListeners();
    return true;
  }
  void addToPrefs() async{
    final userData = json.encode({
      "Name":_userName,
      "Email":_email,
      "ProfileUrl":_imageUrl,
      "Contact":_contact,
      "userId":_userId,
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("userData", userData);
  }
  Future<void> updateUserInfo(String name, String profileUrl) async {
    var user = await _firebaseAuth.currentUser();
    UserUpdateInfo info = new UserUpdateInfo();
    info.displayName = name;
    info.photoUrl = profileUrl;
    user.updateProfile(info);
    await user.reload();
  }

  Future<void> addUserInfo(String userId, String name, String email, String contact, String profileUrl, String deviceToken) async {
    var user = await _firebaseAuth.currentUser();
    print("I am  here");
    await Firestore.instance.collection('users').document(userId).setData({
      "Name": name,
      "Email": email,
      "Contact": contact,
      "ProfileUrl": profileUrl,
      "userId": userId,
      "isVerified": user.isEmailVerified,
      "deviceToken": deviceToken
    });
    updateUserInfo(name, profileUrl);
  }

  Future<String> logOut() async {
    String returnValue = "error";
    try {
      await _firebaseAuth.signOut();
      _email = null;
      _userName = null;
      _imageUrl = null;
      _userId = null;
      _contact = null;
      final prefs = await SharedPreferences.getInstance();
      prefs.clear();
      notifyListeners();
      returnValue = "success";
    } catch (error) {
      print(error);
    }
    return returnValue;
  }
}

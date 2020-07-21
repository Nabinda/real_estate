import 'dart:convert';

import 'package:bellasareas/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AuthProvider extends ChangeNotifier{
 //String userId;
  User user;
  bool isLogin = false;
  String currentUserEmail;
  bool get login{
    return isLogin;
  }
  User get fetchedUser{
    return user;
  }
  void setLogin(bool value){
    isLogin = value;
    notifyListeners();
  }
//  void setUserId(String uid){
//    userId = uid;
//    notifyListeners();
//
//  }
  
  //-------------Fetch Users from Database--------------
  Future<void> fetchUser(String userId) async{
    final url = "https://bellasareas.firebaseio.com/user_info/$userId.json";
    User fetchUser;
    try{
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      fetchUser=User(id: extractedData["userId"], name: extractedData["name"], contact: extractedData["contact"], email: extractedData["email"]);
      user = fetchUser;
      notifyListeners();
    }catch(error){
      throw(error);
    }
  }
//------------Add User Info to DataBase---------------------
  Future<void> addUser(String userId,String name,String contact,String email) async{
      final url ="https://bellasareas.firebaseio.com/user_info/$userId.json";
      try{
        final response = await http.put(url,body:json.encode({
            "name":name,
            "userId":userId,
            "contact":contact,
            "email":email
        }));
      }catch(error){
        throw(error);
      }
  }
  //-------Get current user information-------
  
}

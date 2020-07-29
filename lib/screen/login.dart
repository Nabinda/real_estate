import 'package:bellasareas/exception/http_exception.dart';
import 'package:bellasareas/main.dart';
import 'package:bellasareas/provider/auth_provider.dart';
import 'package:bellasareas/screen/overview_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'login_signup.dart';

class Login extends StatefulWidget {
  static const routName = "/login";
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _form = GlobalKey<FormState>();
  String _email;
  String _password;
  bool _isLoading = false;
 void showErrorDialog(String errorDialog) {
    showCupertinoDialog(context: context, builder: (ctx){
              return CupertinoAlertDialog(
                title: Text(errorDialog),
                actions: <Widget>[
                  CupertinoDialogAction(child: Text("OK"),onPressed:() {Navigator.pop(context);})
                ],
              );
            });
  }
 Future<void> checkLogin() async{
    if (!_form.currentState.validate()) {
      // Invalid!
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try{
      await Provider.of<Auth>(context, listen: false)
            .logIn(_email, _password);
           Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    }on HttpException catch (error) {
      print(error);
      var errorMessage = "Authentication Failed";
      if (error.toString().contains("EMAIL_EXITS")) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains("INVALID_EMAIL")) {
        errorMessage = 'This is not a valid email address.';
      } else if (error.toString().contains("WEAK_PASSWORD")) {
        errorMessage = 'This password is too weak.';
      } else if (error.toString().contains("EMAIL_NOT_FOUND")) {
        errorMessage = "Email address doesn't exists.";
      } else if (error.toString().contains("INVALID_PASSWORD")) {
        errorMessage = 'Invalid password.';
      }
      showErrorDialog(errorMessage);
    
  }catch(error){
    const errorMessage = "Could not Authenticate. Please try again later";
    showErrorDialog(errorMessage);
  }
  setState(() {
      _isLoading = false;
    });

  }
@override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter,
              //end: Alignment.bottomCenter,
              colors: [
                Colors.purple[900],
                Colors.purple[800],
                Colors.purple[300],
              ]),
        ),
        child:
        _isLoading?Center(child: CircularProgressIndicator()):
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 80.0,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'Bellas Areas',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30.0,
                        ),
                        Form(
                          key: _form,
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.deepPurpleAccent,
                                          offset: Offset(0, 10),
                                          blurRadius: 20)
                                    ]),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.trim() == null) {
                                      return 'Field must not be empty';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _email = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    hintText: ' Email',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              Container(
                                padding:
                                EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.deepPurpleAccent,
                                          offset: Offset(0, 10),
                                          blurRadius: 20)
                                    ]),
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.trim() == null) {
                                      return 'Field must not be empty';
                                    }
                                    if (value.length < 8) {
                                      return 'Length must not be less then 8';
                                    }
                                    return null;
                                  },
                                  onSaved: (value) {
                                    _password = value;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.vpn_key),
                                    hintText: ' Password',
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                    ),
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        Text(
                          'Forget Password ?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        GestureDetector(
                          onTap: checkLogin,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(30),
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white70,
                                  offset: Offset(0, 10),
                                  blurRadius: 10.0,
                                ),
                              ],
                              gradient: LinearGradient(colors: [
                                Colors.purple[900],
                                Colors.purple[600],
                                Colors.purple[200],
                              ]),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Do not have account ?',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(SignUp.routeName);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.all(30),
                            height: 50,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.white70,
                                  offset: Offset(0, 10),
                                  blurRadius: 10.0,
                                ),
                              ],
                              gradient: LinearGradient(colors: [
                                Colors.purple[900],
                                Colors.purple[600],
                                Colors.purple[200],
                              ]),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
//                        Text(
//                          'Continue with Social media',
//                          style: TextStyle(
//                            color: Colors.grey,
//                            fontWeight: FontWeight.bold,
//                            fontStyle: FontStyle.italic,
//                            fontSize: 17,
//                          ),
//                        ),
//                        SizedBox(
//                          height: 30,
//                        ),
//                        Row(
//                          children: <Widget>[
//                            Expanded(
//                              child: Container(
//                                alignment: Alignment.center,
//                                //   margin: EdgeInsets.all(30),
//                                height: 50,
//                                decoration: BoxDecoration(
//                                  boxShadow: [
//                                    BoxShadow(
//                                      color: Colors.white70,
//                                      offset: Offset(0, 10),
//                                      blurRadius: 10.0,
//                                    ),
//                                  ],
//                                  color: Colors.blue[900],
//                                  borderRadius: BorderRadius.circular(50),
//                                ),
//                                child: Icon(
//                                  FontAwesomeIcons.facebookF,
//                                  color: Colors.white,
//                                  size: 40,
//                                ),
//                              ),
//                            ),
//                            SizedBox(
//                              width: 20.0,
//                            ),
//                            Expanded(
//                              child: Container(
//                                alignment: Alignment.center,
//                                //  margin: EdgeInsets.all(30),
//                                height: 50,
//                                decoration: BoxDecoration(
//                                  boxShadow: [
//                                    BoxShadow(
//                                      color: Colors.white70,
//                                      offset: Offset(0, 10),
//                                      blurRadius: 10.0,
//                                    ),
//                                  ],
//                                  color: Color(0xFF17a3f2),
//                                  borderRadius: BorderRadius.circular(50),
//                                ),
//                                child: Icon(
//                                  FontAwesomeIcons.twitter,
//                                  color: Colors.white,
//                                  size: 40,
//                                ),
//                              ),
//                            ),
//                          ],
//                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

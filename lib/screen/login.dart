import 'package:bellasareas/exception/http_exception.dart';
import 'package:bellasareas/main.dart';
import 'package:bellasareas/provider/auth_provider.dart';
import 'package:bellasareas/screen/signup.dart';
import 'package:bellasareas/utils/custom_clip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bellasareas/utils/custom_theme.dart' as style;

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
    showCupertinoDialog(
        context: context,
        builder: (ctx) {
          return CupertinoAlertDialog(
            title: Text(errorDialog),
            actions: <Widget>[
              CupertinoDialogAction(
                  child: Text("OK"),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  Future<void> checkLogin() async {
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await Provider.of<Auth>(context, listen: false).logIn(_email, _password);
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    } on HttpException catch (error) {
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
    } catch (error) {
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
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              backgroundColor: style.CustomTheme.circularColor1,
              valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.white.withOpacity(0.4)),
            ))
          : SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  //Navigation Bar
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ClipPath(
                      clipper: CustomsClip(),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: style.CustomTheme.purpleGradient,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('Welcome to',
                                style: style.CustomTheme.headerlarge),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'BellasAreas',
                              style: style.CustomTheme.headerMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
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
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow:
                                      style.CustomTheme.textFieldBoxShadow
                                    ),
                                child: TextFormField(
                                  onSaved: (value) {
                                    _email = value;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.email),
                                    hintText: ' Email',
                                    hintStyle:
                                        style.CustomTheme.textInputDecoration,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40.0,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow:
                                      style.CustomTheme.textFieldBoxShadow
                                    ),
                                child: TextFormField(
                                  onSaved: (value) {
                                    _password = value;
                                  },
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.vpn_key),
                                    hintText: ' Password',
                                    hintStyle:
                                        style.CustomTheme.textInputDecoration,
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
                        GestureDetector(
                          onTap: checkLogin,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top: 20, left: 30, right: 30, bottom: 10),
                            height: 50,
                            decoration: style.CustomTheme.buttonDecoration,
                            child: Text(
                              'Login',
                              style: style.CustomTheme.buttonFont,
                            ),
                          ),
                        ),
                        Text(
                          'Do not have account ?',
                          style: style.CustomTheme.textInputDecoration,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(SignUp.routeName);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top: 20, left: 30, right: 30, bottom: 10),
                            height: 50,
                            decoration: style.CustomTheme.buttonDecoration,
                            child: Text(
                              'SignUp',
                              style: style.CustomTheme.buttonFont,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

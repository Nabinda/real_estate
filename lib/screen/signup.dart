import 'package:bellasareas/provider/auth_provider.dart';
import 'package:bellasareas/screen/login.dart';
import 'package:bellasareas/utils/custom_clip.dart';
import 'package:bellasareas/utils/error_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bellasareas/utils/custom_theme.dart' as style;

class SignUp extends StatefulWidget {
  static const routeName = "/signup";
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    super.initState();
    _getToken();
  }

  final _form = GlobalKey<FormState>();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final passwordController = TextEditingController();
  bool _isLoading = false;
  String _email;
  String _password;
  String _name;
  String _contact;
  String token;
  void _getToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      token = deviceToken;
    });
  }

  Future<void> verification() async {
    var user = await FirebaseAuth.instance.currentUser();
    user.sendEmailVerification().then((push) {
      setState(() {
        _isLoading = false;
      });
      Provider.of<AuthProvider>(context, listen: false).addUserInfo(
          user.uid,
          _name,
          _email,
          _contact,
          "https://firebasestorage.googleapis.com/v0/b/confession-ff8df.appspot.com/o/user.png?alt=media&token=7a15f72b-56c4-404a-86a2-94ab6ecb248d",
          token);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => Login()));
    }).catchError((error) {
      showErrorDialog("An Error Occurred while sending email verification");
    });
  }
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
  Future<void> signUp() async {
    if (!_form.currentState.validate()) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password)
          .then((authResult) {
        verification();
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
        if (error.code == "ERROR_EMAIL_ALREADY_IN_USE") {
          showErrorDialog("Email is already used.");
        }
        return null;
      });
    } catch (error) {
      throw (error);
    }
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
                  //----------Navigation Bar
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.4,
                    child: ClipPath(
                      clipper: CustomsClip(),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: style.CustomTheme.purpleGradient,
                        ),
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              top: 90,
                              left: 50,
                              child: Column(
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
                            Positioned(
                              top: 20,
                              left: 10,
                              child: IconButton(
                                  icon: Icon(Icons.arrow_back_ios,
                                      color: Colors.white),
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(Login.routName);
                                  }),
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
                        Form(
                          key: _form,
                          child: Column(
                            children: <Widget>[
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow:
                                        style.CustomTheme.textFieldBoxShadow),
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: TextFormField(
                                    onSaved: (value) {
                                      _name = value;
                                    },
                                    validator: (value) {
                                      if (value.trim() == "") {
                                        return 'Field should not be empty';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.person,
                                          color: Colors.grey),
                                      hintText: ' Name',
                                      hintStyle:
                                          style.CustomTheme.textInputDecoration,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow:
                                        style.CustomTheme.textFieldBoxShadow),
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: TextFormField(
                                    onSaved: (value) {
                                      _contact = value;
                                    },
                                    validator: (value) {
                                      if (value.trim() == "") {
                                        return 'Field should not be empty';
                                      }
                                      if (value.length < 10) {
                                        return 'Incorrect number';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.phone,
                                        color: Colors.grey,
                                      ),
                                      hintText: ' Contact',
                                      hintStyle:
                                          style.CustomTheme.textInputDecoration,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow:
                                        style.CustomTheme.textFieldBoxShadow),
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: TextFormField(
                                    onSaved: (value) {
                                      _email = value;
                                    },
                                    validator: (value) {
                                      if (value.trim() == "") {
                                        return 'Field should not be empty';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      prefixIcon:
                                          Icon(Icons.email, color: Colors.grey),
                                      hintText: ' Email',
                                      hintStyle:
                                          style.CustomTheme.textInputDecoration,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow:
                                        style.CustomTheme.textFieldBoxShadow),
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: TextFormField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    onSaved: (value) {
                                      _password = value;
                                    },
                                    validator: (value) {
                                      if (value.trim() == "") {
                                        return 'Field should not be empty';
                                      }
                                      if (value.length < 8) {
                                        return 'Password must be at least 8 digit';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.vpn_key,
                                        color: Colors.grey,
                                      ),
                                      hintText: ' Password',
                                      hintStyle:
                                          style.CustomTheme.textInputDecoration,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow:
                                        style.CustomTheme.textFieldBoxShadow),
                                child: Container(
                                  child: TextFormField(
                                    validator: (value) {
                                      if (value != passwordController.text) {
                                        return 'Password does not match';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.vpn_key,
                                        color: Colors.grey,
                                      ),
                                      hintText: ' Confirm Password',
                                      hintStyle:
                                          style.CustomTheme.textInputDecoration,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: signUp,
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top: 40, left: 30, right: 30, bottom: 20),
                            height: 40,
                            decoration: style.CustomTheme.buttonDecoration,
                            child: Text(
                              'Sign Up',
                              style: style.CustomTheme.buttonFont,
                            ),
                          ),
                        ),
                        Text(
                          'Already have an account!',
                          style: style.CustomTheme.kTextGreyStyle,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed(Login.routName);
                          },
                          child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                top: 10, left: 30, right: 30, bottom: 10),
                            height: 40,
                            decoration: style.CustomTheme.buttonDecoration,
                            child: Text(
                              'Login',
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

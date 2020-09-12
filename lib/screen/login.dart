import 'package:bellasareas/provider/auth_provider.dart';
import 'package:bellasareas/screen/overview_screen.dart';
import 'package:bellasareas/screen/signup.dart';
import 'package:bellasareas/utils/custom_clip.dart';
import 'package:bellasareas/utils/error_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
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
  Future<void> checkVerification() async{
    var user = await FirebaseAuth.instance.currentUser();
    if(user.isEmailVerified){
      Provider.of<AuthProvider>(context,listen: false).getUserInfo();
      Provider.of<AuthProvider>(context,listen: false).updateVerification();
      Navigator.of(context).pushNamedAndRemoveUntil(
          OverViewScreen.routeName, (Route<dynamic> route) => false);
    }
    else if(!user.isEmailVerified){
      setState(() {
        _isLoading = false;
      });
      showErrorDialog("Verify Your Email Address First");
    }
  }
  Future<void> logIn() async {
    setState(() {
      _isLoading=true;
    });
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: _email, password: _password)
          .then((authResult) {
        checkVerification();
      }).catchError((error) {
        setState(() {
          _isLoading = false;
        });
        if (error.code == "ERROR_USER_NOT_FOUND") {
          showErrorDialog("Email Address Not Found");
        }
        if (error.code == "ERROR_WRONG_PASSWORD") {
          showErrorDialog("Invalid Password");
        }
        return null;
      });
    } catch (error) {
      throw (error);
    }
  }
  void checkLogin() {
      _form.currentState.save();
      if(_email.isEmpty||_password.isEmpty){
        showErrorDialog("Fill the Form Properly");
      }
      logIn();
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
                          style: style.CustomTheme.kTextGreyStyle,
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

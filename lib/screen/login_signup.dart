import 'package:bellasareas/screen/login.dart';
import 'package:bellasareas/screen/overview_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUp extends StatefulWidget {
  static const routeName = "/login_signup";
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _form = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  //-----------Information For Form-----------
  String _email;
  String _password;
  String _name;
  String _contact;


Future<void> signUp() async{
  print("signup");
      if(_form.currentState.validate()){
        _form.currentState.save();
        try{
           await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password).then((authResult) {
          Navigator.pushReplacement(  
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => Login()));
        }).catchError((error){
          print(error.code);
          if(error.code=="ERROR_EMAIL_ALREADY_IN_USE"){
            return showCupertinoDialog(context: context, builder: (ctx){
              return CupertinoAlertDialog(
                title: Text("Email already exists!!"),
                actions: <Widget>[
                  CupertinoDialogAction(child: Text("OK"),onPressed:() {Navigator.pop(context);})
                ],
              );
            });
          }
          return null;
        });
        }
        catch(error){
          throw(error);
        }
      }
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                onPressed: () {
                  Navigator.of(context).pushNamed(OverViewScreen.routeName);
                }),
            SizedBox(height: 50.0),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  Text(
                    "Create",
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                   "an Account",
                    style: TextStyle(
                        fontSize: 30,
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),

                        //----------------------Form Field-------------------
                        Form(
                          key: _form,
                          child: Column(
                            children: <Widget>[
                               Column(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                    offset: Offset(0, 10),
                                                    blurRadius: 20)
                                              ]),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: TextFormField(
                                              onSaved: (value){
                                                _name=value;
                                              },
                                              validator: (value){
                                                if(value.trim()==""){
                                                  return 'Field should not be empty';
                                                }
                                                return null;
                                              },
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(Icons.person,
                                                    color: Colors.purple),
                                                hintText: ' Name',
                                                hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                ),
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
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                    color:
                                                        Colors.deepPurpleAccent,
                                                    offset: Offset(0, 10),
                                                    blurRadius: 20)
                                              ]),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 20.0),
                                            child: TextFormField(
                                              onSaved: (value){
                                                _contact=value;
                                              },
                                              validator: (value){
                                                if(value.trim()==""){
                                                  return 'Field should not be empty';
                                                }
                                                if(value.length<10){
                                                  return 'Incorrect number';
                                                }
                                                return null;
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                prefixIcon: Icon(
                                                  Icons.phone,
                                                  color: Colors.purple,
                                                ),
                                                hintText: ' Contact',
                                                hintStyle: TextStyle(
                                                  color: Colors.grey,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ),
                              Container(
                                height: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.deepPurpleAccent,
                                          offset: Offset(0, 10),
                                          blurRadius: 20)
                                    ]),
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: TextFormField(
                                    onSaved: (value){
                                                _email=value;
                                              },
                                  validator: (value){
                                                if(value.trim()==""){
                                                  return 'Field should not be empty';
                                                }
                                                return null;
                                              },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(Icons.email,
                                          color: Colors.purple),
                                      hintText: ' Email',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
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
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.deepPurpleAccent,
                                          offset: Offset(0, 10),
                                          blurRadius: 20)
                                    ]),
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  child: TextFormField(
                                    controller: passwordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    obscureText: true,
                                    onSaved: (value){
                                                _password=value;
                                              },
                                              validator: (value){
                                                if(value.trim()==""){
                                                  return 'Field should not be empty';
                                                }
                                                if(value.length<8){
                                                  return 'Password must be at least 8 digit';
                                                }
                                                return null;
                                              },
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.vpn_key,
                                        color: Colors.purple,
                                      ),
                                      hintText: ' Password',
                                      hintStyle: TextStyle(
                                        color: Colors.grey,
                                      ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                            Container( padding: EdgeInsets.symmetric(
                                horizontal: 20.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.deepPurpleAccent,
                                                offset: Offset(0, 10),
                                                blurRadius: 20)
                                          ]),
                                      child: Container(

                                        child: TextFormField( validator: (value){
                                                if(value!=passwordController.text){
                                                  return 'Password doesnot match';
                                                }
                                                return null;
                                              },
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          obscureText: true,
                                          decoration: InputDecoration(
                                            prefixIcon: Icon(
                                              Icons.vpn_key,
                                              color: Colors.purple,
                                            ),
                                            hintText: ' Confirm Password',
                                            hintStyle: TextStyle(
                                              color: Colors.grey,
                                            ),
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
                            margin: EdgeInsets.all(30),
                            height: 40,
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
                             'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ),
                        Column(
                          children: <Widget>[
                            Text('Already have an account!',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushNamed(Login.routName);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.all(30),
                                height: 40,
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
                          ],
                        ),

                        //-------------------------Login with social Media-----------------------------

                        Text(
                          'Continue with Social media',
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontStyle: FontStyle.italic,
                            fontSize: 17,
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),

                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                //   margin: EdgeInsets.all(30),
                                height: 50,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white70,
                                      offset: Offset(0, 10),
                                      blurRadius: 10.0,
                                    ),
                                  ],
                                  color: Colors.blue[900],
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.facebookF,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20.0,
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                //  margin: EdgeInsets.all(30),
                                height: 50,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.white70,
                                      offset: Offset(0, 10),
                                      blurRadius: 10.0,
                                    ),
                                  ],
                                  color: Color(0xFF17a3f2),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.twitter,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ),
                            ),
                          ],
                        ),
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

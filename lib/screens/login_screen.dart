import 'package:flutter/material.dart';
import 'package:vaccation_nanny/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccation_nanny/screens/dashboard_screen.dart';
import 'package:vaccation_nanny/screens/password_reset_screen.dart';
import 'package:vaccation_nanny/screens/register_screen.dart';
import 'package:vaccation_nanny/ui_modules/rounded_rectangle_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginscreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _firestore = Firestore.instance;
  String email;
  String password;
  final _auth = FirebaseAuth.instance;
  bool spinner = false;

  @override
  Widget build(BuildContext context) {
    showASnackBar(BuildContext context, String message) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
    }

    return Scaffold(
      body: Builder(
        builder: (context) => ModalProgressHUD(
          inAsyncCall: spinner,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'images/nannysideregisterscreenheader4.png')),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Colors.redAccent,
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) {
                          email = value;
                        },
                        decoration: kInputDecoration.copyWith(
                          hintText: 'Enter your email',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
                      child: TextField(
                        style: TextStyle(color: Colors.black),
                        obscureText: true,
                        onChanged: (value) {
                          password = value;
                        },
                        decoration: kInputDecoration.copyWith(
                          hintText: 'Enter your password',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 16),
                      child: RoundedNavigationButton(
                        title: 'Login',
                        color: Color(0XFFfd992a),
                        onPressed: () async {
                          if (email == null || email.length == 0) {
                            showASnackBar(
                                context, 'Please enter the email address');
                          } else if (email.indexOf('@') == -1 ||
                              email.indexOf('.') == -1) {
                            showASnackBar(
                                context, 'Please enter a valid email address');
                          } else if (password == null || password.length == 0) {
                            showASnackBar(context, 'Please enter the password');
                          } else {
                            try {
                              setState(() {
                                spinner = true;
                              });
                              final newuser =
                                  await _auth.signInWithEmailAndPassword(
                                      email: email, password: password);
                              //login seperator checks start
                              bool found = false;
                              var loggedInUser = await _auth.currentUser();
                              var allUsers = await _firestore
                                  .collection('users')
                                  .getDocuments();
                              for (var user in allUsers.documents) {
                                if (user.documentID == loggedInUser.uid) {
                                  found = true;
                                }
                              }
                              if (found == false) {
                                throw 'User not found';
                              }
                              //login seperator checks end

                              if (newuser != null) {
                                Navigator.pushReplacementNamed(
                                    context, DashboardScreen.id);
                              }
                              setState(() {
                                spinner = false;
                              });
                            } catch (e) {
                              setState(() {
                                spinner = false;
                              });
                              showASnackBar(context,
                                  e.runtimeType == String ? e : e.message);
                              print(e);
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                      onTap: () async {
                        var successfull = await Navigator.pushNamed(
                            context, PasswordResetScreen.id);
                        if (successfull != null && successfull) {
                          showASnackBar(context,
                              "Please check your email for password reset.");
                        }
                      },
                      child: Center(
                          child: Text(
                        'Forgot password?',
                        style: TextStyle(fontSize: 16),
                      )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RegistrationScreen.id);
                      },
                      child: Center(
                          child: Text(
                        'Create new account',
                        style: TextStyle(fontSize: 16),
                      )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// credits for the circular flowers <a href="https://www.vecteezy.com/free-vector/pattern">Pattern Vectors by Vecteezy</a>
// credits for alphabet <a href="https://www.freepik.com/free-photos-vectors/frame">Frame photo created by jcstudio - www.freepik.com</a>

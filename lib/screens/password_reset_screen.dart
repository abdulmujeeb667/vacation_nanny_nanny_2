import 'package:flutter/material.dart';
import 'package:vaccation_nanny/constants.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccation_nanny/ui_modules/rounded_rectangle_button.dart';

class PasswordResetScreen extends StatefulWidget {
  static const String id = 'passwordresetscreen';
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordResetScreen> {
  String email;
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
                      image: AssetImage('images/registerscreenheader3.png')),
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
                    SizedBox(
                      height: 24.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 16),
                      child: RoundedNavigationButton(
                        title: 'Submit',
                        color: Color(0XFFfd992a),
                        onPressed: () async {
                          if (email == null) {
                            showASnackBar(
                                context, 'Please enter the email address');
                          } else if (email.indexOf('@') == -1 ||
                              email.indexOf('.') == -1) {
                            showASnackBar(
                                context, 'Please enter a valid email address');
                          } else {
                            try {
                              setState(() {
                                spinner = true;
                              });
                              await _auth.sendPasswordResetEmail(email: email);
                              setState(() {
                                spinner = false;
                              });
                              Navigator.pop(context, true);
                            } catch (e) {
                              setState(() {
                                spinner = false;
                              });
                              print(e);
                              showASnackBar(context, e.message);
                            }
                          }
                        },
                      ),
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

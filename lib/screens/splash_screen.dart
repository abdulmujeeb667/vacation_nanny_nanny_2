import 'package:flutter/material.dart';
import 'package:vaccation_nanny/screens/correction_redirect_screen.dart';
import 'package:vaccation_nanny/screens/dashboard_screen.dart';
import 'package:vaccation_nanny/screens/welcome_screen.dart';
import 'package:vaccation_nanny/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashScreen extends StatefulWidget {
  static const id = "splashscreen";

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final _auth = FirebaseAuth.instance;
  dynamic loggedInUser;
  getCurrentUser() async {
    loggedInUser = await _auth.currentUser();
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    Future.delayed(Duration(seconds: 2)).then((value) {
      print(loggedInUser);
      if (loggedInUser != null) {
        Navigator.pushReplacementNamed(context, DashboardScreen.id);
      } else {
        Navigator.pushReplacementNamed(context, CorrectionRedirectScreen.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//          backgroundColor: Colors.red,
      body: GestureDetector(
        onTap: () {
          Navigator.pushReplacementNamed(context, WelcomeScreen.id);
        },
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            Color(0XFFfd992a),
            Color(0XFFF8B08F),
            Color(0XFFF6C0D0)
          ], stops: [
            0.1,
            0.3,
            0.6
          ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(70, 0, 70, 5),
                  child: Image.asset('images/logowhite.gif'),
                ),
                Text(
                  'Vacation Nanny',
                  style: kNexaBoldWhite.copyWith(
                      fontFamily: 'VN font', fontSize: 30),
                ),
                Text(
                  'NANNY SIDE',
                  style: kNexaBoldWhite.copyWith(color: Color(0XFF008B8B)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

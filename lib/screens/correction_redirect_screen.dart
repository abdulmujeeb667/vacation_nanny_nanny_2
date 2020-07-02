import 'package:flutter/material.dart';
import 'package:vaccation_nanny/constants.dart';
import 'package:vaccation_nanny/screens/welcome_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class CorrectionRedirectScreen extends StatefulWidget {
  static const id = "correctionredirectscreen";

  @override
  _CorrectionRedirectScreenState createState() =>
      _CorrectionRedirectScreenState();
}

class _CorrectionRedirectScreenState extends State<CorrectionRedirectScreen> {
  _launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.jassybrown.vacation_nanny_customer';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: double.infinity,
          ),
          Text(
            'I am a',
            style: kNexaBoldWhite,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.symmetric(horizontal: 45),
              color: Colors.white,
              onPressed: () {
                Navigator.pushReplacementNamed(context, WelcomeScreen.id);
              },
              child: Container(
                height: 100,
                width: 150,
                child: Center(
                  child: Text(
                    'Nanny\n(finding work)',
                    style: kNexaBoldWhite.copyWith(
                        color: Color(0XFFfd992a), fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.symmetric(horizontal: 45),
              color: Colors.white,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Download the Family side app'),
                    content: SingleChildScrollView(
                      child: Text(
                          'You are currently on the nanny side app. This app is intended for nannies to find and manage work. If you want to hire a nanny, you need to download the family side app. Click ok to be redirected to the family side app.'),
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('OK'),
                        onPressed: () {
                          _launchURL();
                        },
                      ),
                    ],
                  ),
                );
              },
              child: Container(
                height: 100,
                width: 150,
                child: Center(
                  child: Text(
                    'Family\n(looking for a nanny)',
                    style: kNexaBoldWhite.copyWith(
                        color: Color(0XFFfd992a), fontSize: 15),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

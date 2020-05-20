import 'package:flutter/material.dart';
import 'package:vaccation_nanny/constants.dart';
import 'package:vaccation_nanny/screens/login_screen.dart';
import 'package:vaccation_nanny/screens/register_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = "welcomescreen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  int currentPage = 0;
  final int numOfPages = 3;
  final _controller = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              height: 500,
              child: PageView(
                physics: ClampingScrollPhysics(),
                controller: _controller,
                onPageChanged: (int page) {
                  setState(() {
                    currentPage = page;
                  });
                },
                children: <Widget>[
                  SliderSection(
                    image: 'images/nannywelcomescreen1.png',
                    headingText: 'Get more customers as a nanny',
                    descriptionText:
                        'Did you know that you can signup as a nanny on our application and find hundreds of customers near you',
                  ),
                  SliderSection(
                    image: 'images/nannywelcomescreen2.png',
                    headingText: 'Our nannies are trusted more',
                    descriptionText:
                        'Clients trust our services and our nannies which is the sole reason why our nannies always get the best work',
                  ),
                  SliderSection(
                    image: 'images/nannywelcomescreen3.png',
                    headingText: 'Being on this app is huge for the portfolio',
                    descriptionText:
                        'Working woth Vacation Nanny will add a start on your resume',
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircleContainer(
                    currentPage == 0 ? 15 : 10, currentPage == 0 ? 15 : 10),
                CircleContainer(
                    currentPage == 1 ? 15 : 10, currentPage == 1 ? 15 : 10),
                CircleContainer(
                    currentPage == 2 ? 15 : 10, currentPage == 2 ? 15 : 10),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              padding: EdgeInsets.symmetric(horizontal: 45),
              color: Color(0XFFfd992a),
              onPressed: () {
                Navigator.pushReplacementNamed(context, LoginScreen.id);
              },
              child: Text(
                'Login',
                style: kNexaBoldWhite,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 20),
            child: FlatButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: Color(0XFFfd992a),
              onPressed: () {
                Navigator.pushReplacementNamed(context, RegistrationScreen.id);
              },
              child: Text(
                'Start today',
                style: kNexaBoldWhite,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SliderSection extends StatelessWidget {
  final String image;
  final String headingText;
  final String descriptionText;
  SliderSection(
      {@required this.image,
      @required this.headingText,
      @required this.descriptionText});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
            child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                  child: Image.asset(image),
                ))),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
          child: Text(
            headingText,
            style: kNexaBoldWhite,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            descriptionText,
            style: kNexaBoldWhite.copyWith(
                fontWeight: FontWeight.normal, fontSize: 15),
          ),
        ),
      ],
    );
  }
}

class CircleContainer extends StatelessWidget {
  final double height;
  final double width;
  CircleContainer(this.height, this.width);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      height: height,
      width: width,
      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
    );
  }
}

// credits:
// first slider image is a pro and needs to be bought
// <a href="https://www.vecteezy.com/free-vector/gradient">Gradient Vectors by Vecteezy</a>
// <a href="https://www.vecteezy.com/free-vector/nanny">Nanny Vectors by Vecteezy</a>

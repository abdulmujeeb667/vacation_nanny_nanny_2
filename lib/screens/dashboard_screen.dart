import 'package:flutter/material.dart';
import 'package:vaccation_nanny/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccation_nanny/screens/licensing_video_screen.dart';
import 'package:vaccation_nanny/screens/update_profile_screen.dart';
import 'package:vaccation_nanny/screens/welcome_screen.dart';
import 'package:vaccation_nanny/ui_modules/rounded_rectangle_button.dart';
import 'package:vaccation_nanny/ui_modules/universal_bottom_bar.dart';
import 'package:vaccation_nanny/fire_store_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class DashboardScreen extends StatefulWidget {
  static const id = "dashboardscreen";

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _auth = FirebaseAuth.instance;
  String firstName = '';
  String lastName = '';
  String email = '';
  String address = '';
  String paypal = '';
  String locationName = '';
  String profileimageUrl =
      'https://firebasestorage.googleapis.com/v0/b/vacation-nanny.appspot.com/o/loadinganimation.gif?alt=media&token=b8299b5d-8703-47d5-bcfb-5476c3d8b2e8';
  String idImageUrl = '';
  bool spinner = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  getUserData() async {
    spinner = true;
    final loggedInUser = await _auth.currentUser();
    final userData =
        await FireStoreDatabase(uid: loggedInUser.uid).fetchUserData();
    setState(() {
      firstName = userData['firstName'];
      lastName = userData['lastName'];
      email = userData['email'];
      address = userData['address'];
      paypal = userData['paypal'];
      locationName = userData['locationName'];
      profileimageUrl = userData['profileImageUrl'];
      idImageUrl = userData['idImageUrl'];
      spinner = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: UniversalBottomBar(),
      body: Builder(
        builder: (context) => ModalProgressHUD(
          inAsyncCall: spinner,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: 100.0,
                height: 300.0,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 70,
                        backgroundColor: Color(0XFFF6C0D0),
                        child: ClipOval(
                          child: SizedBox(
                            width: 130.0,
                            height: 130.0,
                            child: Image.network(
                              profileimageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        firstName + ' ' + lastName,
                        style: kNexaBoldWhite.copyWith(
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: Color(0XFF3CB371),
                          ),
                          Text(
                            locationName ?? '',
                            style: kNexaBoldWhite.copyWith(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                color: Color(0XFF3CB371)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Nanny',
                        style: kNexaBoldWhite.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.white70),
                      ),
                    ],
                  ),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  color: Color(0XFFfd992a),
                ),
              ),
              Expanded(
                child: ListView(
                  children: <Widget>[
                    Visibility(
                      visible: locationName == null || locationName.length == 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, UpdateProfileScreen.id)
                              .then((value) {
                            print('we are back');
                            getUserData();
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                          height: 50,
                          color: Color(0XFFCD5C5C),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: FaIcon(
                                  FontAwesomeIcons.exclamationCircle,
                                  color: Colors.white,
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                                  child: Wrap(
                                    children: <Widget>[
                                      Text(
                                        'Please add your location(GPS). Click here!',
                                        style: kNexaBoldWhite.copyWith(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 12),
                      child: Text(
                        "My info",
                        style: kNexaBoldWhite.copyWith(color: Colors.black),
                      ),
                    ),
                    InfoTile(
                      faIcon: FontAwesomeIcons.user,
                      name: firstName + ' ' + lastName,
                    ),
                    InfoTile(
                      faIcon: FontAwesomeIcons.envelope,
                      name: email,
                    ),
                    InfoTile(
                      faIcon: FontAwesomeIcons.addressCard,
                      name: address,
                    ),
                    InfoTile(
                      faIcon: FontAwesomeIcons.paypal,
                      name: paypal != null ? paypal : "Please add you paypal",
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: RoundedNavigationButton(
                        color: Color(0XFFFea7999),
                        title: "Licensing Guide",
                        onPressed: () {
                          Navigator.pushNamed(context, VideoApp.id);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: RoundedNavigationButton(
                        color: Color(0XFF5F9EA0),
                        title: "Edit info",
                        onPressed: () {
                          Navigator.pushNamed(context, UpdateProfileScreen.id)
                              .then((value) {
                            print('we are back');
                            getUserData();
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 15),
                      child: RoundedNavigationButton(
                        color: Color(0XFFCD5C5C),
                        title: "Log out",
                        onPressed: () async {
                          setState(() {
                            spinner = true;
                          });
                          await _auth.signOut();
                          setState(() {
                            spinner = false;
                          });
                          Navigator.pushReplacementNamed(
                              context, WelcomeScreen.id);
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

class InfoTile extends StatelessWidget {
  final IconData faIcon;
  final String name;
  InfoTile({@required this.faIcon, @required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 20,
          ),
          FaIcon(faIcon),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Wrap(
              children: <Widget>[
                Text(
                  name,
                  style: kNexaBoldWhite.copyWith(
                      color: Colors.black, fontWeight: FontWeight.normal),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

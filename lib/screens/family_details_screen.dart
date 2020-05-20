import 'package:flutter/material.dart';
import 'package:vaccation_nanny/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccation_nanny/fire_store_database.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class FamilyDetailsScreen extends StatelessWidget {
  static const id = "familydetailsscreen";
  final familyData;
  FamilyDetailsScreen({@required this.familyData});

  // getUserData() async {
  //   spinner = true;
  //   final loggedInUser = await _auth.currentUser();
  //   final userData =
  //       await FireStoreDatabase(uid: loggedInUser.uid).fetchUserData();
  //   setState(() {
  //     firstName = userData['firstName'];
  //     lastName = userData['lastName'];
  //     email = userData['email'];
  //     address = userData['address'];
  //     locationName = userData['locationName'];
  //     profileimageUrl = userData['profileImageUrl'];
  //     idImageUrl = userData['idImageUrl'];
  //     spinner = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0XFFfd992a),
        title: Text(
          'FAMILY DETAILS',
          style: kNexaBoldWhite,
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(familyData['profileImageUrl']),
                      //  _idImage != null
                      //     ? FileImage(_idImage)
                      //     : NetworkImage(idImageUrl)
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  familyData['firstName'] + ' ' + familyData['lastName'],
                  style: kNexaBoldWhite.copyWith(
                      fontWeight: FontWeight.normal, color: Colors.black),
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
                      familyData['locationName'] ?? '',
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
                      color: Colors.black54),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                InfoTile(
                  faIcon: FontAwesomeIcons.phoneAlt,
                  name: familyData['phone'] ?? '',
                ),
                InfoTile(
                  faIcon: FontAwesomeIcons.envelope,
                  name: familyData['email'],
                ),
                // InfoTile(
                //   faIcon: FontAwesomeIcons.addressCard,
                //   name: familyData['address'],
                // ),
                // InfoTile(
                //   faIcon: FontAwesomeIcons.checkCircle,
                //   name: "Can travel with family",
                // ),
                // InfoTile(
                //   faIcon: FontAwesomeIcons.checkCircle,
                //   name: "Experienced with needs of special childern",
                // ),
                // Padding(
                //   padding: const EdgeInsets.fromLTRB(0, 0, 0, 30),
                //   child: HeadingAndTextInputBox(
                //     heading: "Maximum weight carrying capacity:",
                //     textValue: "200 lbs",
                //   ),
                // ),
              ],
            ),
          ),
        ],
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
      padding: EdgeInsets.fromLTRB(0, 0, 30, 20),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 30,
          ),
          FaIcon(
            faIcon,
            color: Color(0XFFfd992a),
          ),
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

class HeadingAndTextInputBox extends StatelessWidget {
  final String heading;
  final String textValue;
  final int minLines;
  const HeadingAndTextInputBox({
    @required this.heading,
    @required this.textValue,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(25, 10, 25, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(heading),
          SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: TextEditingController(text: textValue),
                  readOnly: true,
                  minLines: minLines ?? 1,
                  maxLines: 4,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {},
                  decoration: kInputDecoration,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

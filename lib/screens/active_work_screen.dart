import 'package:flutter/material.dart';
import 'package:vaccation_nanny/ui_modules/universal_bottom_bar.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vaccation_nanny/fire_store_database.dart';
import 'package:vaccation_nanny/constants.dart';
import 'package:vaccation_nanny/screens/active_job_show_screen.dart';

class ActiveWorkScreen extends StatefulWidget {
  static const id = "activeworkscreen";

  @override
  _ActiveWorkScreenState createState() => _ActiveWorkScreenState();
}

class _ActiveWorkScreenState extends State<ActiveWorkScreen> {
  final _auth = FirebaseAuth.instance;
  List requestDataList = [];
  bool spinner = false;
  String locationName = '';
  var loggedInUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRequestData();
  }

  getRequestData() async {
    spinner = true;
    loggedInUser = await _auth.currentUser();
    final userData =
        await FireStoreDatabase(uid: loggedInUser.uid).fetchUserData();
    locationName = userData['locationName'];
    print(userData['locationName']);
    var requestDataList1 =
        await FireStoreDatabase().fetchRequestsData(locationName: locationName);
    setState(() {
      requestDataList = requestDataList1;
    });
    spinner = false;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> makeJobWidgets() {
      // print(requestDataList);
      List<Widget> listOfWidgets = [
        SizedBox(
          height: 10,
        )
      ];
      for (var requestData in requestDataList) {
        if (requestData['status']['status'] == 'active') {
          if (requestData['status']['nanny']['email'] == loggedInUser.email) {
            var newWidget = JobTemplate(
                imageUrl: requestData.data['requestImageUrl'],
                title: requestData.data['title'],
                budget: requestData.data['budget'],
                requestData: requestData,
                familyData: requestData['status']['family']);
            listOfWidgets.add(newWidget);
          }
        }
      }
      return listOfWidgets;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('ACTIVE JOBS'),
        backgroundColor: Color(0XFFfd992a),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: UniversalBottomBar(),
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: ListView(
          children: makeJobWidgets(),
        ),
      ),
    );
  }
}

class JobTemplate extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String budget;
  final requestData;
  final familyData;

  JobTemplate(
      {@required this.imageUrl,
      @required this.title,
      @required this.budget,
      @required this.requestData,
      @required this.familyData});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ActiveJobShowScreen(
                      requestData: requestData,
                      familyData: familyData,
                    )));
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(25, 5, 25, 5),
        decoration: BoxDecoration(
          color: Color(0XFFF5F5F5),
          borderRadius: BorderRadius.all(Radius.circular(10)),
          // border: Border.all(color: Color(0XFFfd992a), width: 2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: imageUrl != null
                      ? NetworkImage(imageUrl)
                      : AssetImage('images/requestclipart.png'),
                ),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: kNexaBoldWhite.copyWith(
                          color: Color(0XFF6A6A6A), fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '\$ $budget',
                      style: kNexaBoldWhite.copyWith(color: Colors.green),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "active",
                      style: kNexaBoldWhite.copyWith(
                          color: Color(0XFFfd992a), fontSize: 14),
                    ),
                    Text(
                      "assigned by: ${familyData['firstName']} ${familyData['lastName']}",
                      style: kNexaBoldWhite.copyWith(
                          color: Color(0XFFfd992a), fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccation_nanny/constants.dart';
import 'package:vaccation_nanny/screens/family_details_screen.dart';
import 'package:vaccation_nanny/ui_modules/rounded_rectangle_button.dart';
// import 'package:vaccation_nanny/screens/nanny_details_screen.dart';
import 'package:vaccation_nanny/screens/map_screen.dart';

class ActiveJobShowScreen extends StatefulWidget {
  static const id = 'activejobshowscreenscreen';
  final requestData;
  final familyData;
  ActiveJobShowScreen({@required this.requestData, @required this.familyData});

  @override
  _ActiveJobShowScreenState createState() => _ActiveJobShowScreenState();
}

class _ActiveJobShowScreenState extends State<ActiveJobShowScreen> {
  String parentFirstName = "Sophia";
  String parentLastName = "Turner";
  String parentLocationName = "LA, California";
  var latitude;
  var longitude;
  String locationName;
  double weightOfChild = 0;
  double avgDailyHours = 0;
  double ageOfChild = 0;
  String startingDayValue = "3 May";
  String endingDayValue = "5 May";

  @override
  Widget build(BuildContext context) {
    showASnackBar(BuildContext context, String message) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text('ACTIVE JOB INFO'),
          backgroundColor: Color(0XFFfd992a),
          automaticallyImplyLeading: false,
        ),
        body: PostedJobInfoForm(
          startingDayValue: startingDayValue,
          endingDayValue: endingDayValue,
          parentFirstName: parentFirstName,
          parentLastName: parentLastName,
          parentLocationName: parentLocationName,
          requestData: widget.requestData,
          familyData: widget.familyData,
        ));
  }
}

class PostedJobInfoForm extends StatelessWidget {
  const PostedJobInfoForm(
      {@required this.startingDayValue,
      @required this.endingDayValue,
      @required this.parentFirstName,
      @required this.parentLastName,
      @required this.parentLocationName,
      @required this.requestData,
      @required this.familyData});

  final String startingDayValue;
  final String endingDayValue;
  final String parentFirstName;
  final String parentLastName;
  final String parentLocationName;
  final requestData;
  final familyData;

  @override
  Widget build(BuildContext context) {
    Widget makeAgeWeightWidget() {
      String childrenString = '';
      for (var child = 0; child < requestData['ageOfChild'].length; child++) {
        childrenString = childrenString +
            requestData['ageOfChild'][child].toString() +
            ' years ' +
            requestData['weightOfChild'][child].toString() +
            'lb, ';
      }
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${requestData['ageOfChild'].length} children: $childrenString',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: GestureDetector(
                      onTap: () {
                        // getIdImage();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(25, 5, 25, 5),
                            decoration: BoxDecoration(
                              color: Color(0XFFF5F5F5),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              // border: Border.all(
                              //     color: Color(0XFFfd992a), width: 1),
                            ),
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                  child: Text("ASSIGNED BY:",
                                      style: kNexaBoldWhite.copyWith(
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                          fontSize: 15)),
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(10, 5, 10, 10),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      FamilyDetailsScreen(
                                                        familyData: familyData,
                                                      )));
                                        },
                                        child: Container(
                                          width: 100,
                                          height: 100,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(familyData[
                                                  'profileImageUrl']),
                                            ),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 5, 10, 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            familyData['firstName'] +
                                                ' ' +
                                                familyData['lastName'],
                                            style: kNexaBoldWhite.copyWith(
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black),
                                          ),
                                          Text(
                                            "Family",
                                            style: kNexaBoldWhite.copyWith(
                                                fontWeight: FontWeight.normal,
                                                fontSize: 16,
                                                color: Color(0XFF3CB371)),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              IconButton(
                                                icon: FaIcon(
                                                    FontAwesomeIcons.map),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          MapScreen(
                                                        requestData:
                                                            requestData,
                                                      ),
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: requestData['requestImageUrl'] != null
                                    ? NetworkImage(
                                        requestData['requestImageUrl'])
                                    : AssetImage('images/requestclipart.png'),
                                //  _idImage != null
                                //     ? FileImage(_idImage)
                                //     : NetworkImage(idImageUrl)
                              ),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            requestData['title'],
                            style: kNexaBoldWhite.copyWith(
                                color: Color(0XFF6A6A6A), fontSize: 18),
                          ),
                          Text(
                            "\$ ${requestData['budget']}",
                            style: kNexaBoldWhite.copyWith(
                                color: Colors.green, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  HeadingAndTextInputBox(
                      heading: "Address:", textValue: requestData['address']),
                  makeAgeWeightWidget(),
                  HeadingAndTextInputBox(
                    heading: "Special Instructions:",
                    textValue: requestData['specialInstructions'],
                    minLines: 3,
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 25, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Text("Timeline of the job:"),
                          SizedBox(
                            height: 10,
                          ),
                          TimeLineDay(requestData: requestData),
                        ],
                      )),

                  // OpenerButton(
                  //   icon: FontAwesomeIcons.comment,
                  //   text: "Send a message",
                  // ),
                  OpenerButton(
                    icon: FontAwesomeIcons.map,
                    text: "Track location on map",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MapScreen(
                            requestData: requestData,
                          ),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 16),
                    child: RoundedNavigationButton(
                      title: 'Request completion',
                      color: Color(0XFFfd992a),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class TimeLineDay extends StatelessWidget {
  const TimeLineDay({
    @required this.requestData,
  });
  final requestData;

  @override
  Widget build(BuildContext context) {
    List<Widget> rows = [];
    for (int i = 0; i < requestData['selectDays'].length; i++) {
      if (requestData['selectDays'][i] != null) {
        var thisRow = Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller:
                      TextEditingController(text: requestData['selectDays'][i]),
                  readOnly: true,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {},
                  decoration: kInputDecoration,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text("-"),
              ),
              Expanded(
                child: TextField(
                  controller: TextEditingController(
                      text: (requestData['selectInitialHour'][i] == 12
                              ? '12pm'
                              : requestData['selectInitialHour'][i] == 24
                                  ? '12am'
                                  : requestData['selectInitialHour'][i] == 0
                                      ? '12am'
                                      : requestData['selectInitialHour'][i] <= 11
                                          ? requestData['selectInitialHour'][i]
                                                  .toString() +
                                              'am'
                                          : (requestData['selectInitialHour']
                                                          [i] -
                                                      12)
                                                  .toString() +
                                              'pm') +
                          "-" +
                          (requestData['selectFinalHour'][i] == 12
                              ? '12pm'
                              : requestData['selectFinalHour'][i] == 24
                                  ? '12am'
                                  : requestData['selectFinalHour'][i] == 0
                                      ? '12am'
                                      : requestData['selectFinalHour'][i] <= 11
                                          ? requestData['selectFinalHour'][i].toString() + 'am'
                                          : (requestData['selectFinalHour'][i] - 12).toString() + 'pm')),
                  readOnly: true,
                  style: TextStyle(color: Colors.black),
                  onChanged: (value) {},
                  decoration: kInputDecoration,
                ),
              ),
            ],
          ),
        );
        rows.add(thisRow);
      }
    }
    return Column(
      children: rows,
    );
  }
}

class OpenerButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onPressed;
  const OpenerButton(
      {@required this.icon, @required this.text, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: EdgeInsets.fromLTRB(25, 15, 25, 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Color(0XFFfd992a), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: FaIcon(icon),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text,
                  style: kNexaBoldWhite.copyWith(
                      color: Color(0XFF6A6A6A), fontSize: 17)),
            ),
          ],
        ),
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
                  decoration: kInputDecoration.copyWith(hintText: ''),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class HeadingAndCustomWidgetBox extends StatelessWidget {
  final String heading;
  final Widget passedCustomWidget;
  final String passedCustomText;
  const HeadingAndCustomWidgetBox(
      {@required this.heading, this.passedCustomWidget, this.passedCustomText});

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
              Expanded(child: passedCustomWidget),
              Text(passedCustomText),
            ],
          ),
        ],
      ),
    );
  }
}

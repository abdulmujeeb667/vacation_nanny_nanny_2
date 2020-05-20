import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:vaccation_nanny/constants.dart';
import 'package:vaccation_nanny/ui_modules/universal_bottom_bar.dart';
import 'package:vaccation_nanny/ui_modules/bottom_sheet_calendar.dart';
import 'package:vaccation_nanny/fire_store_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class CalendarScreen extends StatelessWidget {
  static const id = "calendarscreen";
  var now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MY CALENDAR'),
        backgroundColor: Color(0XFFfd992a),
        automaticallyImplyLeading: false,
      ),
      bottomNavigationBar: UniversalBottomBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 90, 0, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 0)).day,
                            month: now.add(Duration(days: 0)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 1)).day,
                            month: now.add(Duration(days: 1)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 2)).day,
                            month: now.add(Duration(days: 2)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 3)).day,
                            month: now.add(Duration(days: 3)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 4)).day,
                            month: now.add(Duration(days: 4)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 5)).day,
                            month: now.add(Duration(days: 5)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 6)).day,
                            month: now.add(Duration(days: 6)).month,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 7)).day,
                            month: now.add(Duration(days: 7)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 8)).day,
                            month: now.add(Duration(days: 8)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 9)).day,
                            month: now.add(Duration(days: 9)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 10)).day,
                            month: now.add(Duration(days: 10)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 11)).day,
                            month: now.add(Duration(days: 11)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 12)).day,
                            month: now.add(Duration(days: 12)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 13)).day,
                            month: now.add(Duration(days: 13)).month,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 14)).day,
                            month: now.add(Duration(days: 14)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 15)).day,
                            month: now.add(Duration(days: 15)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 16)).day,
                            month: now.add(Duration(days: 16)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 17)).day,
                            month: now.add(Duration(days: 17)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 18)).day,
                            month: now.add(Duration(days: 18)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 19)).day,
                            month: now.add(Duration(days: 19)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 20)).day,
                            month: now.add(Duration(days: 20)).month,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 21)).day,
                            month: now.add(Duration(days: 21)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 22)).day,
                            month: now.add(Duration(days: 22)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 23)).day,
                            month: now.add(Duration(days: 23)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 24)).day,
                            month: now.add(Duration(days: 24)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 25)).day,
                            month: now.add(Duration(days: 25)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 26)).day,
                            month: now.add(Duration(days: 26)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 27)).day,
                            month: now.add(Duration(days: 27)).month,
                          ),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 28)).day,
                            month: now.add(Duration(days: 28)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[300],
                            day: now.add(Duration(days: 29)).day,
                            month: now.add(Duration(days: 29)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[400],
                            day: now.add(Duration(days: 30)).day,
                            month: now.add(Duration(days: 30)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[400],
                            day: now.add(Duration(days: 31)).day,
                            month: now.add(Duration(days: 31)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[400],
                            day: now.add(Duration(days: 32)).day,
                            month: now.add(Duration(days: 32)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[400],
                            day: now.add(Duration(days: 33)).day,
                            month: now.add(Duration(days: 33)).month,
                          ),
                          CalendarDay(
                            color: Colors.grey[400],
                            day: now.add(Duration(days: 34)).day,
                            month: now.add(Duration(days: 34)).month,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CalendarDay extends StatefulWidget {
  final Color color;
  final day;
  final month;

  CalendarDay({@required this.color, @required this.day, @required this.month});

  @override
  _CalendarDayState createState() => _CalendarDayState();
}

class _CalendarDayState extends State<CalendarDay> {
  final _auth = FirebaseAuth.instance;
  var loggedInUser;
  var data;
  var fireStoreDayTiming;
  bool loaded = false;

  getUser() async {
    loggedInUser = await _auth.currentUser();
    data = await FireStoreDatabase(uid: loggedInUser.uid).fetchUserData();
    // print(data[widget.day.toString() + stringMonths[widget.month - 1]]);
    setState(() {
      fireStoreDayTiming =
          data[widget.day.toString() + stringMonths[widget.month - 1]];
      loaded = true;
    });
    // print(fireStoreDay);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  final List<String> stringMonths = [
    'Jan',
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Visibility(
        visible: loaded,
        child: Padding(
          padding: EdgeInsets.fromLTRB(0.5, 4, 0.5, 4),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => DialogSheet(
                  day: widget.day.toString() + stringMonths[widget.month - 1],
                ),
              ).then((value) async {
                data = await FireStoreDatabase(uid: loggedInUser.uid)
                    .fetchUserData();
                setState(() {
                  fireStoreDayTiming = data[
                      widget.day.toString() + stringMonths[widget.month - 1]];
                  loaded = true;
                });
              });
            },
            child: Container(
              height: 60,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.day.toString(),
                    style: kCalendarDayTextStyle,
                  ),
                  SizedBox(
                    height: 0.5,
                  ),
                  Text(
                    stringMonths[widget.month - 1],
                    style: kCalendarDayTextStyle,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    fireStoreDayTiming ?? 'not available',
                    style: kCalendarDayTextStyle.copyWith(
                        fontSize: 7,
                        color: fireStoreDayTiming == null
                            ? Colors.red
                            : Colors.green),
                  ),
                ],
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: widget.color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

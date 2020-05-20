import 'package:flutter/material.dart';
import 'package:vaccation_nanny/fire_store_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DialogSheet extends StatefulWidget {
  DialogSheet({this.day});
  final String day;

  @override
  _DialogSheetState createState() => _DialogSheetState();
}

class _DialogSheetState extends State<DialogSheet> {
  final _auth = FirebaseAuth.instance;

  bool available = true;
  RangeValues selectedRange = RangeValues(0, 24);
  RangeLabels labels = RangeLabels('0', '24');
  var startConverted = "12am";
  var endConverted = "12am";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.day),
      content: Container(
        height: 140,
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Checkbox(
                  value: available,
                  onChanged: (value) {
                    setState(() {
                      available = value;
                    });
                  },
                ),
                Text('Available'),
              ],
            ),
            Visibility(
              visible: available,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: RangeSlider(
                      values: selectedRange,
                      labels: labels,
                      divisions: 25,
                      onChanged: (values) {
                        setState(() {
                          selectedRange = RangeValues(values.start, values.end);
                          var start = selectedRange.start.toInt();
                          var end = selectedRange.end.toInt();
                          startConverted = start == 12
                              ? '12pm'
                              : start == 24
                                  ? '12am'
                                  : start == 0
                                      ? '12am'
                                      : start <= 11
                                          ? start.toString() + 'am'
                                          : (start - 12).toString() + 'pm';
                          endConverted = end == 12
                              ? '12pm'
                              : end == 24
                                  ? '12am'
                                  : end == 0
                                      ? '12am'
                                      : end <= 11
                                          ? end.toString() + 'am'
                                          : (end - 12).toString() + 'pm';
                          labels = RangeLabels(startConverted, endConverted);
                        });
                      },
                      min: 0,
                      max: 24,
                    ),
                  ),
                  Text("available from $startConverted to $endConverted"),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        MaterialButton(
          onPressed: () async {
            var loggedInUser = await _auth.currentUser();
            FireStoreDatabase(uid: loggedInUser.uid).addCalendarData(
                day: widget.day,
                startingHour: startConverted,
                endingHour: endConverted,
                availability: available);
            Navigator.pop(context);
          },
          child: Text('Submit'),
        ),
      ],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:vaccation_nanny/constants.dart';
import 'package:vaccation_nanny/fire_store_database.dart';
import 'package:vaccation_nanny/screens/requests_screen.dart';
import 'package:vaccation_nanny/ui_modules/rounded_rectangle_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RequestInfoScreen extends StatefulWidget {
  static const id = 'requestinfoscreen';
  final requestData;
  final bidPresenceText;
  RequestInfoScreen(
      {@required this.requestData, @required this.bidPresenceText});

  @override
  _RequestInfoScreenState createState() => _RequestInfoScreenState();
}

class _RequestInfoScreenState extends State<RequestInfoScreen> {
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
          title: Text('REQUEST INFO'),
          backgroundColor: Color(0XFFfd992a),
          automaticallyImplyLeading: false,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: PostedJobInfoForm(
                  startingDayValue: startingDayValue,
                  endingDayValue: endingDayValue,
                  requestData: widget.requestData,
                  bidPresenceText: widget.bidPresenceText),
            ),
          ],
        ));
  }
}

class PostedJobInfoForm extends StatefulWidget {
  const PostedJobInfoForm(
      {@required this.startingDayValue,
      @required this.endingDayValue,
      @required this.requestData,
      @required this.bidPresenceText});

  final String startingDayValue;
  final String endingDayValue;
  final String bidPresenceText;
  final requestData;

  @override
  _PostedJobInfoFormState createState() => _PostedJobInfoFormState();
}

class _PostedJobInfoFormState extends State<PostedJobInfoForm> {
  int bidAmount;
  bool spinner = false;

  @override
  Widget build(BuildContext context) {
    Widget makeAgeWeightWidget() {
      String childrenString = '';
      for (var child = 0;
          child < widget.requestData['ageOfChild'].length;
          child++) {
        childrenString = childrenString +
            widget.requestData['ageOfChild'][child].toString() +
            ' years ' +
            widget.requestData['weightOfChild'][child].toString() +
            'lb, ';
      }
      return Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              '${widget.requestData['ageOfChild'].length} children: $childrenString',
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      );
    }

    return ModalProgressHUD(
      inAsyncCall: spinner,
      child: ListView(
        children: <Widget>[
          widget.bidPresenceText.length == 0
              ? BidPlaceTemplate(
                  onPressed: () async {
                    setState(() {
                      spinner = true;
                    });
                    var _auth = FirebaseAuth.instance;
                    var loggedInUser = await _auth.currentUser();
                    print(widget.requestData.documentID);
                    await FireStoreDatabase(uid: loggedInUser.uid).placeBid(
                        requestID: widget.requestData.documentID,
                        bidAmount: bidAmount);
                    setState(() {
                      spinner = false;
                    });
                    Navigator.pushNamed(context, RequestsScreen.id);
                  },
                  onTextChanged: (value) {
                    bidAmount = int.parse(value);
                  },
                )
              : Container(
                  margin: EdgeInsets.fromLTRB(25, 10, 25, 5),
                  decoration: BoxDecoration(
                    color: Color(0XFFF5F5F5),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text(widget.bidPresenceText)),
                  ),
                ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: widget.requestData['requestImageUrl'] != null
                              ? NetworkImage(
                                  widget.requestData['requestImageUrl'])
                              : AssetImage('images/requestclipart.png'),
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      widget.requestData['title'],
                      style: kNexaBoldWhite.copyWith(
                          color: Color(0XFF6A6A6A), fontSize: 18),
                    ),
                  ],
                ),
              ),
              HeadingAndTextInputBox(
                  heading: "Address:",
                  textValue: widget.requestData['address']),
              makeAgeWeightWidget(),
              HeadingAndTextInputBox(
                heading: "Special Instructions:",
                textValue: widget.requestData['specialInstructions'],
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
                      TimeLineDay(requestData: widget.requestData),
                    ],
                  )),
              HeadingAndTextInputBox(
                heading: "Fee:",
                textValue: widget.requestData['budget'] + " USD",
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ],
      ),
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

class BidPlaceTemplate extends StatefulWidget {
  final Function onPressed;
  final onTextChanged;
  BidPlaceTemplate({@required this.onPressed, @required this.onTextChanged});

  @override
  _BidPlaceTemplateState createState() => _BidPlaceTemplateState();
}

class _BidPlaceTemplateState extends State<BidPlaceTemplate> {
  bool agreement = false;
  @override
  Widget build(BuildContext context) {
    showASnackBar(BuildContext context, String message) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
    }
    return Container(
      margin: EdgeInsets.fromLTRB(25, 10, 25, 5),
      decoration: BoxDecoration(
        color: Color(0XFFF5F5F5),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        // border: Border.all(color: Color(0XFFfd992a), width: 2),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Place a bid?",
              style: kNexaBoldWhite.copyWith(
                  color: Color(0XFF6A6A6A), fontSize: 16),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(65, 0, 65, 0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: kInputDecoration.copyWith(hintText: "USD"),
                onChanged: widget.onTextChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(15, 20, 25, 0),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    value: agreement,
                    activeColor: Color(0XFFfd992a),
                    onChanged: (value) {
                      setState(() {
                        agreement = value;
                      });
                    },
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Fee schedule & breakdown'),
                            content: Text(
                                'For 1 child: \$24.00 per hour\nFor 2 children: \$26.00 per hour\nFor 3 children: \$28.00 per hour\nFor 4 children: \$30.00 per hour\nFor 5 children \$32.00 per hour\nFor 6 children \$34.00 per hour\nHours between midnight and 8am: +\$5.00 per hour\nHours in excess of 8 total hours: +\$10.00 per hour\nTime & Half Rate: Easter Day, Memorial Day, Mother\'s Day, Father\'s Day, 4th of July, and Labor Day.\nDouble Time Rate: Thanksgiving, Christmas Eve, Christmas Day, New Year\'s Eve, New Year\'s Day to Jan. 2 until 6 a.m.\n**All sits will be charged at least a three-hour minimum.\n**Nanny can place a bid of more than or less than the calculated fee'),
                          ),
                        );
                      },
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: 'I have read and I agree to the',
                            style: TextStyle(fontSize: 15, color: Colors.black),
                          ),
                          TextSpan(
                            text: ' fee schedule & breakdown',
                            style: TextStyle(fontSize: 15, color: Colors.blue),
                          ),
                        ]),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0XFFfd992a),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(55, 10, 55, 8),
                  child: Text(
                    'Place Bid',
                    style: kNexaBoldWhite.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              onPressed: (){
                if(agreement == false){
                  showASnackBar(context, "Please accept the terms");
                }else{
                widget.onPressed();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

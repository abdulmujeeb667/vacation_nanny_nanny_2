import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:vaccation_nanny/screens/active_work_screen.dart';
import 'package:vaccation_nanny/screens/calendar_screen.dart';
import 'package:vaccation_nanny/screens/dashboard_screen.dart';
import 'package:vaccation_nanny/screens/requests_screen.dart';

class UniversalBottomBar extends StatelessWidget {
  const UniversalBottomBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0XFFfd992a),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          IconButton(
            icon: FaIcon(FontAwesomeIcons.briefcase),
            onPressed: () {
              Navigator.pushReplacementNamed(context, ActiveWorkScreen.id);
            },
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.listAlt),
            onPressed: () {
              Navigator.pushReplacementNamed(context, RequestsScreen.id);
            },
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.calendarAlt),
            onPressed: () {
              Navigator.pushReplacementNamed(context, CalendarScreen.id);
            },
          ),
          IconButton(
            icon: FaIcon(FontAwesomeIcons.cog),
            onPressed: () {
              Navigator.pushReplacementNamed(context, DashboardScreen.id);
            },
          ),
        ],
      ),
    );
  }
}

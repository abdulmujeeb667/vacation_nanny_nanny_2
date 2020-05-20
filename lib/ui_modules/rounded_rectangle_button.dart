import 'package:flutter/material.dart';

class RoundedNavigationButton extends StatelessWidget {
  final Color color;
  final String title;
  final Function onPressed;
  RoundedNavigationButton(
      {@required this.color, @required this.title, @required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5.0,
      color: color,
      borderRadius: BorderRadius.circular(15.0),
      child: MaterialButton(
        onPressed: onPressed,
        minWidth: 200.0,
        height: 42.0,
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

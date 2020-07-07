import 'package:flutter/material.dart';
import 'dart:math' as math;

class MSBottomNavigationWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double selectedFontSize = 14.0;

    // Labels apply up to _bottomMargin padding. Remainder is media padding.
    final double additionalBottomPadding = math.max(
        MediaQuery.of(context).padding.bottom - selectedFontSize / 2.0, 0.0);

    return Container(
        decoration: BoxDecoration(
            color: Color(0xFFFFFFFF),
            border: Border.all(color: Color(0xFFF3F3F3), width: 1),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(22), topLeft: Radius.circular(22))),
        height: kBottomNavigationBarHeight + additionalBottomPadding,
        padding: EdgeInsets.only(bottom: additionalBottomPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            SizedBox(
              width: 20,
              height: 80,
              child: Icon(Icons.check, color: Colors.red),
            ),
            SizedBox(
              width: 20,
              height: 80,
              child: Icon(Icons.check, color: Colors.green),
            ),
            SizedBox(width: 20),
            SizedBox(
              width: 20,
              height: 80,
              child: Icon(Icons.check, color: Colors.green),
            ),
            SizedBox(
              width: 20,
              height: 80,
              child: Icon(Icons.check, color: Colors.green),
            ),
          ],
        ));
  }
}

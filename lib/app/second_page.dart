import 'package:flutter/material.dart';

import 'app_localization.dart';

class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("SecondPage"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalization.of(context).localize("title"),
              style: TextStyle(fontSize: 30, color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}

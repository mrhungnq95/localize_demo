import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:localize_demo/app/app_localization.dart';
import 'package:localize_demo/app/second_page.dart';
import 'package:localize_demo/model/base_output.dart';
import 'package:localize_demo/model/revenue_data.dart';
import 'package:provider/provider.dart';

import 'model/inventory_item.dart';
import 'ms_bottom_navigation_widget.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => AppProvider(),
      builder: (context, child) => MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("MyApp");
    return MyHomePage(
      title: "AppLocalization",
    );
  }
}

class AppProvider extends ChangeNotifier {
  Locale _locale = Locale("vi", "VN");
  int _currentPageIndex = 0;
  int get currentPageIndex => _currentPageIndex;
  set currentPageIndex(value) {
    _currentPageIndex = value;
    notifyListeners();
  }

  Locale get locale => _locale;

  set locale(value) => _locale = _locale;

  void setupLocale(Locale locale) {
    this._locale = locale;
    notifyListeners();
  }

  Future<Map<String, Map<String, String>>> loadData() async {
    String contentJson = await rootBundle.loadString("assets/raw/data.json");

    return compute(parseData, contentJson);
  }

  Future<Map<String, Map<String, String>>> loadData2() async {
    String contentJson = await rootBundle.loadString("assets/raw/data2.json");
    return compute(parseData2, contentJson);
  }
}

Map<String, Map<String, String>> parseData(String contentJson) {
  //print(contentJson);
  Map<String, dynamic> json = jsonDecode(contentJson);

  print("Map<String, dynamic>: $json");

  var data = BaseOutput<RevenueData>.fromJson(json, (v) {
    print("RevenueData: $v");
    return RevenueData.fromJson(v);
  });

  print(data);

  print(data.data[0].inventoryItemList[1].inventoryItemName);
  print(data.data[0].customerList[1].name);
  return null;
}

Map<String, Map<String, String>> parseData2(String contentJson) {
  Map<String, dynamic> json = jsonDecode(contentJson);
  var data = BaseOutput<InventoryItem>.fromJson(json, (v) {
    return InventoryItem.fromJson(v);
  });
  print(data);
  return null;
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    // if (_locale == null) {
    //   _locale = Localizations.localeOf(context);
    // }

    return Consumer<AppProvider>(builder: (context, model, child) {
      return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        localizationsDelegates: [
          //Customize localization from json file
          AppLocalization.delegate,
          //Material widget
          GlobalMaterialLocalizations.delegate,
          //Left to Right widget
          GlobalWidgetsLocalizations.delegate
        ],
        locale: model.locale,
        supportedLocales: AppLocalization.supportedLocales,
        home: ContentMainPage(
          title: widget.title,
        ),
      );
    });
  }
}

// This is the type used by the popup menu below.
enum LanguageEnum { vietnamese, english, germany }

class ContentMainPage extends StatelessWidget {
  final String title;

  ContentMainPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(title),
        actions: <Widget>[
          PopupMenuButton<Locale>(
            icon: Icon(Icons.language),
            onSelected: (Locale result) {
              Provider.of<AppProvider>(context, listen: false)
                  .setupLocale(result);
            },
            itemBuilder: (BuildContext context) =>
                AppLocalization.supportedLocales
                    .map((e) => PopupMenuItem<Locale>(
                          value: e,
                          child: Text(e.toLanguageTag()),
                        ))
                    .toList(),
          )
        ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalization.of(context).localize("title"),
              style: TextStyle(fontSize: 30),
            ),
            RaisedButton(
              onPressed: () {
                Provider.of<AppProvider>(context, listen: false).loadData2();
                //Navigator.push(
                //    context, MaterialPageRoute(builder: (_) => SecondPage()));
              },
              child: Text(AppLocalization.of(context).localize("continue")),
            )
          ],
        ),
      ) // This trailing comma makes auto-formatting nicer for build methods.
      ,
      floatingActionButton: Container(
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Color(0x8C5663FF), blurRadius: 25, offset: Offset(0, 10))
          ],
          shape: BoxShape.circle,
        ),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF5663FF),
          splashColor: Color(0xFF5663FF),
          onPressed: () => print("object"),
          elevation: 0,
          highlightElevation: 0,
          hoverElevation: 0,
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: MSBottomNavigationWidget(),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return Consumer<AppProvider>(
      builder: (context, model, child) {
        return BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.check,
                  color: model.currentPageIndex == 0
                      ? Colors.green
                      : Colors.black54,
                ),
                title: Visibility(
                  child: Text("Cửa hàng"),
                  visible: false,
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.check,
                  color: model.currentPageIndex == 1
                      ? Colors.green
                      : Colors.black54,
                ),
                title: Visibility(
                  child: Text("Cửa hàng"),
                  visible: false,
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.check,
                  color: model.currentPageIndex == 2
                      ? Colors.green
                      : Colors.black54,
                ),
                title: Visibility(
                  child: Text("Cửa hàng"),
                  visible: false,
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.check,
                  color: model.currentPageIndex == 3
                      ? Colors.green
                      : Colors.black54,
                ),
                title: Visibility(
                  child: Text("Cửa hàng"),
                  visible: false,
                )),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: model.currentPageIndex,
          showSelectedLabels: true,
          onTap: (value) {
            model.currentPageIndex = value;
          },
          showUnselectedLabels: true,
          backgroundColor: Colors.white,
          iconSize: 35,
          selectedItemColor: Colors.green,
          unselectedItemColor: Colors.black54,
          selectedLabelStyle:
              Theme.of(context).textTheme.display1.copyWith(fontSize: 11),
          unselectedLabelStyle:
              Theme.of(context).textTheme.display1.copyWith(fontSize: 11),
        );
      },
    );
  }
}

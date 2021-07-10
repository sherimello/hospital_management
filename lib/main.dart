import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/patient_entry.dart';
import 'package:flutter_projects/row1.dart';
import 'package:flutter_projects/set_test.dart';
import 'package:flutter_projects/set_type_name.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as cnv;
import 'classes/MyService.dart';
import 'classes/Services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'classes/TypeNameModelForDataFetching.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital Management System',
      debugShowCheckedModeBanner: false,
      color: Colors.black,
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
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  MyService _myService = MyService();
  final myController = TextEditingController();
  int _myVariable = 0;

  Future<void> getmyVariable() async {
    final prefs = await SharedPreferences.getInstance();
    int myInt = prefs.getInt('myVariable') ?? 0;
    setState(() {
      _myVariable = myInt;
    });
    if(myInt == 1){
      setState(() {
        _selectedLocation = "Type name";
      });
        return;
    }
    if(myInt == 2){
      setState(() {
        _selectedLocation = "Test";
      });

    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmyVariable();

    // if (_selectedLocation == "Test") _myService.myVariable = 2;
  }

  @override
  Future<void> dispose() async {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('myVariable', 0);
    super.dispose();
  }

  int count = 0;
  int i;
  bool visibility = false;
  String temp = "";

  @override
  Future<void> setState(fn) async {
    // TODO: implement setState
    super.setState(fn);

    // setState(() {
    //   getmyVariable();
    // });

    setState(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      // int myInt = prefs.getInt('myVariable') ?? 0;
      if (prefs.getInt('myVariable') ?? 0 == 1) {
        setState(() {
          _selectedLocation = "Type name";
        });

      }
    });


    // if(temp != "" && _selectedLocation != temp){
    //   getmyVariable();
    // }

    if (_selectedLocation == "Type name") {
      final prefs = await SharedPreferences.getInstance();

      // setState(() {
        prefs.setInt('myVariable', 1);
      // });

      // getmyVariable();
    }
    setState(() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getInt('myVariable') ?? 0 == 2) {
      setState(() {
        _selectedLocation = "Test";
      });

    }});

    if (_selectedLocation == "Test") {
      final prefs = await SharedPreferences.getInstance();
      // setState(() {
        prefs.setInt('myVariable', 2);
      // });

      // getmyVariable();
    }
    //
    // final prefs = await SharedPreferences.getInstance();
    // final myInt = prefs.getInt('myVariable') ?? 0;
    // if (myInt == 1)
    //   setState(() {
    //     _selectedLocation = "Type name";
    //   });
    // if (myInt == 2)
    //   setState(() {
    //     _selectedLocation = "Test";
    //   });
    // setState(() async {
    //   if (_selectedLocation == "Type name") {
    //     _myService.myVariable() = 1;
    //     final prefs = await SharedPreferences.getInstance();
    //     prefs.setInt('myVariable', _myService.myVariable);
    //   }
    //   if (_selectedLocation == "Test") {
    //     _myService.myVariable = 2;
    //     final prefs = await SharedPreferences.getInstance();
    //     prefs.setInt('myVariable', _myService.myVariable);
    //   }
    // });

    if (i == set_type_name().model.length - 1) {
      visibility = false;
      myController.clear();
    }
  }

  void _increament() async {
    // Services services = new Services();
    Services.addTypeName(myController.text);

    setState(() {
      // visibility = true;
      // getData();
      count++;
    });
  }

  static const ROOT_FOR_GETTING_TYPE_NAME =
      'http://localhost/second/api/typename/read.php';

  // List<TypeNameModelForDataFetching> model;
  List<String> _locations = ['Type name', 'Test']; // Option 2
  List<String> _locations2 = ['Entry', 'Payment']; // Option 2
  String _selectedLocation;
  String _selectedLocation2;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: InkWell(
                onTap: () {},
                child: Row(mainAxisSize: MainAxisSize.min, children: [
                  Icon(
                    Icons.logout,
                    size: 11,
                    color: Colors.white,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 3.0),
                    child: Text("logout",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            color: Colors.white,
                            decoration: TextDecoration.none)),
                  )
                ])),
          ),
          bottom: TabBar(labelColor: Colors.white, tabs: [
            Tab(
              text: "Setup",
            ),
            Tab(
              text: "Test Request",
            ),
            Tab(
              text: "Report",
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Please choose an action:'),
                  ),
                  DropdownButton(
                    hint: Text('Setup'), // Not necessary for Option 1
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                    },
                    items: _locations.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                  if (_selectedLocation == "Type name") set_type_name(),
                  if (_selectedLocation == "Test") set_test(),
                ],
              ),
            ),
            Container(
              color: Colors.black12,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Please choose an action:'),
                    ),
                    DropdownButton(
                      hint: Text('Test Request'), // Not necessary for Option 1
                      value: _selectedLocation2,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedLocation2 = newValue;
                        });
                      },
                      items: _locations2.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                    if (_selectedLocation2 == "Entry") patient_entry(),
                    if (_selectedLocation2 == "Payment") set_test(),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }
}

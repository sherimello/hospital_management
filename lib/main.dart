import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/row1.dart';
import 'package:flutter_projects/set_test.dart';
import 'package:flutter_projects/set_type_name.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as cnv;
import 'classes/Services.dart';
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
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  int count = 0;
  int i;
  bool visibility = false;

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
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
  String _selectedLocation;

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
              text: "first",
            ),
            Tab(
              text: "second",
            ),
            Tab(
              text: "third",
            ),
          ]),
        ),
        body: TabBarView(
          children: [
            Column(
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
            Container(
              color: Colors.black12,
            ),
            Container(
              color: Colors.black26,
            ),
          ],
        ),
      ),
    );
  }

// void getData() async {
//   try {
//     http.Response response = await http.get(ROOT_FOR_GETTING_TYPE_NAME);
//     if (response.statusCode == 200) {
//       print(response.body);
//       List<dynamic> body = cnv.jsonDecode(response.body)['data'];
//       // List<TypeNameModelForDataFetching> model1;
//       model = body
//           .map((dynamic item) => TypeNameModelForDataFetching.fromJson(
//               cnv.json.decode(response.body)))
//           .toList();
//       setState(() {});
//     }
//   } catch (e) {
//     print(e.toString());
//   }
// }
}

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//             InkWell(
//             onTap: () {},
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.logout,
//                 size: 15,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 3.0),
//                 child: Text("logout",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 13,
//                         color: Colors.black,
//                         decoration: TextDecoration.none)),
//               )
//             ],
//           ),
//         ),
//       ),
//       DefaultTabController(
//         length: 3,
//         child: Scaffold(
//           appBar: AppBar(
//             bottom: TabBar(tabs: [
//               Tab(
//                 text: "first",
//               ),
//               Tab(
//                 text: "second",
//               ),
//               Tab(
//                 text: "third",
//               ),
//             ]),
//           ),
//           body: TabBarView(
//         children: [
//         Container(
//         color: Colors.cyan,
//         ),
//         Container(
//           color: Colors.yellow,
//         ),
//         Container(
//           color: Colors.red,
//         ),
//         ],
//       ),
//     ),
//     )
//     ],
//     ),
//     ),
//     );
//     }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.
//
//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;
//
//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

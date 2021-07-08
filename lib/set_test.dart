import 'package:flutter/material.dart';
import 'package:flutter_projects/row1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as cnv;
import 'classes/Services.dart';
import 'classes/TypeNameModelForDataFetching.dart';
import 'classes/Services.dart';
import 'classes/TypeNameModelForDataFetching.dart';

class set_test extends StatefulWidget {
  @override
  _set_testState createState() => _set_testState();
}

class _set_testState extends State<set_test> {
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();

  static String selectedLocation;

  List<TypeNameModelForDataFetching> model;

  static const ROOT_FOR_GETTING_TYPE_NAME =
      'http://localhost/second/api/typename/read.php';
  List<String> _list = new List();
  int i = 0;
  String temp;

  // @override
  // void setState(fn) {
  //   setState(() {
  //     // list = model;
  //   });
  //   super.setState(fn);
  // }

  void assign_list() {
    setState(() {
      if (model.length > 0) {
        for (int i = 0; i < model.length; i++) {
          _list.add(model[i].data[i].typeName);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    setState(() {});

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    myController3.dispose();
    super.dispose();
  }

  increment() async {
    Services.addTest(myController.text, double.parse(myController2.text),
        selectedLocation);
    setState(() {
      myController.clear();
      myController2.clear();
      selectedLocation="";
    });
  }

  @override
  Widget build(BuildContext context) {
    if (model != null) assign_list();
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Visibility(
            //   visible: visibility,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Center(
            //       child: Text('Loading...'),
            //     ),
            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  hintText: 'Type name...',
                  prefixIcon: Icon(
                    Icons.add_circle_sharp,
                    size: 17,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black26),
                  ),
                  contentPadding: EdgeInsets.all(20),
                ),
                controller: myController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  hintStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  hintText: 'Fee...',
                  prefixIcon: Icon(
                    Icons.add_circle_sharp,
                    size: 17,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black26),
                  ),
                  contentPadding: EdgeInsets.all(20),
                ),
                controller: myController2,
              ),
            ),

            model != null && _list != null
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DropdownButton(
                          hint: Text('Test Type'),
                          // Not necessary for Option 1
                          // value: selectedLocation,
                          onChanged: (newValue) {
                            setState(() {

                              selectedLocation = newValue;
                            });
                          },
                          items: _list.map((loc) {
                            return DropdownMenuItem(
                              child: new Text(loc),
                              value: loc,
                            );
                          }).toList(),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(27, 8, 8, 8),
                          child: Text(selectedLocation != null? " : " + selectedLocation : "",
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                        )
                        ,
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  increment();
                },
                child: Text("save"),
              ),
            ),
            // Table(
            //   columnWidths: {
            //     0: FlexColumnWidth(1),
            //     1: FlexColumnWidth(4),
            //   },
            //   border: TableBorder.all(color: Colors.black),
            //   children: [
            //     TableRow(children: [row("SL"), row("Type Name")]),
            //     for (i = 0; i < model.length; i++)
            //       TableRow(children: [
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(model[i].data[i].sL.toString()),
            //         ),
            //         Padding(
            //           padding: const EdgeInsets.all(8.0),
            //           child: Text(model[i].data[i].typeName.toString()),
            //         ),
            //       ])
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  void getData() async {
    try {
      http.Response response = await http.get(ROOT_FOR_GETTING_TYPE_NAME);
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> body = cnv.jsonDecode(response.body)['data'];
        // List<TypeNameModelForDataFetching> model1;
        model = body
            .map((dynamic item) => TypeNameModelForDataFetching.fromJson(
                cnv.json.decode(response.body)))
            .toList();

        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }
}

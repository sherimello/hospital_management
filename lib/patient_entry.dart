import 'package:flutter/material.dart';
import 'package:flutter_projects/classes/TestFetchingModel.dart';
import 'package:flutter_projects/row1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as cnv;
import 'classes/TypeNameModelForDataFetching.dart';
import 'classes/Services.dart';
import 'package:intl/intl.dart';

class patient_entry extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<patient_entry> {
  final myController = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();
  final myController4 = TextEditingController();

  static String selectedLocation;

  List<TypeNameModelForDataFetching> model;
  List<TestFetchingModel> model1;

  static const ROOT_FOR_GETTING_TYPE_NAME =
      'http://localhost/second/api/typename/read.php';
  static const ROOT_FOR_GETTING_TEST =
      'http://localhost/second/api/typename/read_test.php';
  List<String> _list = new List();
  int i = 0;
  String temp, price = "";

  void assign_list() {
    _list = new List();
    setState(() {
      if (model1.length > 0) {
        for (int i = 0; i < model1.length; i++) {
          _list.add(model1[i].data[i].testName);
        }
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // getData();
    getTestData();
    setState(() {});

    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    myController2.dispose();
    myController3.dispose();
    myController4.dispose();
    // _list = new List();
    assign_list();
    super.dispose();
  }

  increment() async {
    for (int i = 0; i < test.length; i++)
      Services.addTestPatient(
          test[i],
          myController.text,
          myController2.text,
          myController3.text,
          new DateFormat('yyyy-MM-dd').format(new DateTime.now()).toString(),
          fee[i]);
    setState(() {
      myController.clear();
      myController2.clear();
      myController3.clear();
      setState(() {
        test.clear();
        fee.clear();
        selectedLocation = "";
        price = "";
      });

      model1 = null;
      getTestData();
      assign_list();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (model1 != null) assign_list();
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
                enabled: textfields_enable,
                decoration: InputDecoration(
                  hintStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  hintText: 'Patient name...',
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
                enabled: textfields_enable,
                decoration: InputDecoration(
                  hintStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  hintText: 'Date of birth...',
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                enabled: textfields_enable,
                decoration: InputDecoration(
                  hintStyle:
                      TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  hintText: 'Mobile...',
                  prefixIcon: Icon(
                    Icons.add_circle_sharp,
                    size: 17,
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.black26),
                  ),
                  contentPadding: EdgeInsets.all(20),
                ),
                controller: myController3,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: TextField(
            //     decoration: InputDecoration(
            //       hintStyle:
            //       TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            //       hintText: 'Date...',
            //       prefixIcon: Icon(
            //         Icons.add_circle_sharp,
            //         size: 17,
            //       ),
            //       border: OutlineInputBorder(
            //         borderSide: BorderSide(width: 1, color: Colors.black26),
            //       ),
            //       contentPadding: EdgeInsets.all(20),
            //     ),
            //     controller: myController4,
            //   ),
            // ),

            model1 != null && _list != null
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
                              price = model1[_list.indexOf(newValue)]
                                  .data[_list.indexOf(newValue)]
                                  .fee;
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
                          child: Text(
                            selectedLocation != null
                                ? " : " + selectedLocation
                                : "",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Price: BDT. ' + price,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  setState(() {
                    textfields_enable = false;
                    create_list_of_tests();
                  });
                },
                child: Text("save"),
              ),
            ),
            test != null && test.length != 0
                ? Column(
                    children: [
                      Table(
                        columnWidths: {
                          0: FlexColumnWidth(1),
                          1: FlexColumnWidth(3),
                          2: FlexColumnWidth(1),
                        },
                        border: TableBorder.all(color: Colors.black),
                        children: [
                          TableRow(children: [
                            row("SL"),
                            row("Test"),
                            row("Fee"),
                          ]),
                          for (i = 0; i < test.length; i++)
                            TableRow(children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(i.toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(test[i].toString()),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(fee[i].toString()),
                              ),
                            ])
                        ],
                      ),
                      RaisedButton(
                        onPressed: () {
                          increment();
                        },
                        child: Text(
                          'Save',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                : Container(),
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
  //           cnv.json.decode(response.body)))
  //           .toList();
  //
  //       setState(() {});
  //     }
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  void getTestData() async {
    try {
      http.Response response = await http.get(ROOT_FOR_GETTING_TEST);
      if (response.statusCode == 200) {
        print(response.body);
        List<dynamic> body = cnv.jsonDecode(response.body)['data'];
        // List<TypeNameModelForDataFetching> model1;
        model1 = body
            .map((dynamic item) =>
                TestFetchingModel.fromJson(cnv.json.decode(response.body)))
            .toList();

        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  List<String> test = new List();
  List<String> fee = new List();
  bool textfields_enable = true;

  void create_list_of_tests() {
    setState(() {
      test.add(selectedLocation);
      fee.add(price);
    });
    setState(() {
      selectedLocation = "";
      price = "";
    });
  }
}

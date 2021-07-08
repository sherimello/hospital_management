import 'package:flutter/material.dart';
import 'package:flutter_projects/row1.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as cnv;
import 'classes/Services.dart';
import 'classes/TypeNameModelForDataFetching.dart';
import 'classes/Services.dart';
import 'classes/TypeNameModelForDataFetching.dart';

class set_type_name extends StatefulWidget {
  get model => null;

  @override
  _set_type_nameState createState() => _set_type_nameState();

  set_type_name();
}

class _set_type_nameState extends State<set_type_name> {
  List<TypeNameModelForDataFetching> model;
  List<String> _locations = ['A', 'B', 'C', 'D']; // Option 2
  String _selectedLocation;
  static const ROOT_FOR_GETTING_TYPE_NAME =
      'http://localhost/second/api/typename/read.php';

  final myController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState

    getData();
    super.initState();
  }
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
    if (i == model.length - 1) {
      visibility = false;
      myController.clear();
    }
  }

  void _increament() async {
    // Services services = new Services();
    Services.addTypeName(myController.text);

    setState(() {
      visibility = true;
      getData();
      count++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return model == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Container(
              color: Colors.white,
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Visibility(
                    visible: visibility,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text('Loading...'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.bold),
                        hintText: 'Type name...',
                        prefixIcon: Icon(
                          Icons.add_circle_sharp,
                          size: 17,
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: Colors.black26),
                        ),
                        contentPadding: EdgeInsets.all(20),
                      ),
                      controller: myController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RaisedButton(
                      onPressed: () {
                        setState(() {
                          _increament();
                        });
                      },
                      child: Text("increase"),
                    ),
                  ),
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(4),
                    },
                    border: TableBorder.all(color: Colors.black),
                    children: [
                      TableRow(children: [row("SL"), row("Type Name")]),
                      for (i = 0; i < model.length; i++)
                        TableRow(children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(model[i].data[i].sL.toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(model[i].data[i].typeName.toString()),
                          ),
                        ])
                    ],
                  ),
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

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'TypeNameModelForDataFetching.dart';
import 'TypeNameModelForDataInjection.dart';

class Services {
  static const ROOT_FOR_ADDING_TYPE_NAME =
      'http://localhost/second/api/typename/write.php';
  static const ROOT_FOR_ADDING_TEST =
      'http://localhost/second/api/typename/write_test.php';
  static const ROOT_FOR_ADDING_TEST_PATIENT =
      'http://localhost/second/api/patient/write_patient_test.php';
  static const ROOT_FOR_GETTING_TYPE_NAME =
      'http://localhost/second/api/typename/read.php';
  static const ROOT_FOR_GETTING_TESTS =
      'http://localhost/second/api/typename/read_test.php';

  Services();

  static Future<String> addTypeName(String typename) async {
    if (typename.isNotEmpty)
      try {
        var map = Map<String, dynamic>();

        map['type_name'] = typename;
        String body = jsonEncode(map);
        final response = await http.post(ROOT_FOR_ADDING_TYPE_NAME, body: body);

        if (response.statusCode == 200) {
          print(response.body);
          return response.body;
        } else {
          print('error');
          return "error";
        }
      } catch (e) {
        print(e);
        return "error";
      }
  }

  static Future<String> addTest(String testname, double fee, String type) async {
    // if (testname.isNotEmpty && fee!=null && type.isNotEmpty)
      try {
        var map = Map<String, dynamic>();

        map['test_name'] = testname;
        map['fee'] = fee;
        map['type'] = type;
        String body = jsonEncode(map);
        final response = await http.post(ROOT_FOR_ADDING_TEST, body: body);

        if (response.statusCode == 200) {
          print(response.body);
          return response.body;
        } else {
          print('error');
          return "error";
        }
      } catch (e) {
        print(e);
        return "error";
      }
  }

  static Future<String> addTestPatient(String test, String Name, String DOB, String Mobile, String Date, String Fee) async {
    // if (testname.isNotEmpty && fee!=null && type.isNotEmpty)
    try {
      var map = Map<String, dynamic>();

      map['tableForTest'] = test;
      map['Name'] = Name;
      map['DOB'] = DOB;
      map['Mobile'] = Mobile;
      map['Date'] = Date;
      map['Fee'] = Fee;
      String body = jsonEncode(map);
      final response = await http.post(ROOT_FOR_ADDING_TEST_PATIENT, body: body);

      if (response.statusCode == 200) {
        print(response.body);
        return response.body;
      } else {
        print('error');
        return "error";
      }
    } catch (e) {
      print(e);
      return "error";
    }
  }

  static Future<List<TypeNameModelForDataFetching>> getData() async {
    try {
      http.Response response = await http.get(ROOT_FOR_GETTING_TYPE_NAME);
      if(response.statusCode == 200) {
        print(response.body);
        List<dynamic> body = jsonDecode(response.body)['data'];
        List<TypeNameModelForDataFetching> model;
        model = body
            .map((dynamic item) => TypeNameModelForDataFetching.fromJson(
            json.decode(response.body)))
            .toList();

        return model;

      }

    } catch (e) {
      print(e.toString());
    }
  }
}

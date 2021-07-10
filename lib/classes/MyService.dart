import 'package:shared_preferences/shared_preferences.dart';

class MyService {

  static final MyService _instance = MyService._internal();

  // passes the instantiation to the _instance object
  factory MyService() => _instance;

  //initialize variables in here
  MyService._internal() {
    _myVariable = 0;
  }

  int _myVariable;

  //short getter for my variable
  int get myVariable => _myVariable;

  Future<void> getmyVariable() async {
    final prefs = await SharedPreferences.getInstance();
    int myInt = prefs.getInt('myVariable') ?? 0;
    _myVariable = myInt;
  }
  //short setter for my variable
  set myVariable(int value) => myVariable = value;

  void incrementMyVariable() => _myVariable++;
}
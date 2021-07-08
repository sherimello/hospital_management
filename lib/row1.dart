import 'package:flutter/material.dart';

class row extends StatelessWidget {
  String s;
  row(this.s);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(s,
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 11,
              color: Colors.white,
              decoration: TextDecoration.none),),
      ),
    );
  }
}

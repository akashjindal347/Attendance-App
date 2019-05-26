import 'package:flutter/material.dart';

class TeacherUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*0.4,
            color: Colors.red,
          ),

          ListView()
        ],
      ),
    );
  }
}
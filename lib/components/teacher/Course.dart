import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/AppModel.dart';

class Course extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Manager"),
      ),
      body: ScopedModelDescendant<AppModel>(
      builder: (context, child, model) => Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Course Name: ${model.courseName}"),
            Text("Course Code: ${model.courseCode}"),
            Text("Course Token: ${model.courseToken}"),
            Text("Course Strength: ${model.courseStrength}"),
          ],
        ),
      ),
    ));
  }
}
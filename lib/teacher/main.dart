import 'package:flutter/material.dart';
import 'pages/main_page.dart';
import 'package:attendance_app/components/teacher/create_course.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      title: 'Dashboard',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MainPage(),
      routes: {
        '/create': (BuildContext context)=>CreateCourse(),
      },
    );
  }
}
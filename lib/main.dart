import 'package:flutter/material.dart';
import 'pages/ui/att.dart';
import 'pages/ui/login_page.dart';
import 'pages/ui/mark_att.dart';
import 'pages/main_page.dart';

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
      home: LoginPage(),
      routes: {
        '/main':(BuildContext context)=>HomePage(),
        '/mark':(BuildContext context)=>Mark(),
        '/home':(BuildContext context)=>MainPage(),
      },
    );
  }
}

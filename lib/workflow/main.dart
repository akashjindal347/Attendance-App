import 'package:flutter/material.dart';
import 'pages/main_page.dart';
import 'pages/ui/login_page.dart';
import 'pages/ui/mark_att.dart';

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
        '/main':(BuildContext context)=>MainPage(),
        '/mark':(BuildContext context)=>Mark(),
        
      },
    );
  }
}

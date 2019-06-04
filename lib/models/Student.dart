import 'package:flutter/material.dart';

class Student{
 final String name;
 final String id;
 final String email;
 final String password;

 Student(
     @required this.name,
     @required this.id,
     @required this.email,
     @required this.password
 );
}
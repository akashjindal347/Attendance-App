import 'package:flutter/material.dart';

class Teacher{
 final String name;
 final String id;
 final String email;
 final String password;

  Teacher(
    @required this.name,
    @required this.id,
    @required this.email,
    @required this.password
  );
}
import 'package:flutter/material.dart';

class Teacher{
 final String name;
 final String userId;
 final String email;
 final String password;

  Teacher(
    @required this.name,
    @required this.userId,
    @required this.email,
    @required this.password
  );
}
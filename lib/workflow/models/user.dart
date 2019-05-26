import 'package:flutter/material.dart';

class User{
 final String username;
 final String fullname;
 final int standard;
 final String email;
 final String password;
 final int number;
 final int age;

  User(
    @required this.username,
    @required this.fullname,
    @required this.standard,
    @required this.email,
    @required this.password,
    @required this.number,
    @required this.age,

  );
}
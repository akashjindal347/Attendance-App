import 'package:flutter/material.dart';

class Tutor{
 final String username;
 final String fullname;
 final String subject;
 final String email;
 final String password;
 final int number;
 final int age;

  Tutor(
    @required this.username,
    @required this.fullname,
    @required this.subject,
    @required this.email,
    @required this.password,
    @required this.number,
    @required this.age,

  );
}
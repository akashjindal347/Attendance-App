import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPane extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.redAccent,
          ),
          Container(
            width: 300.0,
            height: 190.0,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        FontAwesomeIcons.envelope,
                        color: Colors.black,
                        size: 22.0,
                      ),
                      hintText: "Email Address",
                      hintStyle: TextStyle(
                          fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                    ),
                  ),
                ),
                Container(
                  width: 250.0,
                  height: 1.0,
                  color: Colors.grey[400],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                  child: TextField(
//                    focusNode: myFocusNodePasswordLogin,
//                    controller: loginPasswordController,
//                    obscureText: _obscureTextLogin,
                    style: TextStyle(
                        fontFamily: "WorkSansSemiBold",
                        fontSize: 16.0,
                        color: Colors.black),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(
                        FontAwesomeIcons.lock,
                        size: 22.0,
                        color: Colors.black,
                      ),
                      hintText: "Password",
                      hintStyle: TextStyle(
                          fontFamily: "WorkSansSemiBold", fontSize: 17.0),
                      suffixIcon: GestureDetector(
                        onTap: () {},
                        child: Icon(
                          FontAwesomeIcons.eye,
                          size: 15.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class Mark extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        home: new Material(
            child: new Container(
                padding: const EdgeInsets.all(30.0),
                color: Colors.white,
                child: new Container(
                  child: new Center(
                      child: new Column(children: [
                    new Padding(padding: EdgeInsets.only(top: 140.0)),
                    new Text(
                      'Mark Your Attendance',
                      style: new TextStyle(color: Colors.blue, fontSize: 25.0),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 50.0)),
                    new TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Enter key",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Email cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    RaisedButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Attendance Marked'),
                                actions: <Widget>[
                                  // usually buttons at the bottom of the dialog
                                  new FlatButton(
                                    child: new Text("OK"),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, '/main');
                                    },
                                  ),
                                ],
                              );
                            }
                          );
                      },
                      child: Text('Mark'),
                      color: Colors
                          .blue, //specify background color for the button here
                      colorBrightness: Brightness
                          .dark, //specify the color brightness here, either `Brightness.dark` for darl and `Brightness.light` for light
                      disabledColor: Colors
                          .blueGrey, // specify color when the button is disabled
                      highlightColor: Colors
                          .red, //color when the button is being actively pressed, quickly fills the button and fades out after
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                    )
                  ]
                )
              ),
            )
          )
        )
      );
  }
}

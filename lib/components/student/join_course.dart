import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class JoinCourse extends StatelessWidget {

  TextEditingController courseTokenController = new TextEditingController();

  Mutation joinCourse(context) {
    return Mutation(
      options: MutationOptions(document: """
        mutation joinCourse(\$token: String!){
          joinCourse(token: \$token) {
            name
          }
        }
      """),
      builder: (
          RunMutation runMutation,
          QueryResult result,
          ) {
        return RaisedButton(
          onPressed: () => joinNewCourse(runMutation),
          child: Text('Join'),
          color: Colors.pink, //specify background color for the button here
          colorBrightness: Brightness.dark, //specify the color brightness here, either `Brightness.dark` for darl and `Brightness.light` for light
          disabledColor: Colors.blueGrey, // specify color when the button is disabled
          highlightColor: Colors.red, //color when the button is being actively pressed, quickly fills the button and fades out after
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        );
      },
      onCompleted: (dynamic res) {
        if (res == null) {
          createAlertDialog(context, "Error", "No Such Session");
        } else {
          print(res);
          createAlertDialog(context, "Success", "Course: ${res["joinCourse"]["name"]}");
        }
      },
    );
  }

  void joinNewCourse(runMutation) {
    runMutation({
      "token": courseTokenController.text,
    });
  }

  createAlertDialog (BuildContext context, String title, String content) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: Text(content),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance App"),
      ),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 50.0)),
          TextFormField(
            controller: courseTokenController,
            decoration: new InputDecoration(
              labelText: "Course Token",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
              //fillColor: Colors.green
            ),
            validator: (val) {
              if (val.length == 0) {
                return "Course cannot be empty";
              } else {
                return null;
              }
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          Padding(padding: EdgeInsets.only(top: 15.0)),
          Row(
            children: <Widget>[
              joinCourse(context),
              RaisedButton(
                onPressed: () => Navigator.popAndPushNamed(context, '/student'),
                child: Text('Go Back'),
                color: Colors.blue, //specify background color for the button here
                colorBrightness: Brightness.dark, //specify the color brightness here, either `Brightness.dark` for darl and `Brightness.light` for light
                disabledColor: Colors.blueGrey, // specify color when the button is disabled
                highlightColor: Colors.red, //color when the button is being actively pressed, quickly fills the button and fades out after
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              )
            ],
          )
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class JoinCourse extends StatefulWidget{
  @override
  _JoinCourseState createState() => _JoinCourseState();
}

class _JoinCourseState extends State<JoinCourse> {

  TextEditingController courseTokenController = new TextEditingController();

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
            decoration: InputDecoration(
              labelText: "Course Token",
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(
                    color: Colors.cyanAccent
                ),
              ),
            ),
            keyboardType: TextInputType.emailAddress,
            style: new TextStyle(
              fontFamily: "Poppins",
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              markAttendance(),
              SizedBox(width: 2,height: 50,),
              RaisedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/student'),
                child: Text('Go Back'),
                color: Colors.blueAccent, //specify background color for the button here
                colorBrightness: Brightness.dark, //specify the color brightness here, either `Brightness.dark` for darl and `Brightness.light` for light
                disabledColor: Colors.blueGrey, // specify color when the button is disabled
                highlightColor: Colors.red, //color when the button is being actively pressed, quickly fills the button and fades out after
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              )
            ],
          ),
        ],
      ),
    );
  }

  Mutation markAttendance() {
    return Mutation(
      options: MutationOptions(document: """
          mutation joinCourse(\$token: String!){
            joinCourse(token: \$token) {
              _id
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
          createAlertDialog(context, "Error", "No Such Course Or You are not Egligible");
        } else {
          print (res);
          showDialog(context: context, builder: (context) {
            return AlertDialog(
              title: Text('Success'),
              content: Text('Course Joined'),
            );
          });
        }
      },
    );
  }

  void joinNewCourse(runMutation) {
    runMutation({
      "token": courseTokenController.text,
    });
  }
}
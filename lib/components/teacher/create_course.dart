import 'package:flutter/material.dart';

//GraphQL
import 'package:graphql_flutter/graphql_flutter.dart';

//Shared Preferences
import 'package:shared_preferences/shared_preferences.dart';

class CreateCourse extends StatefulWidget {
  CreateCourse({Key key}) : super(key: key);

  @override
  _CreateCourseState createState() => new _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {

  Future<String> getTeacher(arg) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(arg);
  }

  String courseName;
  String courseCode;


  TextEditingController courseNameController = new TextEditingController();
  TextEditingController courseCodeController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

//  Client client = GraphqlProvider.of(context).value;
//
//  /// to set the authorization header with an api token
//  client.apiToken = '<YOUR_JWT>';

  Mutation createCourse() {
    return Mutation(
      options: MutationOptions(document: """
            mutation createCourse(\$name: String!, \$code: String!){
              createCourse(name: \$name, code: \$code) {
                token
                code
              }
            }
        """),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return RaisedButton(
            onPressed: () => createNewCourse(runMutation),
            child: Text('Create'),
            color: Colors.pink, //specify background color for the button here
            colorBrightness: Brightness.dark, //specify the color brightness here, either `Brightness.dark` for darl and `Brightness.light` for light
            disabledColor: Colors.blueGrey, // specify color when the button is disabled
            highlightColor: Colors.red, //color when the button is being actively pressed, quickly fills the button and fades out after
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          );
      },
      onCompleted: (dynamic resultData) {
        if (resultData == null) {
          print(resultData);
        } else {
          print (resultData);
          showModalBottomSheet(context: context, builder: (builder) {
            return Container(
              height: 250,
              color: Colors.pink,
              child: Center(
                child: Text("Code: ${resultData["createCourse"]["token"]}"),
              ),
            );
          });
        }
      },
    );
  }

  void createNewCourse (runMutation) {
    runMutation({
      "name": courseNameController.text,
      "code": courseCodeController.text
    });
  }

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
                      'Course Details',
                      style: new TextStyle(color: Colors.blue, fontSize: 25.0),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 50.0)),
                    new TextFormField(
                      controller: courseNameController,
                      decoration: new InputDecoration(
                        labelText: "Course name",
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
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 20.0)),
                    new TextFormField(
                      controller: courseCodeController,
                      decoration: new InputDecoration(
                        labelText: "Course No",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Course No cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 20.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        createCourse(),
                        SizedBox(width: 2,height: 50,),
                        RaisedButton(
                          onPressed: () => Navigator.popAndPushNamed(context, '/teacher'),
                          child: Text('Go Back'),
                          color: Colors.blueAccent, //specify background color for the button here
                          colorBrightness: Brightness.dark, //specify the color brightness here, either `Brightness.dark` for darl and `Brightness.light` for light
                          disabledColor: Colors.blueGrey, // specify color when the button is disabled
                          highlightColor: Colors.red, //color when the button is being actively pressed, quickly fills the button and fades out after
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                        )
                      ],
                    )
                  ])),
                ))));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    courseNameController.dispose();
    courseCodeController.dispose();
  }

}

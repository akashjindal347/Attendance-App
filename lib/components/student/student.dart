import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Student extends StatefulWidget {
  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {

  int stateUpdator = 0;

  List <String> courseNames = ["this"];
  List <String> courseCodes;

  TextEditingController sessionTokenController = new TextEditingController();

  Mutation markAttendance() {
    return Mutation(
      options: MutationOptions(document: """
            mutation markAttendance(\$token: String!){
              markAttendance(token: \$token)
            }
        """),
      builder: (
          RunMutation runMutation,
          QueryResult result,
          ) {
        return RaisedButton(
          onPressed: () => markNewAttendance(runMutation),
          child: Text('Mark Attendance'),
          color: Colors.pink, //specify background color for the button here
          colorBrightness: Brightness.dark, //specify the color brightness here, either `Brightness.dark` for darl and `Brightness.light` for light
          disabledColor: Colors.blueGrey, // specify color when the button is disabled
          highlightColor: Colors.red, //color when the button is being actively pressed, quickly fills the button and fades out after
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        );
      },
      onCompleted: (dynamic res) {
        if (res == null) {
          createAlertDialog(context, "Error", "No Such Class");
        } else {
          print (res);
          createAlertDialog(context, "Success", res["markAttendance"]);
        }
      },
    );
  }

  void markNewAttendance(runMutation) {
    runMutation({
      "token": sessionTokenController.text,
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
          title: Text("Attendance Manager"),
        ),
        body: Container(
            child: Column(
                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Container (
                    margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 54.0),
                    child: Material (
                      elevation: 8.0,
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(32.0),
                      child: InkWell (
                        onTap: ()=> Navigator.pushReplacementNamed(context, '/joinCourse'),
                        child: Padding (
                          padding: EdgeInsets.all(12.0),
                          child: Row (
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget> [
                              Icon(Icons.add, color: Colors.white),
                              Padding(padding: EdgeInsets.only(right: 16.0)),
                              Text('ADD A COURSE', style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                      ),
                    )
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  TextFormField(
                    controller: sessionTokenController,
                    decoration: InputDecoration(
                      labelText: "Session Token",
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Session Token cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                  markAttendance(),
                  Expanded(
                    flex: 1,
                    child: Query(options: QueryOptions(document: """
              query studentCourses{
                studentCourses {
                  name
                  code
                }
              }
              """,
                        variables: <String, dynamic>{},
                        pollInterval: 100,
                        fetchPolicy: FetchPolicy.noCache),
                        builder: (QueryResult result, {VoidCallback refetch}) {
                          if (result.errors != null) {
                            return Center(
                              child: Text(result.errors.toString()),
                            );
                          }
                          if (result.loading) {
                            return Center(
                              child: Text("Loading"),
                            );
                          }
                          List courses = result.data["studentCourses"];
                          return ListView.builder(
                              itemCount: result.data["studentCourses"].length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: EdgeInsets.only(
                                        top: 16.0, left: 12.0, right: 12.0),
                                    child: Material(
                                        elevation: 14.0,
                                        borderRadius: BorderRadius.circular(12.0),
                                        shadowColor: Color(0x802196F3),
                                        color: Colors.white,
                                        child: InkWell(
                                          // Do onTap() if it isn't null, otherwise do print()
                                            onTap: () => {},
                                            child: Padding(
                                              padding: const EdgeInsets.all(24.0),
                                              child: Row(
                                                  mainAxisAlignment: MainAxisAlignment
                                                      .spaceBetween,
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .center,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment: MainAxisAlignment
                                                          .center,
                                                      crossAxisAlignment: CrossAxisAlignment
                                                          .start,
                                                      children: <Widget>[
                                                        Text(
                                                            '${courses[index]["code"]}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontWeight: FontWeight
                                                                    .w700,
                                                                fontSize: 34.0)),
                                                        Text(
                                                            '${courses[index]["name"]}',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .redAccent)),
                                                      ],
                                                    ),
                                                    Material(
                                                      color: Colors.red,
                                                      borderRadius: BorderRadius
                                                          .circular(24.0),
                                                      child: Center(
                                                          child: Padding(
                                                            padding: EdgeInsets
                                                                .all(16.0),
                                                            child: Icon(Icons.add,
                                                                color: Colors
                                                                    .white,
                                                                size: 30.0),
                                                          )
                                                      ),
                                                    ),
                                                  ]
                                              ),
                                            )
                                        )
                                    )
                                );
                              });
                        }),
                  )
                ])
        )
    );
  }

//  void getCourses () async{
//    await GraphQLProvider.of(context).value.query(QueryOptions(document: """
//      query studentCourses {
//        studentCourses {
//          code
//          name
//        }
//      }
//      """, pollInterval: 100, fetchPolicy: FetchPolicy.noCache)).then((res) => {
//        setState(() {
//          courseNames.add(res.data["studentCourses"]["name"]);
//          courseCodes.add(res.data["studentCourses"]["code"]);
//        })
//      });
//  }

  void addAttendance () {

  }

}
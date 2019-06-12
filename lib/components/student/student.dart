import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scoped_model/scoped_model.dart';

class Student extends StatefulWidget {
  @override
  _StudentState createState() => _StudentState();
}

class _StudentState extends State<Student> {

  int stateUpdator = 0;

  List <String> courseNames = ["this"];
  List <String> courseCodes;

  String name;

  int year;
  String branch;
  String group;

  bool alive = true;

  List studentSessions;

  List <DropdownMenuItem<int>> yearDropList = [];
  List <DropdownMenuItem<String>> branchDropList = [];
  List <DropdownMenuItem<String>> groupDropList = [];

//  A hub for Query Options for the entire App Alive

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: (600)), () {
      getStudentDetails();
    });
  }

  QueryOptions options = QueryOptions(document: """
    query student {
        student {
          name
          group
          branch
          year
          sessions {
            _id
          }
        }
      }
  """,  pollInterval: 100, fetchPolicy: FetchPolicy.noCache);



  QueryOptions sessionOptions = QueryOptions(document: """
    query studentSessions {
        studentSessions {
          _id
          incDelta
        }
      }
  """, pollInterval: 100, fetchPolicy: FetchPolicy.noCache);

//  Try to dissolve into the Widgets
  getStudentDetails () {
    GraphQLProvider.of(context).value.query(options).then((res) {
      print(res.data);
      print(res.data["student"]["sessions"]);
      setState(() {
        year = res.data["student"]["year"];
        branch = res.data["student"]["branch"];
        group = res.data["student"]["group"];
      });
      print(res.data["student"]["sessions"]);
      print(res.data["student"]["year"]);
      print(res.data["student"]["branch"]);
      print(res.data["student"]["group"]);
      getSessions();
      if(alive) {
        print("ALIVE");
        Future.delayed(Duration(milliseconds: (7000)), () {
          getStudentDetails();
        });
      }
    });
  }

  void getSessions () {
    GraphQLProvider.of(context).value.query(sessionOptions).then((res) {
      print(res.data);
      setState(() {
        studentSessions = res.data["studentSessions"];
      });
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

  int getSessionNumbers (sessionIds) {
    int count = 0;
    print(sessionIds.length);
    print(studentSessions.length);
    for(int i = 0; i < sessionIds.length; i++) {
      for(int j = 0; j < studentSessions.length; j++ ) {
        if(sessionIds[i]['_id'] == studentSessions[j]['_id']) {
          count += studentSessions[j]['incDelta'];
        }
      }
    }
    return count;
  }

  Widget Attendance (courseSessions) {
    print('REAHCES');
    if(courseSessions.length > 0) {
      int timesPresent = getSessionNumbers(courseSessions);
      int courseSessionSum = 0;
      for(int i = 0 ; i < courseSessions.length; i++) {
        courseSessionSum += courseSessions[i]["incDelta"];
      }
      return Text(
        'Attendance: ${timesPresent} / ${courseSessionSum}',
        style: TextStyle(
            color: Colors
                .redAccent
        )
      );
    }
    else {
      return Text('No Sessions yet');
    }
  }

  Widget Percent (courseSessions) {
    if(courseSessions.length > 0) {
      int timesPresent = getSessionNumbers(courseSessions);
      int courseSessionSum = 0;
      for(int i = 0 ; i < courseSessions.length; i++) {
        courseSessionSum += courseSessions[i]["incDelta"];
      }
      return Text(
          '${((timesPresent / courseSessionSum)*100).floor()} %',
          style: TextStyle(
              color: Colors.white
          )
      );
    }
    else {
      return Text('N.A.',
          style: TextStyle(
              color: Colors.white
          )
      );
    }
  }

  Widget AvailableCourses () {
    if(studentSessions == null) {
      return Text('Loading Courses');
    }
    return Container(
      child: Query(options: QueryOptions(document: """
          query availableCourses (\$year: Int!, \$branch: String!, \$group: String!) {
            availableCourses (availableCoursesInput: {year: \$year, branch: \$branch, group: \$group}) {
              name
              code
              sessions {
                _id
                incDelta
              }
              strength
              _id
            }
          }
        """, variables: <String, dynamic> {
        "year": year,
        "branch": branch,
        "group": group
      }, pollInterval: 100),builder: (QueryResult result, { VoidCallback refetch }) {

        if (result.errors != null) {
          return Text(result.errors.toString());
        }

        if (result.loading) {
          return Text('Loading');
        }

        // it can be either Map or List
        List courses = result.data['availableCourses'];

        if(courses.length == 0) {
          return Text("No Courses Found");
        }

        return ListView.builder(
          itemCount: courses.length,
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
                                      '${courses[index]["name"]}',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight
                                              .w700,
                                          fontSize: 34.0)),
                                  Attendance(courses[index]["sessions"]),
                                ],
                              ),
                              Material(
                                  color: Colors.red,
                                  borderRadius: BorderRadius
                                      .circular(24.0),
                                  child: Center(
                                      child: Padding(
                                        padding: EdgeInsets.all(
                                            16.0),
                                        child: Percent(courses[index]["sessions"]),
                                      )
                                  )
                              )
                            ]
                        ),
                      )
                  )
              ),
            );
          },
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Attendance Manager"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,

                children: <Widget>[
                  Padding(padding: EdgeInsets.only(top: 20.0)),
                  Expanded (
                    flex: 1,
                    child: AvailableCourses()
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.16,
                    child: Container (
                      margin: EdgeInsets.symmetric(vertical: 25.0, horizontal: 54.0),
                      child: Material (
                        elevation: 8.0,
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(32.0),
                        child: InkWell (
                          onTap: () {alive = false; Navigator.pushReplacementNamed(context, '/joinSession');},
                          child: Padding (
                            padding: EdgeInsets.all(12.0),
                            child: Row (
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget> [
                                Icon(Icons.add, color: Colors.white),
                                Padding(padding: EdgeInsets.only(right: 16.0)),
                                Text('Mark Attendance', style: TextStyle(color: Colors.white))
                              ],
                            ),
                          ),
                        ),
                      )
                    ),
                  ),
                ]
            )
        )
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    alive = false;
  }

}
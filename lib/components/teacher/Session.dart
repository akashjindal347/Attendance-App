import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../models/AppModel.dart';

class Session extends StatefulWidget {
  @override
  _SessionState createState() => _SessionState();
}

class _SessionState extends State<Session> {
  bool loadedPresent = false;
  bool inTransit = true;
  List sessionStudents;
  List courseStudents;
  List absentees;

  List checkAbsent (checkStudents, sessionStudentsList) {
    for(int i = 0; i < checkStudents.length; i++) {
       for(int j = 0; j < sessionStudentsList.length; j++) {
         if ( checkStudents[i]['_id'] == sessionStudentsList[j]['_id'] ) {
           checkStudents.removeWhere((item) => item["_id"] == sessionStudentsList[j]['_id']);
         }
       }
    }
    return checkStudents;
  }

  getSessionStudents (model) {
    GraphQLProvider.of(context).value.query(QueryOptions(document: """
      query sessionStudents ( \$sessionId: String! ){
        sessionStudents ( sessionId: \$sessionId ) {
          _id
          name
        }
      }
    """, variables: <String, dynamic> {
      "sessionId": model.sessionId
    }, pollInterval: 1, fetchPolicy: FetchPolicy.noCache)).then((res) {
      getCourseStudents(model, res.data["sessionStudents"]);
    });
  }

  getCourseStudents (model, sessionStudentsList) {
    GraphQLProvider.of(context).value.query(QueryOptions(document: """
      query courseStudents ( \$courseId: String! ){
        courseStudents (courseId: \$courseId) {
          _id
          name
        }
      }
      """, variables: <String, dynamic> {
      "courseId": model.courseId
    }, pollInterval: 1, fetchPolicy: FetchPolicy.noCache)).then((res) {
      setState(() {
        absentees = checkAbsent(res.data["courseStudents"], sessionStudentsList);
        sessionStudents = sessionStudentsList;
      });
    });
  }

  @override
  void initState() {

    super.initState();

  }

  _sessionRequestFloatingButton (sessionId, context) {
    if(true) {
      return FloatingActionButton.extended(
        onPressed: () {
          showBottomSheet(context: context, builder: (builder) {
            print('NOT');
            return TeacherRequests(sessionId: sessionId);
          });
        },
        label: Text('Requests'),
      );
    }
    else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance Manager"),
      ),
      body: ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Text('Present'),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        child: Query(options: QueryOptions(document: """
                          query sessionStudents ( \$sessionId: String! ){
                            sessionStudents ( sessionId: \$sessionId ) {
                              _id
                              name
                            }
                          }
                        """, variables: <String, dynamic> {
                          "sessionId": model.sessionId
                        }, pollInterval: 1, fetchPolicy: FetchPolicy.noCache), builder: (QueryResult result, {VoidCallback refetch}) {
                          if(result.errors != null) {
                            return Center(
                              child: Text(result.errors.toString()),
                            );
                          }

                          if(result.loading) {
                            return Center(
                              child: Text("Loading"),
                            );
                          }

                          List students = result.data["sessionStudents"];
                          if(sessionStudents != students) {
                            print("Relaoding sessionStudents");
                            Future.delayed(Duration(milliseconds: (100)), () {
                              setState((){
                                sessionStudents = students;
                              });
                            });
                          }

                          print('sessionStudents: ${sessionStudents}');

                          if(sessionStudents == null) {
                            return Center(child: Text("Loading"));
                          }

                          if(sessionStudents.length == 0) {
                            return Center(child: Text("No Students Present"));
                          }

                          return ListView.builder(
                            itemCount: sessionStudents.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 16.0, left: 12.0, right: 12.0),
                                child: Material(
                                  elevation: 14.0,
                                  borderRadius: BorderRadius.circular(12.0),
                                  shadowColor: Color(0x802196F3),
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () => {  },
                                    child: Padding (
                                      padding: const EdgeInsets.all(24.0),
                                      child: Row (
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget> [
                                          Column (
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget> [
                                              Text('${sessionStudents[index]["name"]}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                                            ],
                                          ),
                                          Material (
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(24.0),
                                            child: Center (
                                              child: Padding (
                                                padding: EdgeInsets.all(16.0),
                                                child: RaisedButton(
                                                  onPressed: () { markOnValue(false, sessionStudents[index]["_id"], model.sessionId, model); },
                                                  child: Text('Mark Absent'),
                                                ),
                                              )
                                            )
                                          )
                                        ]
                                      ),
                                    )
                                  )
                                )
                              );
                            }
                          );
                        }
                      )
                    )
                  ),
                ),
                  Text('Absent'),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        child: Query(options: QueryOptions(document: """
                          query courseStudents ( \$courseId: String! ){
                            courseStudents (courseId: \$courseId) {
                              _id
                              name
                            }
                          }
                          """, variables: <String, dynamic> {
                            "courseId": model.courseId
                          }, pollInterval: 1, fetchPolicy: FetchPolicy.noCache), builder: (QueryResult result, {VoidCallback refetch}) {

                          if(result.errors != null) {
                            return Center(
                              child: Text(result.errors.toString()),
                            );
                          }
                          if(result.loading) {
                            return Center(
                              child: Text("Loading"),
                            );
                          }

                          if(sessionStudents == null) {
                            return Text('Loading');
                          }

                          if(absentees != checkAbsent(result.data["courseStudents"], sessionStudents)) {
                            print('Reloading absentess');
                            Future.delayed(Duration(milliseconds: (100)), () {
                              setState(() {
                                absentees = checkAbsent(result.data["courseStudents"], sessionStudents);
                              });
                            });
                          }

                          print('Absentees: ${absentees}');

                          if(absentees == null) {
                            return Center(child: Text('Loading'));
                          }

                          if(absentees.length == 0) {
                            return Center(child: Text("No Student Absent"));
                          }

                          return ListView.builder(
                            itemCount: absentees.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: EdgeInsets.only(top: 16.0, left: 12.0, right: 12.0),
                                child: Material(
                                  elevation: 14.0,
                                  borderRadius: BorderRadius.circular(12.0),
                                  shadowColor: Color(0x802196F3),
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () => {  },
                                    child: Padding (
                                      padding: const EdgeInsets.all(24.0),
                                      child: Row (
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: <Widget> [
                                          Column (
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget> [
                                              Text('${absentees[index]["name"]}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                                            ],
                                          ),
                                          Material (
                                            color: Colors.transparent,
                                            borderRadius: BorderRadius.circular(24.0),
                                            child: Center (
                                              child: Padding (
                                                padding: EdgeInsets.all(16.0),
                                                child: RaisedButton(
                                                  onPressed: () { markOnValue(true, absentees[index]["_id"], model.sessionId, model); },
                                                  child: Text('Mark Present'),
                                                ),
                                              )
                                            )
                                          )
                                        ]
                                      ),
                                    )
                                  )
                                )
                              );
                            }
                          );
                        }
                      )
                    ),
                  ),
                )
                ],
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.75,
                left: MediaQuery.of(context).size.width * 0.65,
                child: _sessionRequestFloatingButton(model.sessionId, context)
              )
            ]
          )
        )
      ),
    );
  }

  markOnValue(value, studentId, sessionId, model) {
    if(value == true) {
      GraphQLProvider.of(context).value.mutate(MutationOptions(document: """
        mutation markPresent (\$sessionId: String!, \$studentId: String!) {
          markPresent (sessionId: \$sessionId, studentId: \$studentId)
        }
      """, variables: <String, dynamic> {
        "studentId": studentId,
        "sessionId": sessionId
      })).then((res) {
        print(res.data);
        getSessionStudents(model);
      });
    }
    else {
      GraphQLProvider.of(context).value.mutate(MutationOptions(document: """
        mutation markAbsent ( \$sessionId: String!, \$studentId: String! ) {
          markAbsent (sessionId: \$sessionId, studentId: \$studentId)
        }
      """, variables: <String, dynamic> {
        "studentId": studentId,
        "sessionId": sessionId
      })).then((res) {
        print(res.data);
        getSessionStudents(model);
      });
    }
  }
}

class TeacherRequests extends StatefulWidget {

  final String sessionId;
  const TeacherRequests({Key key, this.sessionId}): super(key: key);

  _TeacherRequestsState createState() => _TeacherRequestsState();
}

class _TeacherRequestsState extends State<TeacherRequests> {

  List requests = [];
  bool checkingForRequests = true;

  getRequests (sessionId) {
    GraphQLProvider.of(context).value.query(QueryOptions(document: """
      query getRequests (\$sessionId: String!) {
        getRequests (sessionId: \$sessionId) {
          _id
          student {
            _id
            name
            rollNumber
          }
        }
      }
    """, variables: <String, dynamic> {
      "sessionId": sessionId
    }, pollInterval: 1, fetchPolicy: FetchPolicy.noCache)).then((res) {
      if(res.errors != null) {
        print('Error getting new Requests');
        print(res.errors);
      }

      if(res.data["getRequests"] != requests) {
        setState(() {
          requests = res.data["getRequests"];
        });
      }

      if(mounted && checkingForRequests) {
        Future.delayed(Duration(milliseconds: (1000)), () {
          getRequests(sessionId);
        });
      }
    });
  }

  acceptRequest (requestId) {
    GraphQLProvider.of(context).value.mutate(MutationOptions(document: """
      mutation acceptRequest (\$requestId: String!) {
        acceptRequest (requestId: \$requestId) {
          validated
        }
      }
    """, variables: <String, dynamic> {
      "requestId": requestId
    }, fetchPolicy: FetchPolicy.noCache)).then((res) {
      if(res.errors != null) {
        print(res.errors);
        return;
      }
      print(res.data);
    });
  }

  rejectRequest (requestId) {
    GraphQLProvider.of(context).value.mutate(MutationOptions(document: """
      mutation rejectRequest (\$requestId: String!) {
        rejectRequest (requestId: \$requestId) {
          rejected
        }
      }
    """, variables: <String, dynamic> {
      "requestId": requestId
    }, fetchPolicy: FetchPolicy.noCache)).then((res) {
      if(res.errors != null) {
        print(res.errors);
        return;
      }
      print(res.data);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration(milliseconds: (100)), () {
      getRequests(widget.sessionId);
    });
    super.initState();
  }

  Widget RequestsList () {
    if(requests.length > 0) {
      return ListView.builder(
        itemCount: requests.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Material(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white,
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Name: ${requests[index]['student']['name']}'),
                            Text('Roll Number ${requests[index]['student']['rollNumber']}'),
                          ],
                        ),
                        RaisedButton(
                          onPressed: () {acceptRequest(requests[index]['_id']);},
                          child: Text('Accept'),
                        ),
                        RaisedButton(
                          onPressed: () {rejectRequest(requests[index]['_id']);},
                          child: Text('Reject'),
                        )
                      ],
                    )
                  ),
                ),
              ),
            ],
          );
        }
      );
    }
    else {
      return Center(
        child: Text('No Reqests Recieved'),
      );
    }
  }
  
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print('Rebuilt Requests');
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      child: RequestsList()
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    checkingForRequests = false;
    super.dispose();
  }

}
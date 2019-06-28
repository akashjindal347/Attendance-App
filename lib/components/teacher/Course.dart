import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/AppModel.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Course extends StatelessWidget {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                children: <Widget>[
                  Text("Course Name: ${model.courseName}"),
                  Text("Course Code: ${model.courseCode}"),
                  Text("Course Token: ${model.courseToken}"),
                  Text("Course Strength: ${model.courseStrength}"),
                ],
              ),
            ),
            Center(
              child: Text("Sessions"),
            ),
            Expanded(
              flex: 1,
              child: Query(options: QueryOptions(document: """
                query courseSessions ( \$courseId: String! ){
                  courseSessions ( courseId: \$courseId ) {
                    _id
                    name
                    attendance
                    sessionToken
                    dateCreated
                  }
                }
                """, variables: <String, dynamic> {
                  "courseId": model.courseId
                }, pollInterval: 100, fetchPolicy: FetchPolicy.noCache), builder: (QueryResult result, {VoidCallback refetch}) {
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
                List sessions = result.data["courseSessions"];
                print(sessions);
                return ListView.builder(
                  itemCount: result.data["courseSessions"].length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(top: 16.0, left: 12.0, right: 12.0),
                      child: Material(
                        elevation: 14.0,
                        borderRadius: BorderRadius.circular(12.0),
                        shadowColor: Color(0x802196F3),
                        color: Colors.white,
                        child: InkWell(
                          // Do onTap() if it isn't null, otherwise do print()
                          onTap: () => { goToSession(model, sessions[index]["_id"], context) },
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
                                    Text('${sessions[index]["name"]}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 34.0)),
                                    Text('Attendance: ${sessions[index]["attendance"]}', style: TextStyle(color: Colors.redAccent)),
                                    SafeArea(child: Text('Date Created: ${sessions[index]["dateCreated"]}'.split('GMT')[0], style: TextStyle(color: Colors.redAccent))),
                                    Text('Token: ${sessions[index]["sessionToken"]}', style: TextStyle(color: Colors.redAccent)),
                                  ],
                                ),
                                Material (
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(24.0),
                                  child: Center (
                                    child: Padding (
                                      padding: EdgeInsets.all(16.0),
                                      child: Icon(Icons.add, color: Colors.white, size: 30.0),
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
        ],
      ),
    ))
  );
  }

  goToSession (model, sessionId, context) {
    model.setSessionId(sessionId);
    Navigator.pushNamed(context, '/session');
  }
}
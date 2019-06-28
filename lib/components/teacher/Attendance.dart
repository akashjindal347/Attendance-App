import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Attendance extends StatefulWidget {

  final String courseCode;
  final String courseId;

  const Attendance({Key, key, this.courseCode, this.courseId}) : super(key: key);

  @override
  _AttendanceState createState () => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {

  List students = [];
  List sessions = [];

//  Try to dissolve into the Widgets

  void getCourseStudents () {
    GraphQLProvider.of(context).value.query(QueryOptions(document: """
      query courseStudents (\$courseId: String!) {
        courseStudents (courseId: \$courseId) {
          _id
          name
          rollNumber
          sessions {
            _id
          }
        }
      }
    """, variables: <String, dynamic> {
      "courseId": widget.courseId
    }, pollInterval: 100, fetchPolicy: FetchPolicy.noCache)).then((res) {
      print('courseStudents');
      print(res.data);
      setState(() {
        students = res.data['courseStudents'];
      });
    });
  }

  void getCourseSessions () {
    GraphQLProvider.of(context).value.query(QueryOptions(document: """
      query courseSessions (\$courseId: String!) {
        courseSessions (courseId: \$courseId) {
          _id
          incDelta
        }
      }
    """, variables: <String, dynamic> {
      "courseId": widget.courseId
    }, pollInterval: 100, fetchPolicy: FetchPolicy.noCache)).then((res) {
      print("courseSessions: ");
      print(res.data);
      setState(() {
        sessions = res.data['courseSessions'];
      });
    });
  }

  Widget StudentDetails () {
    if (students.length > 0) {
      return ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              top: 16.0, left: 12.0, right: 12.0
            ),
            child: Material(
              elevation: 14.0,
              borderRadius: BorderRadius.circular(12.0),
              shadowColor: Color(0x802196F3),
              color: Colors.white,
              child: InkWell(
                onTap: () => {},
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${students[index]["name"]}',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 34.0)
                          ),
                          Attendance(students[index]),
                        ],
                      ),
                      Material(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                              child: Percent(students[index]),
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
    }
    else {
      return Center(
        child: Text('No Students'),
      );
    }
  }

  int getSessionNumbers (studentSessions) {
    List courseSessions = sessions;
    int count = 0;
    for(int i = 0; i < courseSessions.length; i++) {
      for(int j = 0; j < studentSessions.length; j++ ) {
        if(courseSessions[i]['_id'] == studentSessions[j]['_id']) {
          count += courseSessions[i]['incDelta'];
        }
      }
    }
    return count;
  }

  Widget Attendance (student) {
    List studentSessions = student["sessions"];
    if(studentSessions.length > 0) {
      int timesPresent = getSessionNumbers(studentSessions);
      int courseSessionSum = 0;
      for(int i = 0 ; i < sessions.length; i++) {
        courseSessionSum += sessions[i]["incDelta"];
      }
      return Text(
        'Attendance: ${timesPresent} / ${courseSessionSum}',
        style: TextStyle(
          color: Colors.redAccent
        )
      );
    }
    else {
      return Text('Zero');
    }
  }

  Widget Percent (student) {
    List studentSessions = student['sessions'];
    if(studentSessions.length > 0) {
      int timesPresent = getSessionNumbers(studentSessions);
      int courseSessionSum = 0;
      for(int i = 0 ; i < sessions.length; i++) {
        courseSessionSum += sessions[i]["incDelta"];
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


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(milliseconds: (600)), () {
      getCourseSessions();
      getCourseStudents();
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Manager'),
      ),
      body: Container(
        child: StudentDetails()
      ),
    );
  }
}
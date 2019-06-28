import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../../utils/timer.dart';
import 'dart:async';

class JoinSession extends StatefulWidget{
  @override
  _JoinSessionState createState() => _JoinSessionState();
}

class _JoinSessionState extends State<JoinSession> {

  TextEditingController sessionTokenController = new TextEditingController();

  int sessionInitTime = 0;
  bool sessionEnd = false;
  bool requestAccepted = false;
  bool requestRejected = false;
  bool stillChecking = false;
  String sessionId;
  String requestId;
  bool buttonShow = true;

  createRequestDialog (BuildContext context, String title, String content) {
    bool requestTimePass = (new DateTime.now().millisecondsSinceEpoch < (sessionInitTime + 600000)) ? true: false;
    print(requestTimePass);
    return showDialog(context: context, barrierDismissible: false, builder: (context) {
      if(content == 'Session is now closed, Request late attendance' && requestTimePass == true) {
        return AlertDialog(
          title: Text('Information'),
          content: Text('Session is now closed, Request late attendance.'),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
                createRequestDialog(context, 'Information', 'Request Drive');
              },
              child: Text('Request')
            )
          ],
        );
      }
      else if(content == 'Session is now closed, Request late attendance' && requestTimePass == false) {
        return AlertDialog(
          title: Text('Failure'),
          content: Text('Session is now closed, and so has the timeframe for Late Requests'),
        );
      }
      else if (content == 'Request Drive') {
        return RequestDialog(
          sessionInitTime: sessionInitTime,
          sessionId: sessionId
        );
      }
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
    print('main rebuilt');
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Attendance App"),
      ),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: 50.0)),
          TextFormField(
            controller: sessionTokenController,
            decoration: InputDecoration(
              labelText: "Session Token",
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

  checkForRequestTime (msg) {
    GraphQLProvider.of(context).value.query(QueryOptions(document: """
      query checkSessionStatus(\$token: String!) {
        checkSessionStatus(token: \$token)
      }
    """, variables: <String, dynamic> {
      "token": sessionTokenController.text
    }, fetchPolicy: FetchPolicy.noCache, pollInterval: 100),).then((res) {
      print(res.errors);
      setState(() {
        sessionId = res.data["checkSessionStatus"].split(' ')[1];
        sessionInitTime = int.parse(res.data["checkSessionStatus"].split(' ')[0]);
      });
      createRequestDialog(context, 'Failure', msg);
    });
  }

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
          if(res["markAttendance"] == 'Marked Present') {
            createAlertDialog(context, "Success", res["markAttendance"]);
          }
          else {
            if(res["markAttendance"] == 'Session is now closed, Request late attendance') {
              checkForRequestTime('Session is now closed, Request late attendance');
            }
            else {
              createAlertDialog(context, "Error", res["markAttendance"]);
            }
          }
        }
      },
    );
  }

  void markNewAttendance(runMutation) {
    runMutation({
      "token": sessionTokenController.text,
    });
  }

}

class RequestDialog extends StatefulWidget {

  final int sessionInitTime;
  final String sessionId;
  const RequestDialog({Key key, this.sessionInitTime, this.sessionId}): super(key: key);

  @override
  _RequestDialogState createState() => _RequestDialogState();
}

class _RequestDialogState extends State<RequestDialog> {

  bool sessionEnd = false;
  bool requestAccepted = false;
  bool requestRejected = false;
  bool stillChecking = false;
  String requestId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: (600)), () {
      makeStudentRequest();
    });
  }

  @override
  Widget build(context) {
    // TODO: implement build
    if(!sessionEnd && !requestAccepted) {
      int progress = new DateTime.now().millisecondsSinceEpoch - widget.sessionInitTime;
      print(progress);
      return AlertDialog(
        title: Text('Information'),
        content: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Timer(duration: 10, progress: progress),
              Text('Wait for the Teacher to Sanction')
            ],
          ),
        ),
      );
    }
    else if (requestRejected) {
      return AlertDialog(
        title: Text('Information'),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.85,
          child: Center(
            child: Text('Request Rejected'),
          ),
        )
      );
    }
    else if (requestAccepted) {
      return AlertDialog(
        title: Text('Information'),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.85,
          child: Center(
            child: Text('Request Accepted'),
          ),
        )
      );
    }
    else {
      return AlertDialog(
        title: Text('Information'),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          width: MediaQuery.of(context).size.width * 0.85,
          child: Center(
            child: Text('Session Enrollment Timeout'),
          ),
        ),
      );
    };
  }

  makeStudentRequest () {
    GraphQLProvider.of(context).value.mutate(MutationOptions(document: """
      mutation sendRequest (\$sessionId: String!) {
        sendRequest (sessionId: \$sessionId) {
          _id
        }
      }
    """, variables: <String, dynamic> {
      "sessionId": widget.sessionId
    }, fetchPolicy: FetchPolicy.noCache)).then((res) {
      print(res.data);
      setState(() {
        requestId = res.data["sendRequest"]["_id"];
        stillChecking = true;
      });
      checkForStudentRequest();
    });
  }

  checkForStudentRequest () {
    GraphQLProvider.of(context).value.query(QueryOptions(document: """
      query getStudentRequest (\$requestId: String!) {
        getStudentRequest (requestId: \$requestId) {
          validated
          rejected
        }
      }
    """, variables: <String, dynamic> {
      "requestId": requestId
    }, fetchPolicy: FetchPolicy.noCache, pollInterval: 100),).then((res) {
      print(res.data);
      print('Now');
      print((new DateTime.now().millisecondsSinceEpoch));
      print('End');
      print((widget.sessionInitTime + 600000));
      if(res.data["getStudentRequest"]['validated'] == true) {
        setState(() {
          requestAccepted = true;
          stillChecking = false;
        });
      }
      else if (res.data["getStudentRequest"]['rejected'] == true) {
        requestRejected = true;
        stillChecking = false;
      }
      else if(stillChecking && mounted && (new DateTime.now().millisecondsSinceEpoch > (widget.sessionInitTime + 600000))) {
        setState(() {
          sessionEnd = true;
          stillChecking = false;
        });
      }
      else if (stillChecking && mounted && (new DateTime.now().millisecondsSinceEpoch < (widget.sessionInitTime + 600000))) {
        Future.delayed(Duration(milliseconds: (2000)), () {
          checkForStudentRequest();
        });
      }
    });
  }
}
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/AppModel.dart';
import 'package:intl/intl.dart';
import 'package:attendance_app/utils/timer.dart';

class CreateSession extends StatefulWidget {
  CreateSession({Key key}) : super(key: key);

  @override
  _CreateSessionState createState() => new _CreateSessionState();
}

class _CreateSessionState extends State<CreateSession> {

  Future<String> getTeacher(arg) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(arg);
  }

  bool timerSet = false;

  String sessionName;

  int incDropDownSelect = null;

  String sessionId;
  String token = "Get Token";
  int attendance = 0;

  TextEditingController validityController = new TextEditingController();

  Mutation createSession() {
    return Mutation(
      options: MutationOptions(document: """
        mutation createSession(\$courseToken: String!, \$name: String!, \$incDelta: Int!){
          createSession(sessionInput: {courseToken: \$courseToken ,name: \$name, incDelta: \$incDelta}) {
            _id
            sessionToken
            attendance
          }
        }
      """),
      builder: (
          RunMutation runMutation,
          QueryResult result,
          ) {
        return ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => RaisedButton(
          onPressed: () => createNewSession(runMutation, model.courseToken, model),
          child: Text('Create'),
          color: Colors.pink, //specify background color for the button here
          colorBrightness: Brightness.dark, //specify the color brightness here, either `Brightness.dark` for darl and `Brightness.light` for light
          disabledColor: Colors.blueGrey, // specify color when the button is disabled
          highlightColor: Colors.red, //color when the button is being actively pressed, quickly fills the button and fades out after
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
          )
        );
      },
      onCompleted: (dynamic resultData) async {
        if (resultData == null) {
          print(resultData);
        } else {
          print (resultData["createSession"]["sessionToken"]);
          setState((){
            sessionId = resultData["createSession"]["_id"];
            token = resultData["createSession"]["sessionToken"];
            attendance = resultData["createSession"]["attendance"];
          });
          timerSet = true;
          keepAsking(DateFormat("dd-MM-yyyy hh:mm:ss").format(now));
        }
      },
    );
  }

  void keepAsking(String name) async{
    await GraphQLProvider.of(context).value.query(QueryOptions(document: """
      query teacherSession(\$name: String!){
        teacherSession(name: \$name) {
          attendance
        }
      }
      """, variables: <String, dynamic> {
        "name": name
      }, pollInterval: 100, fetchPolicy: FetchPolicy.noCache)
    ).then((res) => {
      setState(() {
        attendance = res.data["teacherSession"]["attendance"];
      })
    });
    Future.delayed(const Duration(milliseconds: 1000), () {
      keepAsking(name);
    });
  }

  void createNewSession (runMutation, courseToken, model) {
    if(incDropDownSelect == null) {
      showInSnackBar("Enter Duration");
      return;
    }
    if(validityController.value == null) {
      showInSnackBar("Enter Validity");
      return;
    }
    if(int.parse(validityController.text) > 60) {
      showInSnackBar("Set Validity less than 60");
      return;
    }
    runMutation({
      "courseToken": courseToken,
      "name": model.courseName,
      "incDelta": incDropDownSelect
    });
    Future.delayed(Duration(milliseconds: (1000 * int.parse(validityController.text))), () {
      completeSession(model);
    });
  }
  
  void completeSession (model) {
    model.setSessionId(sessionId);
    GraphQLProvider.of(context).value.mutate(MutationOptions(document: """
      mutation completeSession(\$sessionId: String!){
        completeSession(sessionId: \$sessionId) {
          isComplete
        }
      }
    """, variables: <String, dynamic> {
      "sessionId": sessionId
    }),).then((res) => {
      Navigator.pushNamed(context, '/session')
    });
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _sessionScaffoldKey.currentState?.removeCurrentSnackBar();
    _sessionScaffoldKey.currentState.showSnackBar(SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.red,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.white,
      duration: Duration(seconds: 3),
    ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  var now = new DateTime.now();

  List <DropdownMenuItem<int>> incDropList = [];

  void loadDropDown () {
    incDropList = [];
    incDropList.add(DropdownMenuItem(child: Text('1hr'), value: 1,));
    incDropList.add(DropdownMenuItem(child: Text('2hr'), value: 2,));
    incDropList.add(DropdownMenuItem(child: Text('3hr'), value: 3,));
    incDropList.add(DropdownMenuItem(child: Text('4hr'), value: 4,));
    incDropList.add(DropdownMenuItem(child: Text('5hr'), value: 5,));
  }

  final GlobalKey<ScaffoldState> _sessionScaffoldKey = new GlobalKey<ScaffoldState>();

  Widget SessionOn() {
    if(!timerSet) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          createSession(),
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
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Timer(duration: int.parse(validityController.text)),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    loadDropDown();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _sessionScaffoldKey,
        body: ScopedModelDescendant<AppModel>(
            builder: (context, child, model) =>  Container(
//          padding: const EdgeInsets.all(30.0),
          color: Colors.white,
          child: Container(
            child: Center(
              child: Column(children: [
                Padding(padding: EdgeInsets.only(top: 140.0)),
                Text(
                  'Session Details',
                  style: new TextStyle(color: Colors.blue, fontSize: 25.0),
                ),
                Padding(padding: EdgeInsets.only(top: 50.0)),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),),
                Text(model.courseName),
                Text(DateFormat("dd-MM-yyyy hh:mm:ss").format(now)),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('For hours: '),
                    DropdownButton(
                      value: incDropDownSelect,
                      items: incDropList,
                      hint: Text('Select'),
                      onChanged: (value) => {selectDropDown(value)}
                    )
                  ],
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text('Allow till: ')
                  ],
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.150,
                  child: TextField(
                    decoration: InputDecoration(
                      helperText: 'in secs'
                    ),
                    keyboardType: TextInputType.number,
                    controller: validityController,
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                Expanded(
                  flex: 1,
                  child: SessionOn()
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.pink,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("Code: ${token}"),
                      Text("Attendance: ${attendance}"),
                    ],
                  ),
                )
              ]
            )
          ),
        )
      )
    ));
  }

  void selectDropDown (value) {
    setState(() {
      incDropDownSelect = value;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
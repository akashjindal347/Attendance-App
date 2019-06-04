import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/AppModel.dart';

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

  String sessionName;

  String token = "Get Token";
  int attendance = 0;

  TextEditingController sessionNameController = new TextEditingController();

//  Client client = GraphqlProvider.of(context).value;
//  to set the authorization header with an api token
//  client.apiToken = '<YOUR_JWT>';

  Mutation createSession() {
    return Mutation(
      options: MutationOptions(document: """
        mutation createSession(\$courseToken: String!, \$name: String!){
          createSession(courseToken: \$courseToken ,name: \$name) {
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
          onPressed: () => createNewSession(runMutation, model.courseToken),
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
            token = resultData["createSession"]["sessionToken"];
            attendance = resultData["createSession"]["attendance"];
          });
          keepAsking(sessionNameController.text);
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

  void createNewSession (runMutation, courseToken) {
    print(courseToken);
    runMutation({
      "courseToken": courseToken,
      "name": sessionNameController.text
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  final GlobalKey<ScaffoldState> _sessionScaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _sessionScaffoldKey,
        body: Container(
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
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: TextFormField(
                    controller: sessionNameController,
                    decoration: new InputDecoration(
                      labelText: "Session name",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    validator: (val) {
                      if (val.length == 0) {
                        return "Session cannot be empty";
                      } else {
                        return null;
                      }
                    },
                    keyboardType: TextInputType.emailAddress,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.only(top: 20.0)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                ),
                Expanded(
                  flex: 1,
                  child: Container(),
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
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    sessionNameController.dispose();
  }
}
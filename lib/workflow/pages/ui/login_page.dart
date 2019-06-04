import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../style/theme.dart' as Theme;
import '../utils/bubble_indication_painter.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

// Scoped Model
import 'package:scoped_model/scoped_model.dart';

// App Model
import '../../../models/AppModel.dart';

//Shared Preferences
import 'package:shared_preferences/shared_preferences.dart';

// Models
import '../../../models/Teacher.dart';
import '../../../models/Student.dart';

//GraphQL
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _loginkey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _signupkey = new GlobalKey<FormState>();
  bool matchingPassword = false;

  Teacher teacher;
  Student student;

  bool invalidDialogAllowed = true;

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeName = FocusNode();

  String _mode = "Teacher";

  bool loggedIn = false;

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  PageController _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
          key: _scaffoldKey,
          body: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
            },
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height >= 775.0
                    ? MediaQuery.of(context).size.height
                    : 775.0,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientStart,
                        Theme.Colors.loginGradientEnd
                      ],
                      begin: const FractionalOffset(0.0, 0.0),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                  padding: EdgeInsets.only(top: 75.0),
                  child: new Image(
                      width: 250.0,
                      height: 41.0,
                      fit: BoxFit.fill,
                      image: new AssetImage(
                        'assets/img/doubtout.png',
                      )),
                ),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                      child: _buildMenuBar(context),
                    ),
                    Expanded(
                      flex: 2,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (i) {
                          if (i == 0) {
                            setState(() {
                              right = Colors.white;
                              left = Colors.black;
                            });
                          } else if (i == 1) {
                            setState(() {
                              right = Colors.black;
                              left = Colors.white;
                            });
                          }
                        },
                        children: <Widget>[
                           

                          new ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: _buildSignIn(context),
                          ),
                          new ConstrainedBox(
                            constraints: const BoxConstraints.expand(),
                            child: _buildSignUp(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
  }


  @override
  void dispose() {
    myFocusNodePassword.dispose();
    myFocusNodeEmail.dispose();
    myFocusNodeName.dispose();
    _pageController?.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signupConfirmPasswordController.dispose();
    signupPasswordController.dispose();
    signupNameController.dispose();
    signupEmailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    _pageController = PageController();
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
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

  Future setTeacher(String token, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
    preferences.setString('userId', id);
  }

  Widget _buildMenuBar(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: 300.0,
          height: 50.0,
          decoration: BoxDecoration(
            color: Color(0x552B2B2B),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          child: CustomPaint(
            painter: TabIndicationPainter(pageController: _pageController),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: _onSignInButtonPress,
                    child: Text(
                      "Existing",
                      style: TextStyle(
                          color: left,
                          fontSize: 16.0,
                          fontFamily: "WorkSansSemiBold"),
                    ),
                  ),
                ),
                //Container(height: 33.0, width: 1.0, color: Colors.white),
                Expanded(
                  child: FlatButton(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: _onSignUpButtonPress,
                    child: Text(
                      "New",
                      style: TextStyle(
                          color: right,
                          fontSize: 16.0,
                          fontFamily: "WorkSansSemiBold"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 300.0,
          height: 50.0,
          margin: EdgeInsets.only(top: 25.0),
          decoration: BoxDecoration(
            color: Color(0x552B2B2B),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: _onTeacherButtonPress,
                  child: Text(
                    "Teacher",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: "WorkSansSemiBold"),
                  ),
                ),
              ),
              //Container(height: 33.0, width: 1.0, color: Colors.white),
              Expanded(
                child: FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: _onStudentButtonPress,
                  child: Text(
                    "Student",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: "WorkSansSemiBold"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignIn(BuildContext context) {
//    Future<Map<String, dynamic>> Login(String email, String password) async {
//      Map<String, dynamic> user = {'email': email, 'password': password};
//      final http.Response response = await http.post(
//          'https://attendanceappbackend.herokuapp.com/graphql',
//          body: json.encode(user),
//          headers: {'Content-Type': 'application/json'});
//    }

    return Center(
        child: Container(
        padding: EdgeInsets.only(top: 20.0),
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.topCenter,
              overflow: Overflow.visible,
              children: <Widget>[
                Card(
                  elevation: 2.0,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    width: 300.0,
                    height: 190.0,
                    child: Form(
                      key: _loginkey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                            child: TextFormField(
                              controller: loginEmailController,
                              keyboardType: TextInputType.emailAddress,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.envelope,
                                  color: Colors.black,
                                  size: 22.0,
                                ),
                                hintText: "Email Address",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 17.0),
                              ),
                            ),
                          ),
                          Container(
                            width: 250.0,
                            height: 1.0,
                            color: Colors.grey[400],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                            child: TextFormField(
                              focusNode: myFocusNodePasswordLogin,
                              controller: loginPasswordController,
                              obscureText: _obscureTextLogin,
                              style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                icon: Icon(
                                  FontAwesomeIcons.lock,
                                  size: 22.0,
                                  color: Colors.black,
                                ),
                                hintText: "Password",
                                hintStyle: TextStyle(
                                    fontFamily: "WorkSansSemiBold",
                                    fontSize: 17.0),
                                suffixIcon: GestureDetector(
                                  onTap: _toggleLogin,
                                  child: Icon(
                                    FontAwesomeIcons.eye,
                                    size: 15.0,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 170.0),
                  decoration: new BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Theme.Colors.loginGradientStart,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                      BoxShadow(
                        color: Theme.Colors.loginGradientEnd,
                        offset: Offset(1.0, 6.0),
                        blurRadius: 20.0,
                      ),
                    ],
                    gradient: new LinearGradient(
                        colors: [
                          Theme.Colors.loginGradientEnd,
                          Theme.Colors.loginGradientStart
                        ],
                        begin: const FractionalOffset(0.2, 0.2),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  child: _initLogIn(context),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: FlatButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.white,
                        fontSize: 16.0,
                        fontFamily: "WorkSansMedium"),
                  )),
            ),
          ],
        ),
      )
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 23.0),
      child: Column(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            overflow: Overflow.visible,
            children: <Widget>[
              Card(
                elevation: 2.0,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Container(
                  width: 300.0,
                  height: 360.0,
                  child: Form(
                    key: _signupkey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            focusNode: myFocusNodeName,
                            keyboardType: TextInputType.text,
                            textCapitalization: TextCapitalization.words,
                            controller: signupNameController,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.black,
                              ),
                              hintText: "Name",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            focusNode: myFocusNodeEmail,
                            controller: signupEmailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.envelope,
                                color: Colors.black,
                              ),
                              hintText: "Email Address",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            focusNode: myFocusNodePassword,
                            controller: signupPasswordController,
                            obscureText: _obscureTextSignup,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                              ),
                              hintText: "Password",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignup,
                                child: Icon(
                                  FontAwesomeIcons.eye,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 250.0,
                          height: 1.0,
                          color: Colors.grey[400],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            controller: signupConfirmPasswordController,
                            obscureText: _obscureTextSignupConfirm,
                            style: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0,
                                color: Colors.black),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.lock,
                                color: Colors.black,
                              ),
                              hintText: "Confirmation",
                              hintStyle: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0),
                              suffixIcon: GestureDetector(
                                onTap: _toggleSignupConfirm,
                                child: Icon(
                                  FontAwesomeIcons.eye,
                                  size: 15.0,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 340.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Theme.Colors.loginGradientStart,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Theme.Colors.loginGradientEnd,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Theme.Colors.loginGradientEnd,
                        Theme.Colors.loginGradientStart
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: _initSignup(context)
              ),
            ],
          ),
        ],
      ),
    );
  }

//  Future<Map<String, dynamic>> _submitForm() async {
//    _signupkey.currentState.save();
//    print(_emailValue);
//    Map<String, dynamic> user = {
//      'email': _emailValue,
//      'password': _passwordValue
//    };
//    http.Response response = await http.post(
//        'https://attendanceappbackend.herokuapp.com/graphql',
//        body: json.encode(user),
//        headers: {'Content-Type': 'application/json'});
//    print(response.body);
//  }

  _initSignup(context) {
    if (_mode == 'Teacher') {
      return ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => Mutation(
          options: MutationOptions(document: """
            mutation SignUpTeacher(\$name: String!, \$email: String!, \$password: String!){
              createTeacher(teacherInput: {name: \$name, email: \$email, password: \$password}) {
                token
                userId
              }
            }
          """),
          builder: (
            RunMutation runMutation,
            QueryResult result,
          ){
            return MaterialButton(
              highlightColor: Colors.transparent,
              splashColor: Theme.Colors.loginGradientEnd,
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 42.0
                ),
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: "WorkSansBold"),
                ),
              ),
              onPressed: () => signUp(runMutation)
              );
          },
          onCompleted: (dynamic resultData) {
            print("At Least Mutated");
            if(resultData == null) {
              print(resultData);
              showInSnackBar('User already Exists');
            }
            else {
              model.setToken(resultData["createTeacher"]["token"]);
              model.setId(resultData["createTeacher"]["userId"]);
              Navigator.pushReplacementNamed(context, '/teacher');
            }
          },
        )
      );
    } else {
      return ScopedModelDescendant<AppModel> (
        builder: (context, child, model) =>  Mutation(
          options: MutationOptions(document: """
            mutation SignUpStudent(\$name: String!, \$email: String!, \$password: String!){
              createStudent(studentInput: {name: \$name, email: \$email, password: \$password}) {
                token
                userId
              }
            }
          """),
          builder: (
              RunMutation runMutation,
              QueryResult result,
              ){
            return MaterialButton(
              highlightColor: Colors.transparent,
              splashColor: Theme.Colors.loginGradientEnd,
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 42.0
                ),
                child: Text(
                  "SIGN UP",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: "WorkSansBold"),
                ),
              ),
              onPressed: () => signUp(runMutation)
            );
          },
          onCompleted: (dynamic resultData) {
            print("At Least Mutated");
            if(resultData == null) {
              print(resultData);
              showInSnackBar('User already Exists');
            }
            else {
              model.setToken(resultData["createStudent"]["token"]);
              model.setId(resultData["createStudent"]["userId"]);
              Navigator.pushReplacementNamed(context, '/student');
            }
          },
        )
      );
    }
  }

  onValue (queryResult) {
    print("Logged IN Too");
    print(queryResult);
  }

  _initLogIn(context) {
    if (_mode == 'Teacher') {
      return ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => Mutation(
          options: MutationOptions(document: """
            mutation loginTeacher(\$method: String!, \$password: String!){
              loginTeacher(method: \$method, password: \$password) {
                userId
                token
              }
            }
          """),
          builder: (
            RunMutation runMutation,
            QueryResult result,
            ){
            return MaterialButton(
              highlightColor: Colors.transparent,
              splashColor: Theme.Colors.loginGradientEnd,
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 42.0
                ),
                child: Text(
                  "LOG IN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: "WorkSansBold"),
                ),
              ),
              onPressed: () => logIn(runMutation, null, null)
            );
          },
          onCompleted: (dynamic resultData) {
            if(resultData != null) {
              print("See Next");
              print(resultData);
              model.setToken(resultData["loginTeacher"]["token"]);
              model.setId(resultData["loginTeacher"]["userId"]);
              Navigator.pushReplacementNamed(context, '/teacher');
            }
            else {
              showInSnackBar("Invalid Credentials");
            }
          },
        )
      );
    } else {
      return ScopedModelDescendant<AppModel>(
        builder: (context, child, model) => Mutation(
          options: MutationOptions(document: """
            mutation loginStudent(\$method: String!, \$password: String!){
              loginStudent(method: \$method, password: \$password) {
                userId
                token
              }
            }
          """),
          builder: (
              RunMutation runMutation,
              QueryResult result,
              ){
            return MaterialButton(
              highlightColor: Colors.transparent,
              splashColor: Theme.Colors.loginGradientEnd,
              //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0, horizontal: 42.0
                ),
                child: Text(
                  "LOG IN",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25.0,
                    fontFamily: "WorkSansBold"),
                ),
              ),
              onPressed: () => logIn(runMutation, null, null)
            );
          },
          onCompleted: (dynamic resultData) {
            if(resultData != null) {
              print(resultData);
              model.setToken(resultData["loginStudent"]["token"]);
              model.setId(resultData["loginStudent"]["userId"]);
              Navigator.pushReplacementNamed(context, '/student');
            }
            else {
              showInSnackBar("Invalid Credentials");
            }
          },
        )
      );
    }
  }

  void logIn (runMutation, String method, String password) {
//    if(_mode == 'Student') {
//      Navigator.pushReplacementNamed(context, '/student');
//    }
//    else {
      if(runMutation == null) {
        print(method);
        runMutation({
          "method": method,
          "password": password,
        });
      }
      else {
        print(loginEmailController.text);
        runMutation({
          "method": loginEmailController.text,
          "password": loginPasswordController.text,
        });
      }
//    }
  }

  void signUp (runMutation) {
    print(signupNameController.text);
    if(signupPasswordController.text == signupConfirmPasswordController.text) {
      runMutation({
        "name": signupNameController.text,
        "email": signupEmailController.text,
        "password": signupPasswordController.text,
      });
    }
    else {
      showInSnackBar("Passwords do not match");
    }
  }
    
  void _onSignInButtonPress() {
    _pageController.animateToPage(0,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onTeacherButtonPress() {
    _mode = "Teacher";
    print(this._mode);
  }

  void _onStudentButtonPress() {
    _mode = "Student";
    print(this._mode);
  }

  void _toggleLogin() {
//    setState(() {
//      _obscureTextLogin = !_obscureTextLogin;
//    });
  }

  void _toggleSignup() {
//    setState(() {
//      _obscureTextSignup = !_obscureTextSignup;
//    });
  }

  void _toggleSignupConfirm() {
//    setState(() {
//      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
//    });
  }
}

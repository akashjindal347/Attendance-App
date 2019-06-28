import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/bubble_indication_painter.dart';
import 'dart:async';
import 'package:scoped_model/scoped_model.dart';
import '../models/AppModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _loginkey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _signupkey = new GlobalKey<FormState>();
  final GlobalKey<FormState> _studentDetailskey = new GlobalKey<FormState>();
  bool matchingPassword = false;
  bool invalidDialogAllowed = true;

  bool isLoading = false;

  String _mode = "Teacher";
  String _college;

  bool loggedIn = false;

  bool _obscureTextLogin = true;
  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController signupNameController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController signupPhoneController = TextEditingController();
  TextEditingController signupRollController = TextEditingController();
  TextEditingController signupConfirmPasswordController = TextEditingController();

  ScrollController singleChildScrollViewController = ScrollController();

  PageController _pageController;
  PageController flowController;

  final FocusNode studentSignUpRollNumberFocusNode = FocusNode();
  final FocusNode studentSignUpPhoneNumberFocusNode = FocusNode();
  final FocusNode signInUsernameFocusNode = FocusNode();
  final FocusNode signInPasswordFocusNode = FocusNode();
  final FocusNode signUpNameFocusNode = FocusNode();
  final FocusNode signUpEmailFocusNode = FocusNode();
  final FocusNode signUpPasswordFocusNode = FocusNode();
  final FocusNode signUpPasswordConfirmFocusNode = FocusNode();

  Color left = Colors.black;
  Color right = Colors.white;

  int _year;
  String _branch;
  String _group;

  List <DropdownMenuItem<int>> yearDropList = [];
  List <DropdownMenuItem<String>> branchDropList = [];
  List <DropdownMenuItem<String>> groupDropList = [];
  List <DropdownMenuItem<String>> collegeDropList = [DropdownMenuItem(child: Text('Thapar'), value: 'Thapar',)];

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    flowController = PageController();
    _pageController = PageController();
  }

  void buildDrops () {
    yearDropList = [];
    branchDropList = [];
    groupDropList = [];
    yearDropList.add(DropdownMenuItem(child: Text('1st year'), value: 1,));
    yearDropList.add(DropdownMenuItem(child: Text('2nd year'), value: 2,));
    yearDropList.add(DropdownMenuItem(child: Text('3rd year'), value: 3,));
    yearDropList.add(DropdownMenuItem(child: Text('4th year'), value: 4,));
    if (_year != null) {
      if(_year == 1) {
        branchDropList.add(DropdownMenuItem(child: Text('Group A'), value: 'A',));
        branchDropList.add(DropdownMenuItem(child: Text('Group B'), value: 'B',));
        branchDropList.add(DropdownMenuItem(child: Text('Group C'), value: 'C',));
        branchDropList.add(DropdownMenuItem(child: Text('Group D'), value: 'D',));
        branchDropList.add(DropdownMenuItem(child: Text('Group E'), value: 'E',));
        branchDropList.add(DropdownMenuItem(child: Text('Group F'), value: 'F',));
        branchDropList.add(DropdownMenuItem(child: Text('Group G'), value: 'G',));
        branchDropList.add(DropdownMenuItem(child: Text('Group H'), value: 'H',));
        branchDropList.add(DropdownMenuItem(child: Text('Group I'), value: 'I',));
        branchDropList.add(DropdownMenuItem(child: Text('Group J'), value: 'J',));
        branchDropList.add(DropdownMenuItem(child: Text('Group K'), value: 'K',));
        branchDropList.add(DropdownMenuItem(child: Text('Group L'), value: 'L',));
        branchDropList.add(DropdownMenuItem(child: Text('Group M'), value: 'M',));
        branchDropList.add(DropdownMenuItem(child: Text('Group N'), value: 'N',));
        branchDropList.add(DropdownMenuItem(child: Text('Group O'), value: 'O',));
        branchDropList.add(DropdownMenuItem(child: Text('Group P'), value: 'P',));
        branchDropList.add(DropdownMenuItem(child: Text('Group Q'), value: 'Q',));
        branchDropList.add(DropdownMenuItem(child: Text('Group R'), value: 'R',));
        branchDropList.add(DropdownMenuItem(child: Text('Group S'), value: 'S',));
        branchDropList.add(DropdownMenuItem(child: Text('Group T'), value: 'T',));
      }
      else if(_year == 2) {
        branchDropList.add(DropdownMenuItem(child: Text('COE'), value: 'COE',));
        branchDropList.add(DropdownMenuItem(child: Text('ENC'), value: 'ENC',));
        branchDropList.add(DropdownMenuItem(child: Text('ECE'), value: 'ECE',));
        branchDropList.add(DropdownMenuItem(child: Text('CHE'), value: 'CHE',));
        branchDropList.add(DropdownMenuItem(child: Text('CIE'), value: 'CIE',));
        branchDropList.add(DropdownMenuItem(child: Text('EIC'), value: 'EIC',));
        branchDropList.add(DropdownMenuItem(child: Text('MEE'), value: 'MEE',));
        branchDropList.add(DropdownMenuItem(child: Text('ELE'), value: 'ELE',));
        branchDropList.add(DropdownMenuItem(child: Text('MPE'), value: 'MPE',));
        branchDropList.add(DropdownMenuItem(child: Text('MTX'), value: 'MTX',));
        branchDropList.add(DropdownMenuItem(child: Text('BTD'), value: 'BTD',));
      }
      else if(_year == 3) {
        branchDropList.add(DropdownMenuItem(child: Text('COE'), value: 'COE',));
        branchDropList.add(DropdownMenuItem(child: Text('ENC'), value: 'ENC',));
        branchDropList.add(DropdownMenuItem(child: Text('ECE'), value: 'ECE',));
        branchDropList.add(DropdownMenuItem(child: Text('CHE'), value: 'CHE',));
        branchDropList.add(DropdownMenuItem(child: Text('CIE'), value: 'CIE',));
        branchDropList.add(DropdownMenuItem(child: Text('EIC'), value: 'EIC',));
        branchDropList.add(DropdownMenuItem(child: Text('MEE'), value: 'MEE',));
        branchDropList.add(DropdownMenuItem(child: Text('ELE'), value: 'ELE',));
        branchDropList.add(DropdownMenuItem(child: Text('MPE'), value: 'MPE',));
        branchDropList.add(DropdownMenuItem(child: Text('MTX'), value: 'MTX',));
        branchDropList.add(DropdownMenuItem(child: Text('BTD'), value: 'BTD',));
      }
      else if(_year == 4) {
        branchDropList.add(DropdownMenuItem(child: Text('COE'), value: 'COE',));
        branchDropList.add(DropdownMenuItem(child: Text('ENC'), value: 'ENC',));
        branchDropList.add(DropdownMenuItem(child: Text('ECE'), value: 'ECE',));
        branchDropList.add(DropdownMenuItem(child: Text('CHE'), value: 'CHE',));
        branchDropList.add(DropdownMenuItem(child: Text('CIE'), value: 'CIE',));
        branchDropList.add(DropdownMenuItem(child: Text('EIC'), value: 'EIC',));
        branchDropList.add(DropdownMenuItem(child: Text('MEE'), value: 'MEE',));
        branchDropList.add(DropdownMenuItem(child: Text('ELE'), value: 'ELE',));
        branchDropList.add(DropdownMenuItem(child: Text('MPE'), value: 'MPE',));
        branchDropList.add(DropdownMenuItem(child: Text('MTX'), value: 'MTX',));
        branchDropList.add(DropdownMenuItem(child: Text('BTD'), value: 'BTD',));
      }
      if(_branch != null) {
        if(_branch == 'COE') {
          for(int i = 0; i < 28; i++) {
            groupDropList.add(DropdownMenuItem(child: Text('COE-${i+1}'), value: 'COE-${i+1}',),);
          }
        }
        else if(_branch == 'ENC') {
          for(int i = 0; i < 6; i++) {
            groupDropList.add(DropdownMenuItem(child: Text('ENC-${i+1}'), value: 'COE-${i+1}',),);
          }
        }
        else if(_branch == 'ECE') {
          for(int i = 0; i < 6; i++) {
            groupDropList.add(DropdownMenuItem(child: Text('ECE-${i+1}'), value: 'COE-${i+1}',),);
          }
        }
        else if(_branch == 'CIE') {
          for(int i = 0; i < 4; i++) {
            groupDropList.add(DropdownMenuItem(child: Text('CIE-${i+1}'), value: 'CIE-${i+1}',),);
          }
        }
        else if(_branch == 'EIC') {
          for(int i = 0; i < 2; i++) {
            groupDropList.add(DropdownMenuItem(child: Text('EIC-${i+1}'), value: 'EIC-${i+1}',),);
          }
        }
        else if(_branch == 'CHE') {
          for(int i = 0; i < 2; i++) {
            groupDropList.add(DropdownMenuItem(child: Text('CHE-${i+1}'), value: 'CHE-${i+1}',),);
          }
        }
        else if(_branch == 'MEE') {
          for(int i = 0; i < 12; i++) {
            groupDropList.add(DropdownMenuItem(child: Text('MEE-${i+1}'), value: 'MEE-${i+1}',),);
          }
        }
        else if(_branch == 'MPE') {
          for(int i = 0; i < 2; i++) {
            groupDropList.add(DropdownMenuItem(child: Text('MPE-${i+1}'), value: 'MPE-${i+1}',),);
          }
        }
        else if(_branch == 'MTX') {
          for(int i = 0; i < 2; i++) {
            groupDropList.add(DropdownMenuItem(child: Text('MTX-${i+1}'), value: 'MTX-${i+1}',),);
          }
        }
        else if(_branch == 'BTD') {
          for(int i = 0; i < 3; i++) {
            groupDropList.add(DropdownMenuItem(child: Text('BTD-${i+1}'), value: 'BTD-${i+1}',),);
          }
        }
        else if(_branch == 'ELE') {
          for(int i = 0; i < 6; i++) {
            groupDropList.add(DropdownMenuItem(child: Text('ELE-${i+1}'), value: 'ELE-${i+1}',),);
          }
        }
        else {
          for(int i = 0; i < 5; i++) {
            groupDropList.add(DropdownMenuItem(child: Text('${_branch} ${i + 1}'), value: (_branch + (i+1).toString())));
          }
        }
      }
    }
  }

  Widget Loader () {
    if(isLoading) {
      return Container(
        color: Color(0x22000000),
        child: SpinKitRing(
          color: Colors.white,
        ),
      );
    }
    else return Container();
  }

  Widget TypeSelector() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.1), BlendMode.dstATop),
          image: AssetImage('assets/img/logo.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 250.0),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(1.0), BlendMode.dstATop),
                    image: AssetImage('assets/img/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed:(){ _onTeacherButtonPress(); },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Teacher",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold)
                              ,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 30.0),
            alignment: Alignment.center,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    color: Colors.white,
                    onPressed:(){ _onStudentButtonPress(); },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              "Student",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget StudentDetails () {
    return Container(
      padding: EdgeInsets.only(top: 120.0),
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
                child: Padding(
                  padding: EdgeInsets.only(top: 1.0),
                  child: Container(
                    width: 300.0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Year: '),
                              DropdownButton(
                                value: _year,
                                items: yearDropList,
                                hint: Text('Select'),
                                onChanged: (value) => {selectYearDropDown(value)},
                              )
                            ],
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
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Branch: '),
                              DropdownButton(
                                  value: _branch,
                                  items: branchDropList,
                                  hint: Text('Select'),
                                  onChanged: (value) => {selectBranchDropDown(value)}
                              )
                            ],
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
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('Group: '),
                              DropdownButton(
                                  value: _group,
                                  items: groupDropList,
                                  hint: Text('Select'),
                                  onChanged: (value) => {selectGroupDropDown(value)}
                              )
                            ],
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
                            focusNode: studentSignUpRollNumberFocusNode,
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            controller: signupRollController,
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
                              hintText: "Roll Number",
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
                            focusNode: studentSignUpPhoneNumberFocusNode,
                            keyboardType: TextInputType.number,
                            textCapitalization: TextCapitalization.words,
                            controller: signupPhoneController,
                            style: TextStyle(
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 16.0,
                              color: Colors.black
                            ),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              icon: Icon(
                                FontAwesomeIcons.user,
                                color: Colors.black,
                              ),
                              hintText: "Phone Number",
                              hintStyle: TextStyle(
                                fontFamily: "WorkSansSemiBold",
                                fontSize: 16.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                )
              ),
              Container(
                margin: EdgeInsets.only(top: 420.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.blueAccent,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                    colors: [
                      Colors.blue,
                      Colors.blue
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

  Widget ShallSignUpOrGotoStudentDetails () {
    if(_mode == 'Teacher') {
      return _initSignup(context);
    }
    else {
      return MaterialButton(
          highlightColor: Colors.transparent,
          splashColor: Colors.blueAccent,
          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0, horizontal: 42.0
            ),
            child: Text(
              'Next',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontFamily: "WorkSansBold"),
            ),
          ),
          onPressed: () {
            if(signupPasswordController.text == null || signupPasswordController.text == '' || signupConfirmPasswordController.text == null || signupConfirmPasswordController.text == '' || signupNameController.text == null || signupNameController.text == '' || signupEmailController.text == null || signupEmailController.text == '' || _college == null) {
              showInSnackBar('Enter All Details');
              return;
            }
            if(signupPasswordController.text != signupConfirmPasswordController.text) {
              showInSnackBar('Passwords Do Not Match');
              return;
            }
            singleChildScrollViewController.animateTo(0, duration: Duration(milliseconds: 1), curve: Curves.decelerate);
            flowController?.animateToPage(2, duration: Duration(milliseconds: 750), curve: Curves.decelerate);
          }
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    buildDrops();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      key: _scaffoldKey,
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
        },
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              controller: singleChildScrollViewController,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height >= 775.0
                    ? MediaQuery.of(context).size.height
                    : 775.0,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blueAccent,
                      Colors.blueAccent
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
                ),
                child: PageView(
                  controller: flowController,
                  children: <Widget>[
                    TypeSelector(),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 75.0),
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
                              ConstrainedBox(
                                constraints: const BoxConstraints.expand(),
                                child: _buildSignIn(context),
                              ),
                              ConstrainedBox(
                                constraints: const BoxConstraints.expand(),
                                child: _buildSignUp(context),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    StudentDetails()
                  ],
                ),
              ),
            ),
            Loader()
          ],
        )
      ),
    );
  }


  @override
  void dispose() {
    _pageController?.dispose();
    flowController?.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    signupConfirmPasswordController.dispose();
    signupPasswordController.dispose();
    signupNameController.dispose();
    signupEmailController.dispose();
    super.dispose();
  }

  void showInSnackBar(String value) {
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: Text(
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
    preferences.setString('userType', 'Teacher');
  }

  Future setStudent(String token, String id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('token', token);
    preferences.setString('userId', id);
    preferences.setString('userType', 'Student');
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
                        fontFamily: "WorkSansSemiBold"
                      ),
                    ),
                  ),
                ),
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
                        fontFamily: "WorkSansSemiBold"
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSignIn(BuildContext context) {
    return Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
          ),
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
                      child: Form(
                        key: _loginkey,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                              child: TextFormField(
                                focusNode: signInUsernameFocusNode,
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
                                    fontSize: 17.0
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
                                focusNode: signInPasswordFocusNode,
                                controller: loginPasswordController,
                                obscureText: _obscureTextLogin,
                                style: TextStyle(
                                  fontFamily: "WorkSansSemiBold",
                                  fontSize: 16.0,
                                  color: Colors.black
                                ),
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
                    margin: EdgeInsets.only(top: 160.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.blueAccent,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                        BoxShadow(
                          color: Colors.black38,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 20.0,
                        ),
                      ],
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue,
                          Colors.blue
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
                  onPressed: () {
                    flowController.animateToPage(0, duration: Duration(milliseconds: 750), curve: Curves.decelerate);
                  },
                  child: Text(
                    "Go Back",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.white,
                      fontSize: 16.0,
                      fontFamily: "WorkSansMedium"),
                  )
                ),
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
                  child: Form(
                    key: _signupkey,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(
                              top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                          child: TextFormField(
                            focusNode: signUpNameFocusNode,
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
                            focusNode: signUpEmailFocusNode,
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
                            focusNode: signUpPasswordFocusNode,
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
                            focusNode: signUpPasswordConfirmFocusNode,
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
                        Padding(
                          padding: EdgeInsets.only(
                              top: 0.0, bottom: 20.0, left: 25.0, right: 25.0
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text('College: '),
                              DropdownButton(
                                value: _college,
                                items: collegeDropList,
                                hint: Text('Select'),
                                onChanged: (value) => {selectCollegeDropDown(value)}
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 400.0),
                decoration: new BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.blueAccent,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                    BoxShadow(
                      color: Colors.black45,
                      offset: Offset(1.0, 6.0),
                      blurRadius: 20.0,
                    ),
                  ],
                  gradient: new LinearGradient(
                      colors: [
                        Colors.blue,
                        Colors.blue
                      ],
                      begin: const FractionalOffset(0.2, 0.2),
                      end: const FractionalOffset(1.0, 1.0),
                      stops: [0.0, 1.0],
                      tileMode: TileMode.clamp),
                ),
                child: ShallSignUpOrGotoStudentDetails()
              ),
            ],
          ),
        ],
      ),
    );
  }

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
              splashColor: Colors.blueAccent,
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
              setState(() {
                isLoading = false;
              });
              print(resultData);
              showInSnackBar('User already Exists');
            }
            else {
              model.setToken(resultData["createTeacher"]["token"]);
              model.setId(resultData["createTeacher"]["userId"]);
              setTeacher(resultData["createTeacher"]["token"], resultData["createTeacher"]["userId"]);
              Navigator.pushReplacementNamed(context, '/teacher');
            }
          },
        )
      );
    } else {
      return ScopedModelDescendant<AppModel> (
        builder: (context, child, model) =>  Mutation(
          options: MutationOptions(document: """
            mutation SignUpStudent(\$name: String!, \$email: String!, \$password: String!, \$year: Int!, \$branch: String!, \$group: String!, \$rollNumber: String!, \$phoneNumber: String!){
              createStudent(studentInput: {name: \$name, email: \$email, password: \$password, year: \$year, branch: \$branch, group: \$group, rollNumber: \$rollNumber, phoneNumber: \$phoneNumber}) {
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
              splashColor: Colors.blueAccent,
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
              setState(() {
                isLoading = false;
              });
              print(resultData);
              showInSnackBar('User already Exists');
            }
            else {
              model.setToken(resultData["createStudent"]["token"]);
              model.setId(resultData["createStudent"]["userId"]);
              setStudent(resultData["createStudent"]["token"], resultData["createStudent"]["userId"]);
              Navigator.pushReplacementNamed(context, '/student');
            }
          },
        )
      );
    }
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
              splashColor: Colors.blueAccent,
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
              setTeacher(resultData["loginTeacher"]["token"], resultData["loginTeacher"]["userId"]);
              Navigator.pushReplacementNamed(context, '/teacher');
            }
            else {
              setState(() {
                isLoading = false;
              });
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
              splashColor: Colors.blueAccent,
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
              setStudent(resultData["loginStudent"]["token"], resultData["loginStudent"]["userId"]);
              Navigator.pushReplacementNamed(context, '/student');
            }
            else {
              setState(() {
                isLoading = false;
              });
              showInSnackBar("Invalid Credentials");
            }
          },
        )
      );
    }
  }

  void logIn (runMutation, String method, String password) {
    setState(() {
      isLoading = true;
    });
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
  }

  void signUp (runMutation) {
    print('name test');
    print(signupNameController.text);
    setState(() {
      isLoading = true;
    });
    print(signupNameController.text);
    if(signupPasswordController.text == signupConfirmPasswordController.text) {
      if(_mode == 'Teacher') {
        runMutation({
          "name": signupNameController.text,
          "email": signupEmailController.text,
          "password": signupPasswordController.text,
        });
      }
      else {
        if(_group == null || _year == null || _branch == null ) {
          showInSnackBar("Insufficient Details");
          return;
        }
        runMutation({
          "name": signupNameController.text,
          "email": signupEmailController.text,
          "password": signupPasswordController.text,
          "year": _year,
          "branch": _branch,
          "group": _group,
          "phoneNumber": signupPhoneController.text,
          "rollNumber": signupRollController.text
        });
      }
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
    flowController.animateToPage(1, duration: Duration(milliseconds: 750), curve: Curves.decelerate);

  }

  void _onStudentButtonPress() {
    _mode = "Student";
    flowController?.animateToPage(1, duration: Duration(milliseconds: 750), curve: Curves.decelerate);
  }

  void goBackToSelector () {
    flowController.animateToPage(0, duration: Duration(milliseconds: 200), curve: Curves.easeInOut);
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

  void selectYearDropDown (value) {
    setState(() {
      _year = value;
      _branch = null;
      _group = null;
    });
  }

  void selectBranchDropDown (value) {
    setState(() {
      _branch = value;
      _group = null;
    });
  }

  void selectGroupDropDown (value) {
    setState(() {
      _group = value;
    });
  }

  void selectCollegeDropDown (value) {
    setState(() {
      _college = value;
    });
  }

}

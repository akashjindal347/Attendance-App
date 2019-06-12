import 'package:flutter/material.dart';

//GraphQL
import 'package:graphql_flutter/graphql_flutter.dart';

//Shared Preferences
import 'package:shared_preferences/shared_preferences.dart';

class CreateCourse extends StatefulWidget {
  CreateCourse({Key key}) : super(key: key);

  @override
  _CreateCourseState createState() => new _CreateCourseState();
}

class _CreateCourseState extends State<CreateCourse> {

  Future<String> getTeacher(arg) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(arg);
  }

  String courseName;
  String courseCode;

  int _year;
  String _branch;
  String _group;
  String typeDropDownSelect;

  List <DropdownMenuItem<int>> yearDropList = [];
  List <DropdownMenuItem<String>> branchDropList = [];
  List <DropdownMenuItem<String>> groupDropList = [];
  List <DropdownMenuItem<String>> typeDropList = [DropdownMenuItem(child: Text("L"), value: 'L',), DropdownMenuItem(child: Text("T"), value: 'T',), DropdownMenuItem(child: Text("P"), value: 'P',)];


  TextEditingController courseNameController = new TextEditingController();
  TextEditingController courseCodeController = new TextEditingController();

  @override
  void initState() {
    super.initState();
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
      }
    }

  }

  Mutation createCourse() {
    return Mutation(
      options: MutationOptions(document: """
            mutation createCourse(\$name: String!, \$code: String!, \$year: Int!, \$branch: String!, \$group: String!, \$type: String!){
              createCourse(courseInput: {name: \$name, code: \$code, year: \$year, branch: \$branch, group: \$group, type: \$type}) {
                token
                code
              }
            }
        """),
      builder: (
        RunMutation runMutation,
        QueryResult result,
      ) {
        return RaisedButton(
          onPressed: () => createNewCourse(runMutation),
          child: Text('Create'),
          color: Colors.pink, //specify background color for the button here
          colorBrightness: Brightness.dark, //specify the color brightness here, either `Brightness.dark` for darl and `Brightness.light` for light
          disabledColor: Colors.blueGrey, // specify color when the button is disabled
          highlightColor: Colors.red, //color when the button is being actively pressed, quickly fills the button and fades out after
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
        );
      },
      onCompleted: (dynamic resultData) {
        if (resultData == null) {
          print(resultData);
        } else {
          print (resultData);
          showModalBottomSheet(context: context, builder: (builder) {
            return Container(
              height: 250,
              color: Colors.pink,
              child: Center(
                child: Text("Code: ${resultData["createCourse"]["token"]}"),
              ),
            );
          });
        }
      },
    );
  }

  void createNewCourse (runMutation) {
    print(typeDropDownSelect);
    runMutation({
      "name": courseNameController.text,
      "year": _year,
      "branch": _branch,
      "group": _group,
      "code": courseCodeController.text,
      "type": typeDropDownSelect
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    buildDrops();
    return MaterialApp(
        home: Material(
            child: Container(
                padding: EdgeInsets.all(30.0),
                color: Colors.white,
                child: Container(
                  child: Center(
                      child: Column(children: [
                        Padding(padding: EdgeInsets.only(top: 140.0)),
                        Text(
                          'Course Details',
                          style: TextStyle(color: Colors.blue, fontSize: 25.0),
                        ),
                        Padding(padding: EdgeInsets.only(top: 50.0)),
                        TextFormField(
                          controller: courseNameController,
                          decoration: new InputDecoration(
                            labelText: "Course name",
                            fillColor: Colors.white,
                            border: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(25.0),
                              borderSide: new BorderSide(),
                            ),
                        //fillColor: Colors.green
                        ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Course cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    TextFormField(
                      controller: courseCodeController,
                      decoration: new InputDecoration(
                        labelText: "Course Code",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Course No cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(top: 20.0)),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('Year: '),
                            DropdownButton(
                                value: _year,
                                items: yearDropList,
                                hint: Text('Select'),
                                onChanged: (value) => {selectYearDropDown(value)}
                            )
                          ],
                        ),
                        Row(
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
                        Row(
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
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Text('Type: '),
                            DropdownButton(
                                value: typeDropDownSelect,
                                items: typeDropList,
                                hint: Text('Select'),
                                onChanged: (value) => {selectTypeDropDown(value)}
                            )
                          ],
                        ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        createCourse(),
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
                    )
                  ]
                )
              ),
            )
          )
        )
    );
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

  void selectTypeDropDown (value) {
    setState(() {
      typeDropDownSelect = value;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    courseNameController.dispose();
    courseCodeController.dispose();
  }

}

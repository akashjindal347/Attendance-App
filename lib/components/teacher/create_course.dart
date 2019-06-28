//// BASIC
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
  
  String _specialCourse;
  
  List <DropdownMenuItem<String>> specialCourseDropList = [DropdownMenuItem(child: Text('None'), value: 'null',), DropdownMenuItem(child: Text('Summer Semester'), value: 'Summer Semester',)];
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
    if(_specialCourse != null) {
      return;
    }
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
        if(typeDropDownSelect == 'L') {
          if(_year != 1) {
            if(_branch == 'COE') {
              groupDropList.add(DropdownMenuItem(child: Text('COE 1-4'), value: 'COE 1-4',));
              groupDropList.add(DropdownMenuItem(child: Text('COE 5-8'), value: 'COE 5-8',));
              groupDropList.add(DropdownMenuItem(child: Text('COE 9-12'), value: 'COE 9-12',));
              groupDropList.add(DropdownMenuItem(child: Text('COE 13-16'), value: 'COE 13-16',));
              groupDropList.add(DropdownMenuItem(child: Text('COE 17-20'), value: 'COE 17-20',));
              groupDropList.add(DropdownMenuItem(child: Text('COE 21-24'), value: 'COE 21-24',));
              groupDropList.add(DropdownMenuItem(child: Text('COE 25-28'), value: 'COE 25-28',));
            }
            else if(_branch == 'BTD') {
              groupDropList.add(DropdownMenuItem(child: Text('BTD 1-3'), value: 'BTD 1-3',));
            }
            else if(_branch == 'ECE') {
              groupDropList.add(DropdownMenuItem(child: Text('ECE 1-4'), value: 'ECE 1-4',));
              groupDropList.add(DropdownMenuItem(child: Text('ECE 5-8'), value: 'ECE 5-8',));
            }
            else if(_branch == 'ENC') {
              groupDropList.add(DropdownMenuItem(child: Text('ENC 1-4'), value: 'ENC 1-4',));
              groupDropList.add(DropdownMenuItem(child: Text('ENC 5-8'), value: 'ENC 5-8',));
            }
            else if(_branch == 'CHE') {
              groupDropList.add(DropdownMenuItem(child: Text('CHE 1-2'), value: 'CHE 1-2',));
            }
            else if(_branch == 'EIC') {
              groupDropList.add(DropdownMenuItem(child: Text('EIC 1-3'), value: 'EIC 1-3',));
            }
            else if(_branch == 'CIE') {
              groupDropList.add(DropdownMenuItem(child: Text('CIE 1-4'), value: 'CIE 1-4',));
            }
            else if(_branch == 'MEE') {
              groupDropList.add(DropdownMenuItem(child: Text('MEE 1-4'), value: 'MEE 1-4',));
              groupDropList.add(DropdownMenuItem(child: Text('MEE 5-8'), value: 'MEE 5-8',));
              groupDropList.add(DropdownMenuItem(child: Text('MEE 9-12'), value: 'MEE 9-12',));
            }
            else if(_branch == 'MTX') {
              groupDropList.add(DropdownMenuItem(child: Text('MTX 1-2'), value: 'MTX 1-2',));
            }
            else if(_branch == 'MPE') {
              groupDropList.add(DropdownMenuItem(child: Text('MPE 1-2'), value: 'MPE 1-2',));
            }
            else if (_branch == 'ELE') {
              groupDropList.add(DropdownMenuItem(child: Text('ELE 1-4'), value: 'ELE 1-4',));
            }
          }
          else {
            if(_branch == 'A') {
              groupDropList.add(DropdownMenuItem(child: Text('A'), value: 'A',));
              groupDropList.add(DropdownMenuItem(child: Text('B'), value: 'B',));
              groupDropList.add(DropdownMenuItem(child: Text('C'), value: 'C',));
              groupDropList.add(DropdownMenuItem(child: Text('D'), value: 'D',));
              groupDropList.add(DropdownMenuItem(child: Text('E'), value: 'E',));
              groupDropList.add(DropdownMenuItem(child: Text('F'), value: 'F',));
              groupDropList.add(DropdownMenuItem(child: Text('G'), value: 'G',));
              groupDropList.add(DropdownMenuItem(child: Text('H'), value: 'H',));
              groupDropList.add(DropdownMenuItem(child: Text('I'), value: 'I',));
              groupDropList.add(DropdownMenuItem(child: Text('J'), value: 'J',));
            }
            else {
              groupDropList.add(DropdownMenuItem(child: Text('K'), value: 'K',));
              groupDropList.add(DropdownMenuItem(child: Text('L'), value: 'L',));
              groupDropList.add(DropdownMenuItem(child: Text('M'), value: 'M',));
              groupDropList.add(DropdownMenuItem(child: Text('N'), value: 'N',));
              groupDropList.add(DropdownMenuItem(child: Text('O'), value: 'O',));
              groupDropList.add(DropdownMenuItem(child: Text('P'), value: 'P',));
              groupDropList.add(DropdownMenuItem(child: Text('Q'), value: 'Q',));
              groupDropList.add(DropdownMenuItem(child: Text('R'), value: 'R',));
              groupDropList.add(DropdownMenuItem(child: Text('S'), value: 'S',));
              groupDropList.add(DropdownMenuItem(child: Text('T'), value: 'T',));
            }
          }
        }
        else {
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
  }

  Mutation createCourse() {
    return Mutation(
      options: MutationOptions(document: """
        mutation createCourse(\$name: String!, \$code: String!, \$year: Int!, \$branch: String!, \$group: String!, \$type: String!, \$special: String, \$subgroups: [String!]){
          createCourse(courseInput: {name: \$name, code: \$code, year: \$year, branch: \$branch, group: \$group, type: \$type, special: \$special, subgroups: \$subgroups}) {
            token
            code
          }
        } 
      """, fetchPolicy: FetchPolicy.noCache),
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
    if(_specialCourse == null) {
      print(typeDropDownSelect);
      if(typeDropDownSelect == 'L') {
        List <String> subGroups = [];
        if(_year == 1) {
          for(int i = 0; i < 5; i++) {
            subGroups.add(_group + ' ' + (i+1).toString());
          }
        }
        else {
          if(_group == 'COE 1-4') {
            subGroups.add('COE 1');
            subGroups.add('COE 2');
            subGroups.add('COE 3');
            subGroups.add('COE 4');
          }
          else if(_group == 'COE 5-8') {
            subGroups.add('COE 5');
            subGroups.add('COE 6');
            subGroups.add('COE 7');
            subGroups.add('COE 8');
          }
          else if(_group == 'COE 9-12') {
            subGroups.add('COE 9');
            subGroups.add('COE 10');
            subGroups.add('COE 11');
            subGroups.add('COE 12');
          }
          else if(_group == 'COE 13-16') {
            subGroups.add('COE 13');
            subGroups.add('COE 14');
            subGroups.add('COE 15');
            subGroups.add('COE 16');
          }
          else if(_group == 'COE 17-20') {
            subGroups.add('COE 17');
            subGroups.add('COE 18');
            subGroups.add('COE 19');
            subGroups.add('COE 20');
          }
          else if(_group == 'COE 17-20') {
            subGroups.add('COE 17');
            subGroups.add('COE 18');
            subGroups.add('COE 19');
            subGroups.add('COE 20');
          }
          else if(_group == 'COE 21-24') {
            subGroups.add('COE 21');
            subGroups.add('COE 22');
            subGroups.add('COE 23');
            subGroups.add('COE 24');
          }
          else if(_group == 'COE 25-28') {
            subGroups.add('COE 25');
            subGroups.add('COE 26');
            subGroups.add('COE 27');
            subGroups.add('COE 28');
          }
          else if(_group == 'BTD 1-3') {
            subGroups.add('BTD 1');
            subGroups.add('BTD 2');
            subGroups.add('BTD 3');
          }
          else if(_group == 'ENC 1-4') {
            subGroups.add('ENC 1');
            subGroups.add('ENC 2');
            subGroups.add('ENC 3');
            subGroups.add('ENC 4');
          }
          else if(_group == 'ENC 5-8') {
            subGroups.add('ENC 5');
            subGroups.add('ENC 6');
            subGroups.add('ENC 7');
            subGroups.add('ENC 8');
          }
          else if(_group == 'ECE 1-4') {
            subGroups.add('ECE 1');
            subGroups.add('ECE 2');
            subGroups.add('ECE 3');
            subGroups.add('ECE 4');
          }
          else if(_group == 'ECE 5-8') {
            subGroups.add('ECE 5');
            subGroups.add('ECE 6');
            subGroups.add('ECE 7');
            subGroups.add('ECE 8');
          }
          else if(_group == 'CHE 1-2') {
            subGroups.add('CHE 1');
            subGroups.add('CHE 2');
          }
          else if(_group == 'EIC 1-3') {
            subGroups.add('EIC 1');
            subGroups.add('EIC 2');
            subGroups.add('EIC 3');
          }
          else if(_group == 'CIE 1-4') {
            subGroups.add('CIE 1');
            subGroups.add('CIE 2');
            subGroups.add('CIE 3');
            subGroups.add('CIE 4');
          }
          else if(_group == 'MEE 1-4') {
            subGroups.add('MEE 1');
            subGroups.add('MEE 2');
            subGroups.add('MEE 3');
            subGroups.add('MEE 4');
          }
          else if(_group == 'MEE 5-8') {
            subGroups.add('MEE 5');
            subGroups.add('MEE 6');
            subGroups.add('MEE 7');
            subGroups.add('MEE 8');
          }
          else if(_group == 'MEE 9-12') {
            subGroups.add('MEE 9');
            subGroups.add('MEE 10');
            subGroups.add('MEE 11');
            subGroups.add('MEE 12');
          }
          else if(_group == 'MTX 1-2') {
            subGroups.add('MTX 1');
            subGroups.add('MTX 2');
          }
          else if(_group == 'MPE 1-2') {
            subGroups.add('MPE 1');
            subGroups.add('MPE 2');
          }
          else if(_group == 'ELE 1-4') {
            subGroups.add('ELE 1');
            subGroups.add('ELE 2');
            subGroups.add('ELE 3');
            subGroups.add('ELE 4');
          }
        }
        print('subGroups');
        print(subGroups);
        runMutation({
          "name": courseNameController.text,
          "year": _year,
          "branch": _branch,
          "group": _group,
          "code": courseCodeController.text,
          "type": typeDropDownSelect,
          "subgroups": subGroups
        });
      }
      else {
        runMutation({
          "name": courseNameController.text,
          "year": _year,
          "branch": _branch,
          "group": _group,
          "code": courseCodeController.text,
          "type": typeDropDownSelect
        });
      }
    }
    else {
      runMutation({
        "name": courseNameController.text,
        "year": 0,
        "branch": 'Summer',
        "group": 'Summer',
        "code": courseCodeController.text,
        "type": typeDropDownSelect,
        'special': 'summer'
      });
    }
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
                      Padding(padding: EdgeInsets.only(top: 40.0)),
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
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
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
                          Text('Special Course: '),
                          DropdownButton(
                              value: _specialCourse,
                              items: specialCourseDropList,
                              hint: Text('Select'),
                              onChanged: (value) => {selectSpecialCourseDropDown(value)}
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

  void selectSpecialCourseDropDown (value) {
    if(value != 'null') {
      setState(() {
        _specialCourse = value;
      });
    }
    else {
      setState(() {
        _specialCourse = null;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    courseNameController.dispose();
    courseCodeController.dispose();
  }

}

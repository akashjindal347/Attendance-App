import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  String _token;
  String _id;

  String _courseToken;
  String _courseCode;
  String _courseName;
  int _courseStrength;
  int _courseYear;
  String _courseBranch;
  String _courseGroup;

  String _sessionId;

  String get token => _token;
  String get id => _id;

  String get courseToken => _courseToken;
  String get courseCode => _courseCode;
  String get courseName => _courseName;
  int get courseStrength => _courseStrength;
  int get courseYear => _courseYear;
  String get courseBranch => _courseBranch;
  String get courseGroup => _courseGroup;

  String get sessionId => _sessionId;

  void setToken(String t) {
    _token = t;

    notifyListeners();
  }

  void setId(String t) {
    _id = t;

    notifyListeners();
  }

  void setCourseToken(String t) {
    _courseToken = t;
    notifyListeners();
  }

  void setCourseName(String t) {
    _courseName = t;
    notifyListeners();
  }

  void setCourseCode(String t) {
    _courseCode = t;
    notifyListeners();
  }

  void setCourseStrength(int t) {
    _courseStrength = t;
    notifyListeners();
  }

  void setCourseYear(int t) {
    _courseYear = t;
    notifyListeners();
  }

  void setCourseBranch(String t) {
    _courseBranch = t;
    notifyListeners();
  }

  void setCourseGroup(String t) {
    _courseGroup = t;
    notifyListeners();
  }

  void setSessionId(String t) {
    _sessionId = t;
    notifyListeners();
  }
}
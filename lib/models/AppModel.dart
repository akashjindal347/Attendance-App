import 'package:scoped_model/scoped_model.dart';

class AppModel extends Model {
  String _token;
  String _id;
  String _courseToken;
  String _courseCode;
  String _courseName;
  int _courseStrength;

  String get token => _token;
  String get id => _id;
  String get courseToken => _courseToken;
  String get courseCode => _courseCode;
  String get courseName => _courseName;
  int get courseStrength => _courseStrength;

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
}
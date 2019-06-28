import 'package:shared_preferences/shared_preferences.dart';

class AuthUtil {

  static final String authTokenKey = 'token';
  static final String userIdKey = 'userId';

  static String getToken(SharedPreferences prefs) {
    return prefs.getString(authTokenKey);
  }

  static String getUserId(SharedPreferences prefs) {
    return prefs.getString(userIdKey);
  }
}
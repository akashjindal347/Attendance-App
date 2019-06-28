import 'package:flutter/material.dart';
import './components/student/student.dart';
import './components/teacher/teacher.dart';
import './components/teacher/Course.dart';
import './components/teacher/Session.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import './components/student/join_session.dart';
import 'components/login_page.dart';
import './components/teacher/create_course.dart';
import './components/teacher/create_sess.dart';
import 'package:scoped_model/scoped_model.dart';
import './models/AppModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './components/student/join_course.dart';
import './utils/AuthUtil.dart';

getSavedToken () async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.getString("token");
}

getSavedUserId () async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return await preferences.getString("userId");
}

void main() {

//  String savedToken = getSavedToken();
//  String savedUserId = getSavedToken();

  runApp(
    ScopedModel<AppModel>(
        model: AppModel(),
        child: ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => MyApp(token: model.token, id: model.id)
        )
    )
  );
}

class MyApp extends StatelessWidget {

  final String token;
  final String id;
  String savedToken;
  String savedId;
  MyApp({this.token, this.id});

  @override
  Widget build(BuildContext context) {
    HttpLink link;
    String graphqlUri = 'https://attendanceappbackend.herokuapp.com/graphql';
    if (token == null) {
      link = HttpLink(uri: graphqlUri);
    } else {
      link = HttpLink(
          uri: graphqlUri, headers: {"authorization": "Bearer $token"});
    }

    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: link as Link,
            cache: InMemoryCache())
    );

    return GraphQLProvider(
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: LoginPage(),
        routes: {
          '/teacher': (BuildContext context) => Teacher(),
          '/student': (BuildContext context) => Student(),
          '/create': (BuildContext context)=> CreateCourse(),
          '/course': (BuildContext context)=> Course(),
          '/session': (BuildContext context)=> Session(),
          '/createSess': (BuildContext context)=> CreateSession(),
          '/joinSession': (BuildContext context)=> JoinSession(),
          '/joinCourse': (BuildContext context)=> JoinCourse(),
        },
        debugShowCheckedModeBanner: false,
      ),
      client: client,
    );
  }
}
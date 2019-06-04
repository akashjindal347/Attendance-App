import 'package:flutter/material.dart';

// Phases
import './components/student/student.dart';
import './components/teacher/teacher.dart';

import './components/teacher/Course.dart';

import './components/teacher/Sessions.dart';

// GraphQL Provider
import 'package:graphql_flutter/graphql_flutter.dart';

import './components/student/join_course.dart';

//Temporary
import 'workflow/pages/main_page.dart';
import 'workflow/pages/ui/login_page.dart';
import 'workflow/pages/ui/mark_att.dart';

import './components/teacher/create_course.dart';
import './components/teacher/create_sess.dart';

//Components
import './components/pedestal/interface.dart';

//Tests
import './components/student/student.dart';
import 'package:scoped_model/scoped_model.dart';

// AppModel

import './models/AppModel.dart';

void main() => runApp(
    ScopedModel<AppModel>(
        model: AppModel(),
        child: ScopedModelDescendant<AppModel>(
            builder: (context, child, model) => MyApp(token: model.token, id: model.id ))
    )
);

class MyApp extends StatelessWidget {

  final String token;
  final String id;
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
          '/sessions': (BuildContext context)=> Session(),
          '/createSess': (BuildContext context)=> CreateSession(),
          '/joinCourse': (BuildContext context)=> JoinCourse(),
        },
      ),
      client: client,
    );
  }
}
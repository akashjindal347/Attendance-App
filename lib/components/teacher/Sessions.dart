import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scoped_model/scoped_model.dart';
import '../../models/AppModel.dart';

class Session extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("Attendance Manager"),
        ),
        body: ScopedModelDescendant<AppModel>(
            builder: (context, child, model) =>
                Query(
                    options: QueryOptions(
                      document: """
          query courseSessions (\$courseCode: String!) {
            courseSessions (courseCode: \$courseCode) {
              name
              attendance
            }
          }
          """, // this is the query string you just created
                      variables: {
                        'courseCode': model.courseCode,
                      },
                      pollInterval: 10,
                    ),
                    // Just like in apollo refetch() could be used to manually trigger a refetch
                    builder: (QueryResult result, { VoidCallback refetch }) {
                      if (result.errors != null) {
                        return Text(result.errors.toString());
                      }

                      if (result.loading) {
                        return Text('Loading');
                      }

                      // it can be either Map or List
                      List sessions = result.data['courseSessions'];

                      return ListView.builder(
                        itemCount: sessions.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                top: 16.0, left: 12.0, right: 12.0),
                            child: Material(
                                elevation: 14.0,
                                borderRadius: BorderRadius.circular(12.0),
                                shadowColor: Color(0x802196F3),
                                color: Colors.white,
                                child: InkWell(
                                  // Do onTap() if it isn't null, otherwise do print()
                                    onTap: () => {},
                                    child: Padding(
                                      padding: const EdgeInsets.all(24.0),
                                      child: Row(
                                          mainAxisAlignment: MainAxisAlignment
                                              .spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment
                                              .center,
                                          children: <Widget>[
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .center,
                                              crossAxisAlignment: CrossAxisAlignment
                                                  .start,
                                              children: <Widget>[
                                                Text(
                                                    '${sessions[index]["name"]}',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight
                                                            .w700,
                                                        fontSize: 34.0)),
                                                Text(
                                                    'Attendance: ${sessions[index]["attendance"]}',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .redAccent)),
                                              ],
                                            ),
                                            Material(
                                                color: Colors.red,
                                                borderRadius: BorderRadius
                                                    .circular(24.0),
                                                child: Center(
                                                    child: Padding(
                                                      padding: EdgeInsets.all(
                                                          16.0),
                                                      child: Icon(Icons.add,
                                                          color: Colors.white,
                                                          size: 30.0),
                                                    )
                                                )
                                            )
                                          ]
                                      ),
                                    )
                                )
                            ),
                          );
                        },
                      );
                    }
                )
        )
    );
  }
}
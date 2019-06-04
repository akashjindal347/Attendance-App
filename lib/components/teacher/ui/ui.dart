import 'package:flutter/material.dart';

class TeacherUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text('SliverAppBar'),
            backgroundColor: Colors.white,
            expandedHeight: 200.0,
            flexibleSpace: FlexibleSpaceBar(
            ),
          ),
          SliverFixedExtentList(
              itemExtent: MediaQuery.of(context).size.height* 0.25,
              delegate: SliverChildListDelegate([
                Padding(
                    padding: EdgeInsets.all(24.0),
                    child:  Material(
                        elevation: 14.0,
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12.0),
                        shadowColor: Color(0x802196F3),
                        child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add, color: Colors.white,),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.15,
                                  width: 5,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Courses', style: TextStyle(color: Colors.white),
                                )
                              ],
                            )
                        )
                    )
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(24.0, 8.0, 24.0, 24.0),
                    child:  Material(
                        elevation: 14.0,
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(12.0),
                        shadowColor: Color(0x802196F3),
                        child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.add, color: Colors.white,),
                                Container(
                                  height: MediaQuery.of(context).size.height * 0.12,
                                  width: 2.5,
                                  color: Colors.white,
                                ),
                                Text(
                                  'Courses',style: TextStyle(
                                    fontFamily: 'UniSans',
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.italic,
                                    color: Colors.white),
                                )
                              ],
                            )
                        )
                    )
                )
              ])
          ),
        ],
      ),
    );
  }
}
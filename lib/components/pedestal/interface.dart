import 'package:flutter/material.dart';

class PedestalInterface extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: <Widget>[
        Expanded(
          flex: 7,
          child: Container(
            decoration: BoxDecoration(
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(16.0), topRight: Radius.circular(16.0)),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFEEEEEE),
                  blurRadius: 8.0,
                  offset: Offset(0.0, -10.0)
                )
              ]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                MaterialButton(
                  color: Colors.red,
                  padding: EdgeInsets.all(8.0),
                  onPressed: () {

                  },
                  child: Text('Login', style: TextStyle(color: Colors.white),),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.10,
                ),
                MaterialButton(
                  color: Colors.red,
                  padding: EdgeInsets.all(8.0),
                  onPressed: () {

                  },
                  child: Text('SignUp', style: TextStyle(color: Colors.white),),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
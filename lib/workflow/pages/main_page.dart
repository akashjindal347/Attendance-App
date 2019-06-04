import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';



class MainPage extends StatefulWidget
{
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
{
  final List<List<double>> charts =
  [
    [0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4],
    [0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4,],
    [0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4, 0.0, 0.3, 0.7, 0.6, 0.55, 0.8, 1.2, 1.3, 1.35, 0.9, 1.5, 1.7, 1.8, 1.7, 1.2, 0.8, 1.9, 2.0, 2.2, 1.9, 2.2, 2.1, 2.0, 2.3, 2.4, 2.45, 2.6, 3.6, 2.6, 2.7, 2.9, 2.8, 3.4]
  ];

  static final List<String> chartDropdownItems = [ 'Last 7 days', 'Last month', 'Last year' ];
  String actualDropdown = chartDropdownItems[0];
  int actualChart = 0;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      appBar: AppBar
      (
        elevation: 2.0,
        backgroundColor: Colors.white,
        title: Text('Attendance Manager', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0)),
        
      ),
      
      body: StaggeredGridView.count(
    
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
       
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        children: <Widget>[


          _buildTile(
            GestureDetector(

            onTap: ()=>Navigator.pushReplacementNamed(context, '/mark'),
            child: Padding
              (
              padding: const EdgeInsets.all(24.0),
              child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    Column
                      (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [

                        Text('UDS045', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0)),
                        Text('79%', style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700, fontSize: 20.0))
                      ],
                    ),
                    Material
                      (
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center
                          (
                            child: Padding
                              (
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.add, color: Colors.white, size: 30.0),
                            )
                        )
                    )
                  ]
              ),
            ),)
          ),
          
        
          _buildTile(
            GestureDetector(

            onTap: ()=>Navigator.pushReplacementNamed(context, '/mark'),
            child: Padding
              (
              padding: const EdgeInsets.all(24.0),
              child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    Column
                      (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [

                        Text('UCS001', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0)),
                        Text('69%', style: TextStyle(color: Colors.red, fontWeight: FontWeight.w700, fontSize: 20.0))
                      ],
                    ),
                    Material
                      (
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(24.0),
                        child: GestureDetector(
                           onTap: ()=>Navigator.pushReplacementNamed(context, '/login'),
                          child: Center
                          (
                            child: Padding
                              (
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.add, color: Colors.white, size: 30.0),
                            ),),
                        )
                    )
                  ]
              ),
            ),)
          ),
          _buildTile(
            GestureDetector(

            onTap: ()=>Navigator.pushReplacementNamed(context, '/mark'),
            child:Padding
              (
              padding: const EdgeInsets.all(24.0),
              child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    Column
                      (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [

                        Text('UML002', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0)),
                        Text('69%', style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.w700, fontSize: 20.0))                      ],
                    ),
                    Material
                      (
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center
                          (
                            child: Padding
                              (
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.store, color: Colors.white, size: 30.0),
                            )
                        )
                    )
                  ]
              ),
            ),
            ),
          ),
          _buildTile(
            GestureDetector(

            onTap: ()=>Navigator.pushReplacementNamed(context, '/mark'),
            child:Padding
              (
              padding: const EdgeInsets.all(24.0),
              child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    Column
                      (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [

                         Text('UTA001', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0)),
                        Text('74%', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w700, fontSize: 20.0))
                      ],
                    ),
                    Material
                      (
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center
                          (
                            child: Padding
                              (
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.store, color: Colors.white, size: 30.0),
                            )
                        )
                    )
                  ]
              ),
            ),
          ),),

          _buildTile(
            GestureDetector(

            onTap: ()=>Navigator.pushReplacementNamed(context, '/mark'),
            child:Padding
              (
              padding: const EdgeInsets.all(24.0),
              child: Row
                (
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>
                  [
                    Column
                      (
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>
                      [

                         Text('UCB001', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 30.0)),
                        Text('75%', style: TextStyle(color: Colors.pink, fontWeight: FontWeight.w700, fontSize: 20.0))
                      ],
                    ),
                    Material
                      (
                        color: Colors.pink,
                        borderRadius: BorderRadius.circular(24.0),
                        child: Center
                          (
                            child: Padding
                              (
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.store, color: Colors.white, size: 30.0),
                            )
                        )
                    )
                  ]
              ),
            ),
          ),),
          
          
        ],
        staggeredTiles: [
         
         StaggeredTile.extent(2, 110.0),
         StaggeredTile.extent(2, 110.0),
         StaggeredTile.extent(2, 110.0),
         StaggeredTile.extent(2, 110.0),
         StaggeredTile.extent(2, 110.0),
          
          
        ],
      )
    );
  }

  Widget _buildTile(Widget child, {Function() onTap}) {
    return Material(
      elevation: 14.0,
      borderRadius: BorderRadius.circular(12.0),
      shadowColor: Color(0x802196F3),
      child: InkWell
      (
        // Do onTap() if it isn't null, otherwise do print()
        onTap: onTap != null ? () => onTap() : () { print('Not set yet'); },
        child: child
      )
    );
  }
}
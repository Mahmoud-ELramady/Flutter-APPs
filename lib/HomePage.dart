import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget{
  List<int> i=[1,2,3,4];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu
        ),
        title: Text("Hello"),
        actions: [
          IconButton(icon: Icon(Icons.search), onPressed:setOnClickSearch),
          Icon(Icons.notification_important),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.red,
              child: Text("First Name",
                style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.green,
              child: Text("Last Name",
                style: TextStyle(
                color: Colors.white,
                fontSize: 30.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.amber,
              child: Text("Second Name",
              style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.blue,
              child: Text("Middle Name",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                ),
              ),
            ),
          ),
        ],
      ),

    );
  }

  void setOnClickSearch(){
    print("Search");
  }

}
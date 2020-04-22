import 'package:flutter/material.dart';
import 'package:tasks/colors.dart';

import 'listTasks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white,
          accentColor: CustomColors.darkBlue,
          fontFamily: 'Poppins',
          appBarTheme: AppBarTheme(
            elevation: 0,
          )),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            '',
            // style: TextStyle(
            //   letterSpacing: 2,
            //   color: Theme.of(context).accentColor,
            // ),
          ),
        ),
      ),
      body: ListTasks(),
      // ClipRRect(
      //   borderRadius: BorderRadius.only(
      //     topLeft: Radius.circular(50),
      //     topRight: Radius.circular(50),
      //   ),
      //   child: Container(
      //     color: Colors.grey[100],
      //     child: ListTasks(),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

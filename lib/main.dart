import 'package:flutter/material.dart';
import 'package:tasks/colors.dart';

import 'addTask.dart';
import 'listTasks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.grey,
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
          ),
        ),
      ),
      body: ListTasks(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddTask();
              },
            ),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

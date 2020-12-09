import 'package:flutter/material.dart';
import 'package:tasks/colors.dart';
import 'package:tasks/database.dart';
import 'package:tasks/task.dart';

import 'addTask.dart';
import 'listTasks.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: CustomColors.darkBlue,
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
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(
                Icons.remove_circle,
                size: 30,
                color: CustomColors.darkBlue,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: [
            _getHeading(),
            Expanded(
              child: ListTasks(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return AddTask();
              },
            ),
          ).then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

Widget _getHeading() {
  return Padding(
    padding: const EdgeInsets.all(24.0),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Everyday",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            Text(
              "Tasks",
              style: TextStyle(
                fontFamily: 'AbrilFatface',
                fontSize: 28,
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

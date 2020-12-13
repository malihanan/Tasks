import 'package:flutter/material.dart';
import 'package:tasks/colors.dart';
import 'package:tasks/widgets/heading.dart';
import 'addTask.dart';
import 'dark_graph.dart';
import 'listTasks.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: CustomColors.darkBlue,
          accentColor: CustomColors.darkBlue,
          fontFamily: 'Poppins',
          textTheme: TextTheme(
            bodyText2: TextStyle(color: Colors.grey[50]),
          ),
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
        iconTheme: IconThemeData(color: CustomColors.darkBlue),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.donut_small),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            );
          },
        ),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width,
        child: Drawer(
          child: DarkGraph(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: [
            Heading(
              top: "Everyday",
              bottom: "Tasks",
            ),
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

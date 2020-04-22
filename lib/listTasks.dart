import 'package:flutter/material.dart';
import 'package:tasks/task.dart';

class ListTasks extends StatefulWidget {
  @override
  _ListTasksState createState() => _ListTasksState();
}

List<Task> tasks = <Task>[
  Task('Drink Water', 10, 8, Colors.blue[300]),
  Task('Do Homework', 5, 2, Colors.pink[300]),
  Task('Exercise', 2, 1, Colors.lightGreen[300]),
];

class _ListTasksState extends State<ListTasks> {
  double initial = 0.0;
  double drag = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32.0),
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (BuildContext context, int i) {
          return buildItem(tasks[i]);
        },
      ),
    );
  }

  Widget buildItem(Task task) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: GestureDetector(
            onPanStart: (DragStartDetails details) {
              initial = details.globalPosition.dx;
            },
            onPanUpdate: (DragUpdateDetails details) {
              drag = details.globalPosition.dx - initial;
            },
            onPanEnd: (DragEndDetails details) {
              if (drag > 0) {
                if (task.completedParts != task.parts) {
                  setState(() {
                    task.completedParts += 1;
                  });
                }
              } else if (drag < 0) {
                if (task.completedParts != 0) {
                  setState(() {
                    task.completedParts -= 1;
                  });
                }
              }
            },
            child: Stack(
              children: <Widget>[
                Container(
                  height: 70,
                  child: LinearProgressIndicator(
                    backgroundColor: task.color.withOpacity(0.3),
                    value: task.getCompletionPercentage(),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      task.color.withOpacity(0.5),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    task.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tasks/colors.dart';
import 'package:tasks/task.dart';

class ListTasks extends StatefulWidget {
  @override
  _ListTasksState createState() => _ListTasksState();
}

List<Task> tasks = <Task>[
  Task('Drink Water', 10, 8, CustomColors.blue),
  Task('Do Homework', 5, 2, CustomColors.pink),
  Task('Exercise', 2, 1, CustomColors.purple),
];

class _ListTasksState extends State<ListTasks> {
  double initial = 0.0;
  double drag = 0.0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tasks.length + 1,
      itemBuilder: (BuildContext context, int i) {
        if (i == 0) {
          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
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
          );
        }
        return buildItem(tasks[i - 1]);
      },
    );
  }

  Widget buildItem(Task task) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        //borderRadius: BorderRadius.all(Radius.circular(15)),
        elevation: 8,
        shadowColor: task.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
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
              ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                child: Container(
                  height: 62,
                  child: LinearProgressIndicator(
                    backgroundColor: task.color.withOpacity(0.3),
                    value: task.getCompletionPercentage(),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      task.color,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      task.title,
                      style: TextStyle(
                        color: CustomColors.darkBlue,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      (task.getCompletionPercentage() * 100)
                              .floor()
                              .toString() +
                          "%",
                      style: TextStyle(
                        color: (task.getCompletionPercentage() == 1)
                            ? Colors.white70
                            : task.color,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

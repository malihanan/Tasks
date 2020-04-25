import 'package:flutter/material.dart';
import 'package:tasks/colors.dart';
import 'package:tasks/database.dart';
import 'package:tasks/task.dart';
import 'editTask.dart';

// List<Task> tasks = <Task>[
//   Task.fromValues(1, 'Drink Water', 10, CustomColors.blue),
//   Task.fromValues(2, 'Do Homework', 5, CustomColors.pink),
//   Task.fromValues(3, 'Exercise', 2, CustomColors.purple),
// ];

class ListTasks extends StatefulWidget {
  @override
  _ListTasksState createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  double _initial = 0.0;
  double _drag = 0.0;
  bool _inEditMode = false;
  final double _listItemHeight = 62;
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: DBProvider.db.getAllTasks(),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data.length + 1,
            itemBuilder: (BuildContext context, int i) {
              if (i == 0) {
                return _getHeading();
              } else {
                return buildItem(snapshot.data[i - 1]);
              }
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget buildItem(Task task) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        //borderRadius: BorderRadius.all(Radius.circular(15)),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: GestureDetector(
          onTap: () {
            setState(() {
              _inEditMode = !_inEditMode;
            });
          },
          onPanStart: (DragStartDetails details) {
            _initial = details.globalPosition.dx;
          },
          onPanUpdate: (DragUpdateDetails details) {
            _drag = details.globalPosition.dx - _initial;
          },
          onPanEnd: (DragEndDetails details) {
            if (!_inEditMode) {
              if (_drag > 0) {
                if (task.completedParts != task.parts) {
                  setState(() {
                    task.completedParts += 1;
                    DBProvider.db.updateTask(task);
                  });
                }
              } else if (_drag < 0) {
                if (task.completedParts != 0) {
                  setState(() {
                    task.completedParts -= 1;
                    DBProvider.db.updateTask(task);
                  });
                }
              }
            }
          },
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: _listItemHeight,
                  child: LinearProgressIndicator(
                    backgroundColor: task.color.withOpacity(0.3),
                    value: task.getCompletionPercentage(),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _inEditMode ? task.color.withOpacity(0.3) : task.color,
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
                      _inEditMode
                          ? ''
                          : (task.getCompletionPercentage() * 100)
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
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: _listItemHeight,
                  child: _inEditMode
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: task.color,
                                  size: 20,
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return EditTask(task);
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 6.0),
                              child: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: task.color,
                                  size: 20,
                                ),
                                onPressed: () {
                                  setState(() {
                                    // tasks.remove(task);
                                    DBProvider.db.deleteTask(task.id);
                                    _inEditMode = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        )
                      : Container(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getHeading() {
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
}

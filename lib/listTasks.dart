import 'package:flutter/material.dart';
import 'package:tasks/colors.dart';
import 'package:tasks/database.dart';
import 'package:tasks/task.dart';
import 'editTask.dart';

class ListTasks extends StatefulWidget {
  @override
  _ListTasksState createState() => _ListTasksState();
}

class _ListTasksState extends State<ListTasks> {
  double _initial = 0.0;
  double _drag = 0.0;
  bool _inEditMode = false;
  final double _listItemHeight = 68;
  List<Task> tasks = [];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Task>>(
      future: DBProvider.db.getTodaysTasks(),
      builder: (BuildContext context, AsyncSnapshot<List<Task>> snapshot) {
        if (snapshot.hasData) {
          return RefreshIndicator(
            onRefresh: () async {
              setState(() {});
            },
            child: ListView.builder(
              itemCount: snapshot.data.length + 1,
              itemBuilder: (BuildContext context, int i) {
                if (i == snapshot.data.length) {
                  return SizedBox(
                    height: 75,
                  );
                } else {
                  return buildItem(snapshot.data[i]);
                }
              },
            ),
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
                    DBProvider.db.updateCompletion(task);
                  });
                }
              } else if (_drag < 0) {
                if (task.completedParts != 0) {
                  setState(() {
                    task.completedParts -= 1;
                    DBProvider.db.updateCompletion(task);
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
                    Container(
                      height: _listItemHeight - 32,
                      width: MediaQuery.of(context).size.width - 116,
                      child: SingleChildScrollView(
                        child: Text(
                          task.title,
                          style: TextStyle(
                            color: CustomColors.darkBlue,
                            fontSize: 16,
                          ),
                        ),
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
                        color: (task.getCompletionPercentage() <= 0.89)
                            ? task.color
                            : Colors.white,
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
                                  ).then((value) {
                                    setState(() {});
                                  });
                                  setState(() {
                                    _inEditMode = false;
                                  });
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
}

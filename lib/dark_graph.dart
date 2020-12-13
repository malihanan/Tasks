import 'package:flutter/material.dart';
import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:tasks/colors.dart';
import 'package:tasks/database.dart';
import 'package:tasks/task.dart';
import 'package:tasks/widgets/heading.dart';

final Color darkBlue = Color.fromARGB(255, 18, 32, 47);

class DarkGraph extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.darkBlue,
      appBar: AppBar(
        backgroundColor: CustomColors.darkBlue,
        iconTheme: IconThemeData(color: Colors.grey[50]),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Heading(
                  top: "Your",
                  bottom: "Track",
                  color: Colors.grey[50],
                ),
                FutureBuilder<List<Feature>>(
                  future: getFeautures(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Feature>> snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LineGraph(
                              features: snapshot.data,
                              size: Size(
                                  MediaQuery.of(context).size.width - 32, 320),
                              labelX: [
                                'Day 1',
                                'Day 2',
                                'Day 3',
                                'Day 4',
                                'Day 5'
                              ],
                              labelY: ['20%', '40%', '60%', '80%', '100%'],
                              showDescription: true,
                              graphColor: Colors.grey[50],
                              fontFamily: 'Poppins',
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Expanded(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<List<Feature>> getFeautures() async {
  List<Task> tasks = await DBProvider.db.getAllTasks();
  List<Feature> features = [];
  tasks.sort((a, b) => a.datetime.compareTo(b.datetime));
  tasks.sort((a, b) => a.id.compareTo(b.id));
  int i = 0;
  while (i < tasks.length) {
    int j = i;
    List<double> data = [];
    data.add(tasks[i].getCompletionPercentage());
    i += 1;
    while (i < tasks.length && tasks[i].id == tasks[i - 1].id) {
      data.add(tasks[i].getCompletionPercentage());
      i += 1;
    }
    while (data.length < 5) {
      data.insert(0, 0);
    }
    features
        .add(Feature(data: data, color: tasks[j].color, title: tasks[j].title));
  }
  return features;
}

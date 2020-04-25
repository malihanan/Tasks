import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/database.dart';
import 'package:tasks/task.dart';

import 'colors.dart';

class AddTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddTaskState();
  }
}

class AddTaskState extends State<AddTask> {
  Task task = new Task();
  int _radioValue = 0;
  final formkey = GlobalKey<FormState>();
  bool _autoValidate = false;
  DBProvider db;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          task.color = CustomColors.pink;
          break;
        case 1:
          task.color = CustomColors.purple;
          break;
        case 2:
          task.color = CustomColors.blue;
          break;
        case 3:
          task.color = CustomColors.green;
          break;
        case 4:
          task.color = CustomColors.yellow;
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        color: Colors.grey[300],
        child: Center(
          child: new Card(
              color: Colors.white,
              margin: EdgeInsets.all(10.0),
              child: Form(
                key: formkey,
                autovalidate: _autoValidate,
                child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: new InputDecoration(
                            icon: Icon(Icons.title),
                            hintText: 'task title here..',
                            labelText: 'Title',
                          ),
                          onSaved: (String value) {
                            this.task.title = value;
                          },
                          validator: (value) {
                            return value.isEmpty
                                ? 'Task title cannot be empty'
                                : null;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: '1',
                          decoration: new InputDecoration(
                            icon: Icon(Icons.pie_chart),
                            hintText: 'No. of parts here...',
                            labelText: 'Total Parts',
                          ),
                          onSaved: (String value) {
                            this.task.parts = int.parse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Parts cannot be empty';
                            } else if (int.parse(value) > 25) {
                              return 'Parts cannot be more than 25';
                            } else {
                              return null;
                            }
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                'Color',
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Radio(
                                    value: 0,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                    activeColor: CustomColors.pink,
                                  ),
                                  Radio(
                                    value: 1,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                    activeColor: CustomColors.purple,
                                  ),
                                  Radio(
                                    value: 2,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                    activeColor: CustomColors.blue,
                                  ),
                                  Radio(
                                    value: 3,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                    activeColor: CustomColors.green,
                                  ),
                                  Radio(
                                    value: 4,
                                    groupValue: _radioValue,
                                    onChanged: _handleRadioValueChange,
                                    activeColor: CustomColors.yellow,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(12.0)),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          disabledColor: Colors.grey,
                          disabledTextColor: Colors.black,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.0,
                            vertical: 10.0,
                          ),
                          onPressed: () {
                            if (formkey.currentState.validate()) {
                              formkey.currentState.save();
                              // tasks.add(task);
                              DBProvider.db.newTask(task).then((var row) {
                                print(row.toString());
                                Navigator.of(context).pop(this);
                              });
                            } else {
                              _autoValidate = true;
                            }
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(fontSize: 20.0),
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        )
                      ],
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}

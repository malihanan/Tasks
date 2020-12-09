import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tasks/database.dart';
import 'package:tasks/task.dart';

import 'colors.dart';

class EditTask extends StatefulWidget {
  Task task;
  EditTask(Task task) {
    this.task = task;
  }

  @override
  State<StatefulWidget> createState() {
    return EditTaskState();
  }
}

class EditTaskState extends State<EditTask> {
  int _radioValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          widget.task.color = CustomColors.pink;
          break;
        case 1:
          widget.task.color = CustomColors.purple;
          break;
        case 2:
          widget.task.color = CustomColors.blue;
          break;
        case 3:
          widget.task.color = CustomColors.green;
          break;
        case 4:
          widget.task.color = CustomColors.yellow;
          break;
      }
    });
  }

  void _setRadio() {
    if (widget.task.color == CustomColors.pink) {
      _radioValue = 0;
    } else if (widget.task.color == CustomColors.purple) {
      _radioValue = 1;
    } else if (widget.task.color == CustomColors.blue) {
      _radioValue = 2;
    } else if (widget.task.color == CustomColors.green) {
      _radioValue = 3;
    } else {
      _radioValue = 4;
    }
  }

  final formkey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    _setRadio();
    // int index = tasks.indexOf(widget.task);
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
                          initialValue: widget.task.title,
                          decoration: new InputDecoration(
                            icon: Icon(Icons.title),
                            hintText: 'task title here..',
                            labelText: 'Title',
                          ),
                          onSaved: (String value) {
                            widget.task.title = value;
                          },
                          validator: (value) {
                            return value.isEmpty
                                ? 'Task title cannot be empty'
                                : null;
                          },
                        ),
                        TextFormField(
                          keyboardType: TextInputType.number,
                          initialValue: widget.task.parts.toString(),
                          decoration: new InputDecoration(
                            icon: Icon(Icons.pie_chart),
                            hintText: 'No. of parts here...',
                            labelText: 'Total Parts',
                          ),
                          onSaved: (String value) {
                            widget.task.parts = int.parse(value);
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
                              ),
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
                              // tasks.removeAt(index);
                              // tasks.insert(index, widget.task);
                              DBProvider.db.updateTask(widget.task);
                              Navigator.of(context).pop(this);
                            } else {
                              _autoValidate = true;
                            }
                          },
                          child: Text(
                            "Save",
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

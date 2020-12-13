import 'package:flutter/material.dart';
import 'package:tasks/colors.dart';

class Heading extends StatelessWidget {
  const Heading({
    Key key,
    this.top = "",
    this.bottom = "",
    this.color = CustomColors.darkBlue,
  }) : super(key: key);

  final String top;
  final String bottom;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                top,
                style: TextStyle(
                  fontSize: 18,
                  color: color,
                ),
              ),
              Text(
                bottom,
                style: TextStyle(
                  fontFamily: 'AbrilFatface',
                  fontSize: 28,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

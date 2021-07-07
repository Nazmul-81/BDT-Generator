import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

class OneRow extends StatelessWidget {
  final name;
  final value;

  const OneRow({Key key, @required this.name, @required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
              label: name,
              size: 30.0,
              color: Colors.white,
            ),
            MyText(
              label: value,
              size: 30.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ],
        ),
      ],
    );
  }
}

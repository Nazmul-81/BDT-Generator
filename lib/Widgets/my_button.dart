import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final name;
  final onPressed;

  const MyButton({Key key, @required this.name, @required this.onPressed})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: MaterialButton(
            onPressed: onPressed,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white12,
              ),
              child: MyText(
                label: name,
                size: 30.0,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

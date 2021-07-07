import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/constants.dart';
import 'package:flutter/material.dart';

class MyDrawerOption extends StatelessWidget {
  final title;
  final icon;
  const MyDrawerOption({Key key, @required this.title, @required this.icon})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 5,
        right: 5,
        left: 5,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: MyConstants.backGroundColor,
          borderRadius: BorderRadius.circular(10),
          // border: Border.all(
          //   color: Colors.black,
          // ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Icon(
                icon,
                color: Colors.white,
                size: 30,
              ),
            ),
            MyText(
              label: title,
              color: Colors.white,
              size: 16.0,
            ),
          ],
        ),
      ),
    );
  }
}

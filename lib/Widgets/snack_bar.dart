import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MySnackBar {
  SnackBar mySnackBar;
  MySnackBar(content, color, bgColor) {
    this.mySnackBar = SnackBar(
      content: MyText(
        label: content,
        size: 14.0,
        color: color,
      ),
      backgroundColor: bgColor,
    );
  }
}

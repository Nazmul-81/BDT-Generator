import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MyAdButton extends StatelessWidget {
  final onTap;

  const MyAdButton({Key key, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.transparent,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: MyText(
              label: "View Ads",
              size: 40.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

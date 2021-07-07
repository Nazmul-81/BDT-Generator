import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

class MyProfileRow extends StatelessWidget {
  final name;
  final value;

  const MyProfileRow({Key key, @required this.name, @required this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: MyText(
                label: name,
                size: 20.0,
                color: Colors.white,
              )),
          Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "$value",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Courgette',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              )),
        ],
      ),
    );
  }
}

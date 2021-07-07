import 'package:bdt_generator/Widgets/my_button.dart';
import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/screen/common.dart';
import 'package:bdt_generator/screen/profile/components/MyProfileRow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MySettingBody extends StatefulWidget {
  @override
  _MySettingBodyState createState() => _MySettingBodyState();
}

class _MySettingBodyState extends State<MySettingBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30,
          ),
          MyButton(
            name: "Rate Us",
            onPressed: () {},
          ),
          MyButton(
            name: "Support",
            onPressed: () {},
          ),
          MyButton(
            name: "Report a bug",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}

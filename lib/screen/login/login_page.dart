import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/constants.dart';
import 'package:bdt_generator/main.dart';
import 'package:bdt_generator/screen/Home/components/home_body.dart';
import 'package:bdt_generator/screen/drawer/drawer_page.dart';
import 'package:flutter/material.dart';

import 'components/login_body.dart';

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyConstants.backGroundColor,
        centerTitle: true,
        title: MyText(
          label: "BDT Generator",
        ),
      ),
      body: MyLoginBody(),
      backgroundColor: MyConstants.backGroundColor,
    );
  }
}

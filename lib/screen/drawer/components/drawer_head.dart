import 'package:bdt_generator/Widgets/rich_text.dart';
import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/constants.dart';
import 'package:bdt_generator/model/users.dart';
import 'package:flutter/material.dart';

class MyDrawerHead extends StatefulWidget {
  @override
  _MyDrawerHeadState createState() => _MyDrawerHeadState();
}

class _MyDrawerHeadState extends State<MyDrawerHead> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            padding: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white54,
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(
              //   color: Colors.black,
              // ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MyText(
                          label: "BDT Generator",
                          color: MyConstants.backGroundColor,
                          fontWeight: FontWeight.bold,
                          size: 30.0,
                          textAlignment: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: MyText(
                          label: myUserMeGlobal.name,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          size: 20.0,
                          textAlignment: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        child: MyRichText(
                          label: "Balance:",
                          labelSize: 18.0,
                          labelColor: Colors.white,
                          value: " ${myUserMeGlobal.point} ৳",
                          valueSize: 20.0,
                          valueFontWeight: FontWeight.bold,
                          labelFontWeight: FontWeight.normal,
                          valueColor: Colors.black,
                          textAlignment: TextAlign.start,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
      ],
    );
  }
}

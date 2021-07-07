import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/model/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomeBody extends StatefulWidget {
  @override
  _MyHomeBodyState createState() => _MyHomeBodyState();
}

class _MyHomeBodyState extends State<MyHomeBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: MyText(
              label: myUserMeGlobal.name.toUpperCase(),
              size: 40.0,
              color: Colors.white,
              textAlignment: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: MyText(
                  label: "Today income: ",
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
              MyText(
                label: "${myUserMeGlobal.todayIncome}",
                size: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: MyText(
                  label: "Last week income: ",
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
              MyText(
                label: "${myUserMeGlobal.lastWeekIncome}",
                size: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: MyText(
                  label: "Last year income: ",
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
              MyText(
                label: "${myUserMeGlobal.lastYearIncome}",
                size: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),*/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: MyText(
                  label: "Lifetime income: ",
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
              MyText(
                label: myUserMeGlobal.lifeTimeIncome,
                size: 30.0,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

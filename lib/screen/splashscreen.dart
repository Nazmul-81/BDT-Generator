import 'dart:convert';
import 'dart:io';
import 'package:check_vpn_connection/check_vpn_connection.dart';
import 'package:bdt_generator/constants.dart';
import 'package:bdt_generator/model/users.dart';
import 'package:bdt_generator/screen/Home/home_page.dart';
import 'package:bdt_generator/screen/login/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MySplashScreen extends StatefulWidget {
  @override
  _MySplashScreenState createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2)).then((value) async {
      if (!await CheckVpnConnection.isVpnActive()) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Sorry!!!'),
                  content: SingleChildScrollView(
                    child: Theme(
                      data: ThemeData.dark(),
                      child: ListBody(
                        children: <Widget>[
                          Text(
                              'VPN is not Connected.\nPlease connect your VPN.'),
                        ],
                      ),
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: Text('Ok'),
                      onPressed: () {
                        exit(0);
                        //Navigator.of(context).pop();
                      },
                    ),
                  ],
                ));
      } else {
        if (FirebaseAuth.instance.currentUser != null) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser.uid)
              .get()
              .then((doc) {
            setUserGlobal(doc);
            //print(myUserMeGlobal.todayIncome);
          }).then((value) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => MyHomePage()));
          });
        } else {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => MyLoginPage()));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstants.backGroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage("assets/image/logo-bdt.PNG"),
          ),
        ],
      ),
    );
  }
}

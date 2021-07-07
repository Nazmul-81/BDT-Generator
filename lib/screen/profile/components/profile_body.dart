import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/model/users.dart';
import 'package:bdt_generator/screen/common.dart';
import 'package:bdt_generator/screen/profile/components/MyProfileRow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyProfileBody extends StatefulWidget {
  @override
  _MyProfileBodyState createState() => _MyProfileBodyState();
}

class _MyProfileBodyState extends State<MyProfileBody> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Something went wrong'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading"),
            );
          }
          final doc = snapshot.data;
          setUserGlobal(doc);
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                MyProfileRow(
                  name: "Name ",
                  value: myUserMeGlobal.name,
                ),
                MyProfileRow(
                  name: "Email ",
                  value: myUserMeGlobal.email,
                ),
                MyProfileRow(
                  name: "Number ",
                  value: myUserMeGlobal.mobile,
                ),
              ],
            ),
          );
        });
  }
}

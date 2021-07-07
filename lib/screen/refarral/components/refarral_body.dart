import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/model/users.dart';
import 'package:bdt_generator/screen/common.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyReferralBody extends StatefulWidget {
  @override
  _MyReferralBodyState createState() => _MyReferralBodyState();
}

class _MyReferralBodyState extends State<MyReferralBody> {
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
          MyUser.setReferrals();
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 30,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MyText(
                      label: "Referral Code: ",
                      size: 30.0,
                      color: Colors.white,
                    ),
                    InkWell(
                      onLongPress: () {
                        print("LONG>>>");
                        Clipboard.setData(
                            new ClipboardData(text: "${myUserMeGlobal.uid}"));
                        final snackBar = SnackBar(
                            content: MyText(
                          label: "Code Copied",
                        ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          color: Colors.white12,
                          child: MyText(
                            label: myUserMeGlobal.uid,
                            size: 30.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                OneRow(
                  name: "Total Referral: ",
                  value: myUserMeGlobal.totalReferral,
                ),
                /*OneRow(
                  name: "Referral Yearly: ",
                  value: myUserMeGlobal.referralYearly,
                ),*/
                OneRow(
                  name: "Your Commission: ",
                  value: myUserMeGlobal.commission,
                ),
                SizedBox(
                  height: 60,
                ),
                MaterialButton(
                  onPressed: () {
                    print("Add to Balance...");
                    _addToBalance();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white12,
                    ),
                    padding: EdgeInsets.all(5),
                    child: Center(
                      child: OneRow(
                        name: "Add to balance",
                        value: "",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  _addToBalance() {
    addTransaction(myUserMeGlobal.uid, myUserMeGlobal.commission).then((value) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(myUserMeGlobal.uid)
          .update({
        'referral': [
          {'date': DateTime.now(), 'amount': 0},
        ]
      });
    });
  }
}

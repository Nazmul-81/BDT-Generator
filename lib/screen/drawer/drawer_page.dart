import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/constants.dart';
import 'package:bdt_generator/model/users.dart';
import 'package:bdt_generator/screen/Home/home_page.dart';
import 'package:bdt_generator/screen/drawer/components/drawer_head.dart';
import 'package:bdt_generator/screen/login/login_page.dart';
import 'package:bdt_generator/screen/profile/profile_page.dart';
import 'package:bdt_generator/screen/refarral/refarel_page.dart';
import 'package:bdt_generator/screen/settings/setting_page.dart';
import 'package:bdt_generator/screen/view_ad/view_ad_page.dart';
import 'package:bdt_generator/screen/wallet/components/wallet_body.dart';
import 'package:bdt_generator/screen/wallet/wallet_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/drawer_option.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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
          return Drawer(
            child: Container(
              decoration: BoxDecoration(
                color: MyConstants.backGroundColor,
              ),
              child: Column(
                children: [
                  MyDrawerHead(),
                  Expanded(
                    child: Container(
                      color: Colors.white12,
                      child: ListView(
                        children: [
                          _createOption("Home", Icons.home_outlined, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()));
                          }),
                          _createOption("My Profile", Icons.person_outline, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyProfilePage()));
                          }),
                          _createOption("View Ads", Icons.ad_units_outlined,
                              () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyViewAd()));
                          }),
                          _createOption(
                              "Wallet", Icons.monetization_on_outlined, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyWalletPage()));
                          }),
                          _createOption("Referral", Icons.send_outlined, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyReferralPage()));
                          }),
                          Divider(),
                          /*_createOption("Settings", Icons.settings, () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MySettingPage()));
                          }),
                          _createOption(
                              "Contact Us", Icons.contact_phone, () {}),*/
                          _createOption("LOG OUT", Icons.logout, () {
                            FirebaseAuth.instance.signOut();

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyLoginPage()),
                                (route) => false);
                          }),
                          /*_createOption("DELETE ACCOUNT", Icons.delete_forever, () {
                          _deleteEvent();
                        }),*/
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  /*Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.green,
                      ),
                      child: MyText(
                        label: "Support Us 👎",
                        color: Colors.white,
                      ),
                    ),
                  ),*/
                ],
              ),
            ),
          );
        });
  }

  Widget _createOption(title, icon, onPressed) {
    return MaterialButton(
      onPressed: onPressed,
      child: MyDrawerOption(
        icon: icon,
        title: title,
      ),
    );
  }
}

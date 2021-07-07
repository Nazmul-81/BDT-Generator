import 'dart:convert';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/constants.dart';
import 'package:bdt_generator/main.dart';
import 'package:bdt_generator/model/users.dart';
import 'package:bdt_generator/screen/Home/components/home_body.dart';
import 'package:bdt_generator/screen/drawer/drawer_page.dart';
import 'package:bdt_generator/screen/view_ad/components/view_ad_body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  AdmobBannerSize bannerSize;
  @override
  void initState() {
    bannerSize = AdmobBannerSize.BANNER;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
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
            return Scaffold(
              /*bottomNavigationBar: AdmobBanner(
                adUnitId: 'ca-app-pub-4550806482988442/2004810023',
                adSize: AdmobBannerSize.BANNER,
                listener: (AdmobAdEvent event, Map<String, dynamic> args) {
                  //handleEvent(event, args, 'Banner');
                },
                onBannerCreated: (AdmobBannerController controller) {
                  //controller.dispose();
                },
              ),*/
              appBar: AppBar(
                backgroundColor: MyConstants.backGroundColor,
                centerTitle: true,
                title: MyText(
                  label: "BDT Generator",
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 5,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                        ),
                      ),
                      child: MyText(
                        label: "${myUserMeGlobal.point} ৳",
                        size: 16.0,
                      ),
                    ),
                  )
                ],
              ),
              drawer: MyDrawer(),
              body: MyHomeBody(),
              backgroundColor: MyConstants.backGroundColor,
            );
          }),
    );
  }

  void handleEvent(
      AdmobAdEvent event, Map<String, dynamic> args, String adType) {
    switch (event) {
      case AdmobAdEvent.loaded:
        showSnackBar('New Admob $adType Ad loaded!');
        break;
      case AdmobAdEvent.opened:
        showSnackBar('Admob $adType Ad opened!');
        break;
      case AdmobAdEvent.closed:
        showSnackBar('Admob $adType Ad closed!');
        break;
      case AdmobAdEvent.failedToLoad:
        showSnackBar('Admob $adType failed to load. :(');
        break;
      case AdmobAdEvent.rewarded:
        print("REWARD ---------------------------------");
        print(args['type']);
        print(args['amount']);
        FirebaseFirestore.instance
            .collection('users')
            .doc(myUserMeGlobal.uid)
            .update({'point': myUserMeGlobal.point + args['amount']});
        break;
      default:
    }
  }

  void showSnackBar(String content) {
    final snackBar = SnackBar(
      content: Text(content),
      duration: Duration(milliseconds: 1500),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }
}

import 'package:admob_flutter/admob_flutter.dart';
import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/constants.dart';
import 'package:flutter/material.dart';

import 'components/profile_body.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomNavigationBar: AdmobBanner(
        adUnitId: 'ca-app-pub-4550806482988442/4911009111',
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
          label: "Profile",
        ),
      ),
      body: MyProfileBody(),
      backgroundColor: MyConstants.backGroundColor,
    );
  }
}

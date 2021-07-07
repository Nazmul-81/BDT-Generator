import 'package:admob_flutter/admob_flutter.dart';
import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/screen/Home/components/home_body.dart';
import 'package:bdt_generator/screen/view_ad/components/view_ad_body.dart';
import 'package:flutter/material.dart';

import 'package:bdt_generator/constants.dart';

class MyViewAd extends StatefulWidget {
  @override
  _MyViewAdState createState() => _MyViewAdState();
}

class _MyViewAdState extends State<MyViewAd> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomNavigationBar: AdmobBanner(
        adUnitId: 'ca-app-pub-4550806482988442/7782576851',
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
          label: "View Ads",
        ),
      ),
      body: MyViewAdBody(),
      backgroundColor: MyConstants.backGroundColor,
    );
  }
}

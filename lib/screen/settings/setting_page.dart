import 'package:admob_flutter/admob_flutter.dart';
import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'package:bdt_generator/constants.dart';
import 'components/setting_body.dart';

class MySettingPage extends StatefulWidget {
  @override
  _MySettingPageState createState() => _MySettingPageState();
}

class _MySettingPageState extends State<MySettingPage> {
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
          label: "Profile",
        ),
      ),
      body: MySettingBody(),
      backgroundColor: MyConstants.backGroundColor,
    );
  }
}

import 'package:admob_flutter/admob_flutter.dart';
import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/model/users.dart';
import 'package:flutter/material.dart';

import 'package:bdt_generator/constants.dart';
import 'components/refarral_body.dart';

class MyReferralPage extends StatefulWidget {
  @override
  _MyReferralPageState createState() => _MyReferralPageState();
}

class _MyReferralPageState extends State<MyReferralPage> {
  @override
  void initState() {
    MyUser.setReferrals();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: AdmobBanner(
        adUnitId: 'ca-app-pub-4550806482988442/3597927449',
        adSize: AdmobBannerSize.BANNER,
        listener: (AdmobAdEvent event, Map<String, dynamic> args) {
          //handleEvent(event, args, 'Banner');
        },
        onBannerCreated: (AdmobBannerController controller) {
          //controller.dispose();
        },
      ),
      appBar: AppBar(
        backgroundColor: MyConstants.backGroundColor,
        centerTitle: true,
        title: MyText(
          label: "Referral",
        ),
      ),
      body: MyReferralBody(),
      backgroundColor: MyConstants.backGroundColor,
    );
  }
}

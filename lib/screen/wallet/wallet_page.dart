import 'package:admob_flutter/admob_flutter.dart';
import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:flutter/material.dart';

import 'package:bdt_generator/constants.dart';
import 'components/wallet_body.dart';

class MyWalletPage extends StatefulWidget {
  @override
  _MyWalletPageState createState() => _MyWalletPageState();
}

class _MyWalletPageState extends State<MyWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*bottomNavigationBar: AdmobBanner(
        adUnitId: 'ca-app-pub-4550806482988442/9125586293',
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
          label: "Wallet",
        ),
      ),
      body: MyWalletBody(),
      backgroundColor: MyConstants.backGroundColor,
    );
  }
}

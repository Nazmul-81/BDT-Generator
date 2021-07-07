import 'dart:io';

import 'package:admob_flutter/admob_flutter.dart';
import 'package:bdt_generator/Widgets/text_widget.dart';
import 'package:bdt_generator/model/users.dart';
import 'package:bdt_generator/screen/view_ad/components/ad_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyViewAdBody extends StatefulWidget {
  @override
  _MyViewAdBodyState createState() => _MyViewAdBodyState();
}

class _MyViewAdBodyState extends State<MyViewAdBody> {
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey();
  AdmobBannerSize bannerSize;

  AdmobInterstitial interstitialAd;
  AdmobInterstitial interstitialAd2;

  AdmobReward rewardAd;
  AdmobReward rewardAd2;
  AdmobReward rewardAd3;
  AdmobReward rewardAd4;
  AdmobReward rewardAd5;

  @override
  void initState() {
    bannerSize = AdmobBannerSize.BANNER;

    interstitialAd = AdmobInterstitial(
      adUnitId: 'ca-app-pub-4550806482988442/8458553648',
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );
    interstitialAd2 = AdmobInterstitial(
      adUnitId: 'ca-app-pub-4550806482988442/4519308630',
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
        handleEvent(event, args, 'Interstitial');
      },
    );

    ///reward

    rewardAd = AdmobReward(
      adUnitId: 'ca-app-pub-4550806482988442/5191470862',
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd.load();
        handleEvent(event, args, 'Reward');
      },
    );
    rewardAd2 = AdmobReward(
      adUnitId: 'ca-app-pub-4550806482988442/6642199627',
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd2.load();
        handleEvent(event, args, 'Reward');
      },
    );
    rewardAd3 = AdmobReward(
      adUnitId: 'ca-app-pub-4550806482988442/7763709600',
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd3.load();
        handleEvent(event, args, 'Reward');
      },
    );
    rewardAd4 = AdmobReward(
      adUnitId: 'ca-app-pub-4550806482988442/2511382927',
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd4.load();
        handleEvent(event, args, 'Reward');
      },
    );
    rewardAd5 = AdmobReward(
      adUnitId: 'ca-app-pub-4550806482988442/7572137913',
      listener: (AdmobAdEvent event, Map<String, dynamic> args) {
        if (event == AdmobAdEvent.closed) rewardAd5.load();
        handleEvent(event, args, 'Reward');
      },
    );

    interstitialAd.load();
    interstitialAd2.load();

    rewardAd.load();
    rewardAd2.load();
    rewardAd3.load();
    rewardAd4.load();
    rewardAd5.load();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /* MyAdButton(
            onTap: () async {
              if (await interstitialAd.isLoaded) {
                interstitialAd.show();
              } else {
                showSnackBar('Interstitial ad is still loading...');
              }
            },
          ),
          MyAdButton(
            onTap: () async {
              if (await interstitialAd2.isLoaded) {
                interstitialAd2.show();
              } else {
                showSnackBar('Interstitial ad is still loading...');
              }
            },
          ),*/

          ///reward

          MyAdButton(
            onTap: () async {
              print(rewardAd.adUnitId);
              if (await rewardAd.isLoaded) {
                rewardAd.show();
              } else {
                showSnackBar('Reward ad is still loading...');
              }
            },
          ),
          MyAdButton(
            onTap: () async {
              print(rewardAd2.adUnitId);
              if (await rewardAd2.isLoaded) {
                rewardAd2.show();
              } else {
                showSnackBar('Reward ad is still loading...');
              }
            },
          ),
          MyAdButton(
            onTap: () async {
              print(rewardAd3.adUnitId);
              if (await rewardAd3.isLoaded) {
                rewardAd3.show();
              } else {
                showSnackBar('Reward ad is still loading...');
              }
            },
          ),
          MyAdButton(
            onTap: () async {
              print(rewardAd4.adUnitId);
              if (await rewardAd4.isLoaded) {
                rewardAd4.show();
              } else {
                showSnackBar('Reward ad is still loading...');
              }
            },
          ),
          MyAdButton(
            onTap: () async {
              print(rewardAd5.adUnitId);
              if (await rewardAd5.isLoaded) {
                rewardAd5.show();
              } else {
                showSnackBar('Reward ad is still loading...');
              }
            },
          ),
        ],
      ),
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
        print(
            "REWARD DDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD---------------------------------");
        print(args['type']);
        print(args['amount']);
        addBalance(args['amount']);
        break;
      default:
    }
  }

  void showSnackBar(String content) {
    final snackBar = SnackBar(
      content: Text(content),
      duration: Duration(milliseconds: 1500),
    );
    //Scaffold.of(context).showSnackBar(snackBar);
  }

  addBalance(amount) {
    addTransaction(myUserMeGlobal.uid, amount).then((value) {
      showSnackBar("Reward added");
    });
  }
}

String getBannerAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/2934735716';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-8498094515921487/2571732331';
    //return 'ca-app-pub-3940256099942544/6300978111';
  }
  return null;
}

String getInterstitialAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/4411468910';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-8498094515921487/2291560537';
    //return 'ca-app-pub-8498094515921487/4618121804';
    //return 'ca-app-pub-3940256099942544/1033173712';
  }
  return null;
}

String getRewardBasedVideoAdUnitId() {
  if (Platform.isIOS) {
    return 'ca-app-pub-3940256099942544/1712485313';
  } else if (Platform.isAndroid) {
    return 'ca-app-pub-8498094515921487/9487305109';
    //return 'ca-app-pub-3940256099942544/5224354917';
  }
  return null;
}

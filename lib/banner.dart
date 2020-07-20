import 'package:flutter/material.dart';
import 'package:firebase_admob/firebase_admob.dart';
class BannerAdPage extends StatefulWidget {
  @override
  _BannerAdPageState createState() => _BannerAdPageState();
}
class _BannerAdPageState extends State<BannerAdPage> {
  BannerAd myBanner;
  BannerAd buildBannerAd() {
    return BannerAd(
        adUnitId: 'ca-app-pub-9094776014270262/1464623396',
        size: AdSize.banner,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            myBanner..show();
          }
        });
  }
  BannerAd buildLargeBannerAd() {
    return BannerAd(
        adUnitId: 'ca-app-pub-9094776014270262/1464623396',
        size: AdSize.largeBanner,
        listener: (MobileAdEvent event) {
          if (event == MobileAdEvent.loaded) {
            myBanner
              ..show(
                  anchorType: AnchorType.top,
                  anchorOffset: MediaQuery.of(context).size.height * 0.15);
          }
        });
  }
  @override
  void initState() {
    super.initState();
    FirebaseAdMob.instance.initialize(appId:'ca-app-pub-9094776014270262~2969276754');
    myBanner = buildBannerAd()..load();
    myBanner = buildLargeBannerAd()..load();
  }
  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return SizedBox(width: 0,);
  }
}
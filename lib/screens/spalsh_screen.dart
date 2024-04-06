
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screen_track.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = "SplashScreen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    fbm.subscribeToTopic("newCourse");
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushNamed(LoginScreen.routeName);
    });
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("SplashScreen", "/SplashScreen");
    //screenTrack.blockSs();
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/logo/background.png'),
                fit: BoxFit.cover)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: queryData.size.height * 0.04,
            ),
            Center(
              child: Container(
                width: queryData.size.width * 0.4,
                height: queryData.size.height * 0.2,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0)
                ),
                  child: Image.asset('images/logo/logos.jpg',fit: BoxFit.cover,)),
            ),
            SizedBox(
              height: queryData.size.height * 0.05,
            ),
            const Text(
              "Avinya",
              style: TextStyle(
                  color: Color(0xFF020064),
                  fontSize: 28,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: queryData.size.height * 0.02,
            ),
            const Text(
              "Learn from anything and anywhere",
              style: TextStyle(
                  color: Color(0xFF020064),
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
          ],
        )),
      ),
    );
  }
}

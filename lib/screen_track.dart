import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

class FIrebaseScreenTrack {
  Future screenTrack(String screenName,String screenClass) async {
    await FirebaseAnalytics.instance.setCurrentScreen(screenName: screenName).then((value) => print("posted for $screenName"));
  }

  Future blockSs() async {
    await FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }
}

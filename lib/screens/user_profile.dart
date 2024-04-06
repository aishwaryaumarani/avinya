import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:rate_my_app/rate_my_app.dart';
import 'package:share_plus/share_plus.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import 'about.dart';
import 'app_review.dart';
import 'course_complete.dart';
import 'edit_profile.dart';
import 'faq_screen.dart';
import 'spalsh_screen.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  FutureOr callSetState(dynamic value) {
    //print("calling ittt");
    setState(() {});
  }

  RateMyApp rateMyApp = RateMyApp(
    preferencesPrefix: 'rateMyApp_',
    googlePlayIdentifier: "com.esparse.avinya",
    minDays: 0,
    minLaunches: 10,
    remindDays: 14,
    remindLaunches: 20,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("UserProfileScreen", "/UserProfileScreen");
    rateMyApp.init();
    //screenTrack.blockSs();
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Account",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    width: queryData.size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.black,
                          backgroundImage:
                              const AssetImage('images/logo/logos.jpg'),
                        ),
                        SizedBox(
                          height: queryData.size.height * 0.02,
                        ),
                        Text(
                          "${getAllCourses.uName}",
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        SizedBox(
                          height: queryData.size.height * 0.01,
                        ),
                        Text(
                          "${getAllCourses.uMail}",
                          style: const TextStyle(
                              fontSize: 22, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.08,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(
                    //   "Account Settings",
                    //   style: TextStyle(color: Colors.grey),
                    // ),
                    // SizedBox(
                    //   height: queryData.size.height * 0.03,
                    // ),
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(
                              name: EditProfileScreen.routeName),
                          screen: const EditProfileScreen(),
                          withNavBar: false,
                        ).then(callSetState);
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Update Profile",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        // PersistentNavBarNavigator
                        //     .pushNewScreenWithRouteSettings(
                        //   context,
                        //   settings: RouteSettings(
                        //       name: AppReviewScreen.routeName),
                        //   screen: const AppReviewScreen(),
                        //   withNavBar: false,
                        // );
                        rateMyApp.showStarRateDialog(
                          context,
                          title: 'Rate Us',
                          message:
                              'Share your Avinya App experience on the Google Playstore ',
                          actionsBuilder: (context, stars) {
                            return [
                              RateMyAppRateButton(
                                rateMyApp,
                                text: 'OK',
                              ),
                              RateMyAppNoButton(rateMyApp, text: 'CANCEL')
                            ];
                          },
                          dialogStyle: const DialogStyle(
                            titleAlign: TextAlign.center,
                            messageAlign: TextAlign.center,
                            messagePadding: EdgeInsets.only(bottom: 20),
                          ),
                          starRatingOptions: const StarRatingOptions(),
                          onDismissed: () => rateMyApp.callEvent(
                              RateMyAppEventType.laterButtonPressed),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Rate",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.chevron_right,color: Colors.black,)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(
                              name: CourseComplete.routeName),
                          screen: const CourseComplete(),
                          withNavBar: false,
                        ).then(callSetState);
                      },
                      child: Container(
                        child: Row(
                          mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Certificates",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.chevron_right,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height * 0.03,
                    ),
                    // Text(
                    //   "Support",
                    //   style: TextStyle(color: Colors.grey),
                    // ),
                    // SizedBox(
                    //   height: queryData.size.height * 0.03,
                    // ),
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings:
                              RouteSettings(name: FaqScreen.routeName),
                          screen: const FaqScreen(),
                          withNavBar: false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Frequently asked questions",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.chevron_right,color: Colors.black,)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings:
                              RouteSettings(name: AboutScreen.routeName),
                          screen: const AboutScreen(),  
                          withNavBar: false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "About Avinya App",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.chevron_right,color: Colors.black,)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        Share.share(
                            'check out our app https://play.google.com/store/apps/details?id=com.bussiness.esparse_solution');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Share Avinya App",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.chevron_right,color: Colors.black,)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height * 0.03,
                    ),
                    InkWell(
                      onTap: () {
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings:
                              RouteSettings(name: SplashScreen.routeName),
                          screen: const SplashScreen(),
                          withNavBar: false,
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "LOG OUT",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          Icon(Icons.chevron_right,color: Colors.black,)
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

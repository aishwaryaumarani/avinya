import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import 'detailed_course.dart';
import 'notification_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "HomeScreen";
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("HomeScreen", "/HomeScreen");
    //screenTrack.blockSs();
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context).size;
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    String args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.white,
                          backgroundImage: AssetImage('images/logo/logos.jpg'),
                        ),
                        SizedBox(
                          width: queryData.width * 0.04,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Welcome ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              "${getAllCourses.uName}",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 1.0,
                              offset: const Offset(0, 10),
                              spreadRadius: 0.5,
                            ),
                          ],
                      ),
                      child: IconButton(
                        onPressed: () => PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(
                            name: NotificationScreen.routeName,
                          ),
                          screen: const NotificationScreen(),
                          withNavBar: true,
                        ),
                        icon: Icon(
                          Icons.notifications_active_outlined,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: queryData.height * 0.05,
                ),
                Image.asset("images/logo/banner.png"),
                SizedBox(
                  height: queryData.height * 0.05,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Recommendation",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: queryData.height * 0.03,
                    ),
                    FutureBuilder(
                      future: getAllCourses.getAllCourses(),
                      builder: (context, snapshot) {
                        List list = [];
                        if (snapshot.hasData) {
                          String aa;
                          list = (snapshot.data! as Map)['data'].map((e) {
                            if (args.toLowerCase().contains(e["Category"][0]
                                    ["CategoryName"]
                                .toLowerCase()
                                .trim())) {
                              return e;
                            } else {
                              return;
                            }
                          }).toList();
                          list.removeWhere((element) => element == null);
                        }
                        return snapshot.hasData
                            ? (list.isNotEmpty
                                ? ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    reverse: false,
                                    itemCount: list.length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 20.0),
                                        child: InkWell(
                                          onTap: () async {
                                            // var result = await getAllCourses.addToCart("${(snapshot.data! as Map)['data'][index]['CourseId']}", context);
                                            // print("my result is $result");
                                            //Navigator.of(context).pushNamed(ReviewScreen.routeName, arguments: (snapshot.data! as Map)['data'][index] );
                                            // pushNewScreenWithRouteSettings(
                                            //   context,
                                            //   settings: RouteSettings(name: ReviewScreen.routeName,arguments: (snapshot.data! as Map)['data'][index]),
                                            //   screen: const ReviewScreen(),
                                            //   withNavBar: false,
                                            // );
                                            PersistentNavBarNavigator
                                                .pushNewScreenWithRouteSettings(
                                              context,
                                              settings: RouteSettings(
                                                  name: DetailedCourseScreen
                                                      .routeName,
                                                  arguments: list[index]),
                                              screen:
                                                  const DetailedCourseScreen(),
                                              withNavBar: false,
                                            );
                                            //print(list[index]);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    blurRadius: 10.0,
                                                    offset:
                                                        const Offset(0, 10),
                                                    spreadRadius: 1,
                                                  ),
                                                ],
                                                border: Border.all(
                                                    color: Colors.black),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20.0),
                                                color: Colors.white),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          "${list[index]['CourseName']}",
                                                          style:
                                                              const TextStyle(
                                                            color:
                                                                Colors.black,
                                                            fontSize: 16,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: queryData
                                                                  .height *
                                                              0.02,
                                                        ),
                                                        Text(
                                                          "₹ ${list[index]['CoursePrice']}",
                                                          style: const TextStyle(
                                                              color: Colors
                                                                  .black,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                        SizedBox(
                                                          height: queryData
                                                                  .height *
                                                              0.02,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            const Icon(
                                                              Icons.star,
                                                              color: Color(
                                                                  0xFFFFC960),
                                                            ),
                                                            SizedBox(
                                                              width: queryData
                                                                      .width *
                                                                  0.02,
                                                            ),
                                                            const Text(
                                                              "4.5",
                                                              style:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: queryData
                                                                      .width *
                                                                  0.02,
                                                            ),
                                                            Text(
                                                              "•",
                                                              style:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            SizedBox(
                                                              width: queryData
                                                                      .width *
                                                                  0.02,
                                                            ),
                                                            Text(
                                                              "Dr. Sandip Gawate",
                                                              style:
                                                                  TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                            // SizedBox(
                                                            //   width: queryData.size.width * 0.02,
                                                            // ),
                                                            // Text(
                                                            //   "•",
                                                            //   style: TextStyle(
                                                            //     color: Colors.black.withOpacity(0.5),
                                                            //     fontSize: 14,
                                                            //   ),
                                                            // ),
                                                            // SizedBox(
                                                            //   width: queryData.size.width * 0.02,
                                                            // ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: queryData
                                                                  .height *
                                                              0.02,
                                                        ),
                                                        Text(
                                                          "All Level",
                                                          style: TextStyle(
                                                            color: Colors
                                                                .black
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: queryData.width *
                                                        0.05,
                                                  ),
                                                  Container(
                                                    width: 60,
                                                    height: 60,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                        color: const Color(
                                                            0xFF970909)),
                                                    child: const Center(
                                                        child: Icon(
                                                      Icons.circle,
                                                      color:
                                                          Color(0x2BFFFFFF),
                                                    )),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Text(
                                    "No Course In this Category",
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  )))
                            : const Center(
                                child: CircularProgressIndicator());
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: queryData.height * 0.01,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

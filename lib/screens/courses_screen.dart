import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import 'detailed_course.dart';

class CourseScreen extends StatefulWidget {
  static const routeName = "CourseScreen";
  const CourseScreen({Key? key}) : super(key: key);

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  bool showProgress = true;
  bool showDones = false;
  BuildContext? dialogContext;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("CourseScreen", "/CourseScreen");
    //screenTrack.blockSs();
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF2B2B2D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "My Courses",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: FutureBuilder(
              future: getAllCourses.getLessonCompleted(),
              builder: (context, snapshot) {
                List progress = [];
                List done = [];
                if (snapshot.hasData) {
                  for (var element in (snapshot.data as Map)["data"]) {
                    if (element["lesson"].length ==
                        element["lessonComplated"].length) {
                      done.add(element);
                    } else {
                      progress.add(element);
                    }
                  }
                  print("progress is $progress");
                  print("completed is $done");
                }
                return snapshot.hasData
                    ? Column(
                        children: [
                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: queryData.size.width/2,
                                decoration: BoxDecoration(
                                color:showProgress?Color(0xFF4169E1) : Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        showProgress = true;
                                        showDones = false;
                                      });
                                    },
                                    child: Center(
                                      child: Text(
                                        "In Progress",
                                        style: TextStyle(
                                            color: showProgress
                                                ? Colors.black
                                                    .withOpacity(0.5)
                                                : Colors.black
                                                    .withOpacity(0.25),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                 width: queryData.size.width/2,
                                decoration: BoxDecoration(
                                color:!showProgress?Color(0xFF4169E1) : Colors.white),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        showProgress = false;
                                        showDones = true;
                                      });
                                    },
                                    child: Center(
                                      child: Text(
                                        "Done",
                                        style: TextStyle(
                                            color: !showDones
                                                ? Colors.black
                                                    .withOpacity(0.25)
                                                : Colors.black
                                                    .withOpacity(0.55),
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                Visibility(
                                  visible: showProgress,
                                  child: Column(
                                    children: [
                                      progress.isNotEmpty
                                          ? ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              reverse: false,
                                              itemCount: progress.length,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        //print((snapshot.data as Map)["data"][index]["Course"][0]["CourseId"]);
                                                        //dialogContext = context;
                                                        //_lodingSection();
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                            "Please Wait While Loading!!",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white),
                                                          ),
                                                          backgroundColor:
                                                              Colors.black,
                                                        ));
                                                        var result = await getAllCourses
                                                            .getCourseByCOurseId(progress[ index]["Course"][0]["CourseId"]);
                                                        print(result["data"][0]);
                                                        //Navigator.of(context).pop(dialogContext);
                                                        //ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                        PersistentNavBarNavigator
                                                            .pushNewScreenWithRouteSettings(
                                                          context,
                                                          settings: RouteSettings(
                                                              name:
                                                                  DetailedCourseScreen
                                                                      .routeName,
                                                              arguments:
                                                                  result["data"]
                                                                      [0]),
                                                          screen:
                                                              const DetailedCourseScreen(),
                                                          withNavBar: false,
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey
                                                                    .withOpacity(
                                                                        0.3),
                                                                blurRadius: 10.0,
                                                                offset:
                                                                    const Offset(
                                                                        0, 10),
                                                                spreadRadius: 1,
                                                              ),
                                                            ],
                                                            border: Border.all(
                                                                color:
                                                                    Colors.black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                            color: Colors.white),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
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
                                                                      progress[index]["Course"].isNotEmpty
                                                                       ? "${progress[index]["Course"][0]['CourseName']}"
                                                                       : '',
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: queryData
                                                                              .size
                                                                              .height *
                                                                          0.02,
                                                                    ),
                                                                    Text(
                                                                      progress[index]["Course"].isNotEmpty
                                                                      ? "₹ ${progress[index]["Course"][0]['CoursePrice']}"
                                                                      : '',
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    SizedBox(
                                                                      height: queryData
                                                                              .size
                                                                              .height *
                                                                          0.02,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .star,
                                                                          color: Color(
                                                                              0xFFFFC960),
                                                                        ),
                                                                        SizedBox(
                                                                          width: queryData.size.width *
                                                                              0.02,
                                                                        ),
                                                                        const Text(
                                                                          "4.5",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                14,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: queryData.size.width *
                                                                              0.02,
                                                                        ),
                                                                        Text(
                                                                          "•",
                                                                          style:
                                                                              TextStyle(
                                                                            color: Colors
                                                                                .black
                                                                                .withOpacity(0.5),
                                                                            fontSize:
                                                                                14,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: queryData.size.width *
                                                                              0.02,
                                                                        ),
                                                                        Text(
                                                                          progress[index]["Course"].isNotEmpty
                                                                          ? "${progress[index]["Course"][0]['AuthorName']}"
                                                                          : '',
                                                                          style:
                                                                              TextStyle(
                                                                            color: Colors
                                                                                .black
                                                                                .withOpacity(0.5),
                                                                            fontSize:
                                                                                14,
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
                                                                              .size
                                                                              .height *
                                                                          0.02,
                                                                    ),
                                                                    Text(
                                                                      "All Level",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.5),
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: queryData
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                              ),
                                                              Container(
                                                                width: 60,
                                                                height: 60,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                15),
                                                                    color: const Color(
                                                                        0xFF970909)),
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Icon(
                                                                  Icons.circle,
                                                                  color: Color(
                                                                      0x2BFFFFFF),
                                                                )),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          queryData.size.height *
                                                              0.04,
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          : Center(
                                              child: Text(
                                              "No In-progress Course",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            )),
                                    ],
                                  ),
                                ),
                                Visibility(
                                  visible: showDones,
                                  child: Column(
                                    children: [
                                      done.isNotEmpty
                                          ? ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              reverse: false,
                                              itemCount: done.length,
                                              scrollDirection: Axis.vertical,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    InkWell(
                                                      onTap: () async {
                                                        //print((snapshot.data as Map)["data"][index]["Course"][0]["CourseId"]);
                                                        //dialogContext = context;
                                                        //_lodingSection();
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                const SnackBar(
                                                          content: Text(
                                                            "Please Wait While Loading!!",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white),
                                                          ),
                                                          backgroundColor:
                                                              Colors.black,
                                                        ));
                                                        var result = await getAllCourses
                                                            .getCourseByCOurseId(done[index]["Course"][0]["CourseId"]);
                                                        print(result["data"][0]);
                                                        //Navigator.of(context).pop(dialogContext);
                                                        //ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                                        PersistentNavBarNavigator
                                                            .pushNewScreenWithRouteSettings(
                                                          context,
                                                          settings: RouteSettings(
                                                              name:
                                                                  DetailedCourseScreen
                                                                      .routeName,
                                                              arguments:
                                                                  result["data"]
                                                                      [0]),
                                                          screen:
                                                              const DetailedCourseScreen(),
                                                          withNavBar: false,
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: Colors.grey
                                                                    .withOpacity(
                                                                        0.3),
                                                                blurRadius: 10.0,
                                                                offset:
                                                                    const Offset(
                                                                        0, 10),
                                                                spreadRadius: 1,
                                                              ),
                                                            ],
                                                            border: Border.all(
                                                                color:
                                                                    Colors.black),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                            color: Colors.white),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
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
                                                                      "${done[index]["Course"][0]['CourseName']}",
                                                                      style:
                                                                          const TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontSize:
                                                                            16,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      height: queryData
                                                                              .size
                                                                              .height *
                                                                          0.02,
                                                                    ),
                                                                    Text(
                                                                      "₹ ${done[index]["Course"][0]['CoursePrice']}",
                                                                      style: const TextStyle(
                                                                          color: Colors
                                                                              .black,
                                                                          fontSize:
                                                                              20,
                                                                          fontWeight:
                                                                              FontWeight.w600),
                                                                    ),
                                                                    SizedBox(
                                                                      height: queryData
                                                                              .size
                                                                              .height *
                                                                          0.02,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        const Icon(
                                                                          Icons
                                                                              .star,
                                                                          color: Color(
                                                                              0xFFFFC960),
                                                                        ),
                                                                        SizedBox(
                                                                          width: queryData.size.width *
                                                                              0.02,
                                                                        ),
                                                                        const Text(
                                                                          "4.5",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                14,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: queryData.size.width *
                                                                              0.02,
                                                                        ),
                                                                        Text(
                                                                          "•",
                                                                          style:
                                                                              TextStyle(
                                                                            color: Colors
                                                                                .black
                                                                                .withOpacity(0.5),
                                                                            fontSize:
                                                                                14,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          width: queryData.size.width *
                                                                              0.02,
                                                                        ),
                                                                        Text(
                                                                          "${done[index]["Course"][0]['AuthorName']}",
                                                                          style:
                                                                              TextStyle(
                                                                            color: Colors
                                                                                .black
                                                                                .withOpacity(0.5),
                                                                            fontSize:
                                                                                14,
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
                                                                              .size
                                                                              .height *
                                                                          0.02,
                                                                    ),
                                                                    Text(
                                                                      "All Level",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.5),
                                                                        fontSize:
                                                                            14,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: queryData
                                                                        .size
                                                                        .width *
                                                                    0.05,
                                                              ),
                                                              Container(
                                                                width: 60,
                                                                height: 60,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                                15),
                                                                    color: const Color(
                                                                        0xFF970909)),
                                                                child:
                                                                    const Center(
                                                                        child:
                                                                            Icon(
                                                                  Icons.circle,
                                                                  color: Color(
                                                                      0x2BFFFFFF),
                                                                )),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          queryData.size.height *
                                                              0.04,
                                                    ),
                                                  ],
                                                );
                                              },
                                            )
                                          : Center(
                                              child: Text(
                                              "No Completed Course",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ))
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    : Center(child: CircularProgressIndicator());
              }),
        ),
      ),
    );
  }

  _lodingSection() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          dialogContext = context;
          return Dialog(
            insetPadding: EdgeInsets.symmetric(horizontal: 0),
            backgroundColor: Colors.transparent,
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Center(
                child: SpinKitCircle(
                  color: const Color(0xFF9A3B81),
                  size: 100,
                ),
              ),
            ),
          );
        });
  }
}

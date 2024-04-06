import 'package:english_copy/screens/review_screen.dart';
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import '../video_player_widget.dart';
import 'cart_screen.dart';
import 'lesion.dart';

class DetailedCourseScreen extends StatefulWidget {
  static const routeName = "DetailedCourseScreen";
  const DetailedCourseScreen({Key? key}) : super(key: key);

  @override
  State<DetailedCourseScreen> createState() => _DetailedCourseScreenState();
}

class _DetailedCourseScreenState extends State<DetailedCourseScreen> {
  bool showDetails = true;

  @override
  void initState() {
    // TODO: implement initState
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("DetailedCourseScreen", "/DetailedCourseScreen");
    //screenTrack.blockSs();
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    print(args);
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF2B2B2D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Course Detail",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: queryData.size.height * 0.03,
                    ),
                    // Row(
                    //   children: const [
                    //     Icon(
                    //       Icons.diamond,
                    //       color: Color(0xFF970909),
                    //       size: 80,
                    //     ),
                    //     Icon(
                    //       Icons.diamond,
                    //       color: Color(0xFF970909),
                    //       size: 80,
                    //     ),
                    //   ],
                    // ),
                    //args["courseimages"][args["courseimages"].length - 1]["file"]
                    args["CourseImage"].length - 1 >= 0
                        ? VideoPlayerWidget(
                            arguments: args["CourseImage"]
                                [args["CourseImage"].length - 1]["file"],
                            destination: "preview",
                            lessionid: 0,
                            courseid: 0,
                            coursesProvider: getAllCourses)
                        : Center(child: CircularProgressIndicator()),
                    SizedBox(
                      height: queryData.size.height * 0.03,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${args["CourseName"]}",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "₹${args["CoursePrice"]}",
                          style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0))),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () => setState(() {
                          showDetails = !showDetails;
                        }),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color(0xFFD9D9D9),
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                showDetails
                                    ? Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        width: queryData.size.width * 0.5,
                                        height: queryData.size.height * 0.05,
                                        child: const Center(
                                          child: Text(
                                            "Details",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )
                                    : Center(
                                        child: Text(
                                          'Details',
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              fontSize: 16),
                                        ),
                                      ),
                                !showDetails
                                    ? Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        width: queryData.size.width * 0.5,
                                        height: queryData.size.height * 0.05,
                                        child: const Center(
                                          child: Text(
                                            "Reviews",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      )
                                    : Text(
                                        'Reviews',
                                        style: TextStyle(
                                            color:
                                                Colors.black.withOpacity(0.6),
                                            fontSize: 16),
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.03,
                      ),
                      Visibility(
                        visible: showDetails,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.02,
                            ),
                            Text(
                              "${args["WhatWeCover"]}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.02,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    LessionDetails.routeName,
                                    arguments: args["CourseId"]);
                              },
                              child: const Text(
                                "Show more",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF6360FF),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.02,
                            ),
                            Divider(
                              color: const Color(0xFFF3F3F8),
                              height: queryData.size.height * 0.02,
                            ),
                            SizedBox(height: queryData.size.height * 0.03),
                            const Text(
                              "Author",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.02,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 10.0,
                                      offset: const Offset(0, 10),
                                      spreadRadius: 1,
                                    ),
                                  ],
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  children: [
                                    const CircleAvatar(
                                      radius: 22,
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          AssetImage('images/logo/logos.jpg'),
                                    ),
                                    SizedBox(
                                      width: queryData.size.width * 0.02,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          "Dr. Sandip Gawate ",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        SizedBox(
                                          height: queryData.size.height * 0.02,
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              "14 Courses",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  queryData.size.width * 0.02,
                                            ),
                                            const Text(
                                              "•",
                                              style: TextStyle(
                                                color: Color(0x4DF3F3F8),
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  queryData.size.width * 0.02,
                                            ),
                                            const Text(
                                              "1.400 Students",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: queryData.size.height * 0.04,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.04,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pushReplacementNamed(
                                        ReviewScreen.routeName,
                                        arguments: args);
                                    //dispose();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF6360FF),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  child: SizedBox(
                                    width: queryData.size.width * 0.3,
                                    height: queryData.size.height * 0.06,
                                    child: const Center(
                                      child: Text(
                                        "See Detail",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    var result = await getAllCourses
                                        .addToCart(args['CourseId'], context)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content:
                                                  Text("Item Added To Cart")));
                                    });
                                    print("my result is $result");
                                    deactivate();
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF0BA124),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15))),
                                  child: SizedBox(
                                    width: queryData.size.width * 0.3,
                                    height: queryData.size.height * 0.06,
                                    child: const Center(
                                      child: Text(
                                        "Add to Cart",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: !showDetails,
                        child: FutureBuilder(
                          future: getAllCourses.getReviews(),
                          builder: (context, snapshot) {
                            print(snapshot.data);
                            return snapshot.hasData
                                ? ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    reverse: false,
                                    itemCount:
                                        (snapshot.data! as Map)['data'].length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  blurRadius: 10.0,
                                                  offset: const Offset(0, 10),
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                              border: Border.all(
                                                  color: Colors.black),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
                                              color: Colors.white),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
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
                                                        "${(snapshot.data! as Map)['data'][index]['Course'][0]['CourseName']}",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: queryData
                                                                .size.height *
                                                            0.02,
                                                      ),
                                                      Text(
                                                        "₹ ${(snapshot.data! as Map)['data'][index]['Course'][0]['CoursePrice']}",
                                                        style: const TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: queryData
                                                                .size.height *
                                                            0.02,
                                                      ),
                                                      Row(
                                                        children: [
                                                          RatingBar(
                                                            itemCount: 5,
                                                            itemSize: 20.0,
                                                            initialRating: (snapshot.data! as Map)['data'][index]['ratingNo'].toDouble(),
                                                            ratingWidget:
                                                                RatingWidget(
                                                              full: const Icon(
                                                                Icons.star,
                                                                color: Color(
                                                                    0xFFFFC805),
                                                              ),
                                                              half: Icon(
                                                                Icons.star_half,
                                                                color: Color(
                                                                    0xFFFFC805),
                                                              ),
                                                              empty: Icon(
                                                                Icons.star,
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5),
                                                              ),
                                                            ),
                                                            onRatingUpdate:
                                                                (value) {},
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: queryData
                                                                .size.height *
                                                            0.02,
                                                      ),
                                                      const Text(
                                                        "Review",
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: queryData
                                                                .size.height *
                                                            0.01,
                                                      ),
                                                      Text(
                                                        "${(snapshot.data! as Map)['data'][index]['Comment']}",
                                                        style: const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 24,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Container(
                                                  width: 60,
                                                  height: 60,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                      color: const Color(
                                                          0xFF970909)),
                                                  child: const Center(
                                                      child: Icon(
                                                    Icons.circle,
                                                    color: Color(0x2BFFFFFF),
                                                  )),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : const Center(
                                    child: CircularProgressIndicator());
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

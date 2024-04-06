import 'dart:developer';
import 'package:english_copy/screens/notes_screen.dart';
import 'package:english_copy/screens/quiz_overwiev.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import 'cart_screen.dart';
import 'course_content.dart';
import 'live_screen.dart';
import 'show_all_reviews.dart';

class ReviewScreen extends StatefulWidget {
  static const routeName = "ReviewScreen";
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  double mainRating = 3.0;
  TextEditingController _reviewController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("ReviewScreen", "/ReviewScreen");
    //screenTrack.blockSs();
  }
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
          "All Reviews",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: const [
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
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
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: const Color(0xFF020064)),
                              child: const Center(
                                  child: Icon(Icons.badge_outlined,color: Colors.white,)),
                            ),
                            SizedBox(
                              width: queryData.size.width * 0.02,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${args['CourseName']}",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    height: queryData.size.height * 0.02,
                                  ),
                                  Text(
                                    "₹ ${args['CoursePrice']}",
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: queryData.size.height * 0.02,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        color: Color(0xFFFFC960),
                                      ),
                                      SizedBox(
                                        width: queryData.size.width * 0.02,
                                      ),
                                      const Text(
                                        "4.5",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        width: queryData.size.width * 0.02,
                                      ),
                                      Text(
                                        "•",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
                                          fontSize: 14,
                                        ),
                                      ),
                                      SizedBox(
                                        width: queryData.size.width * 0.02,
                                      ),
                                      Text(
                                        "Dr. Sandip Gawate",
                                        style: TextStyle(
                                          color: Colors.black.withOpacity(0.5),
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
                                    height: queryData.size.height * 0.02,
                                  ),
                                  Text(
                                    "All Level",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: queryData.size.height * 0.02),
                        RatingBar(
                          initialRating: 3,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                            full: const Icon(
                              Icons.star,
                              color: Color(0xFFFFC805),
                            ),
                            half: Icon(
                              Icons.star_half,
                              color: Color(0xFFFFC805),
                            ),
                            empty: Icon(
                              Icons.star,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          onRatingUpdate: (rating) {
                            print(rating);
                            mainRating = rating;
                          },
                        ),
                        SizedBox(
                          height: queryData.size.height * 0.02,
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          controller: _reviewController,
                          onChanged: (String value) {},
                          decoration: InputDecoration(
                            labelText: 'Enter Your Review',
                            labelStyle: TextStyle(color: Colors.black),
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Color(0xFF94ADCF)),
                                borderRadius: BorderRadius.circular(20)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 1, color: Colors.grey),
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ),
                        SizedBox(height: queryData.size.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            if (_reviewController.text.isNotEmpty) {
                              var result = await getAllCourses
                                  .addReviews(getAllCourses.uUserId!, mainRating, args['CourseId'],
                                      _reviewController.text);
                              print(result);
                              _reviewController.clear();
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("Review Added Sucessfully!")));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4169E1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: SizedBox(
                            width: queryData.size.width,
                            height: queryData.size.height * 0.07,
                            child: const Center(
                              child: Text(
                                "Save Review",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: queryData.size.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context)
                                .pushNamed(AllReviewsScreen.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4169E1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: SizedBox(
                            width: queryData.size.width,
                            height: queryData.size.height * 0.07,
                            child: const Center(
                              child: Text(
                                "See Review For This Course",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: queryData.size.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pushNamed(
                                QuizOverviewScreen.routeName,
                                arguments: args['CourseId']);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4169E1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: SizedBox(
                            width: queryData.size.width,
                            height: queryData.size.height * 0.07,
                            child: const Center(
                              child: Text(
                                "Take Quiz",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: queryData.size.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            var result = await getAllCourses
                                .addToCart(args['CourseId'], context)
                                .then((value) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Item Added To Cart")));
                            });
                            print("my result is $result");
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4169E1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: SizedBox(
                            width: queryData.size.width,
                            height: queryData.size.height * 0.07,
                            child: const Center(
                              child: Text(
                                "Add To Cart",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: queryData.size.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context)
                                .pushNamed(CartScreen.routeName);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4169E1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: SizedBox(
                            width: queryData.size.width,
                            height: queryData.size.height * 0.07,
                            child: const Center(
                              child: Text(
                                "Go To Cart",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: queryData.size.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pushNamed(
                                CourseContentScreen.routeName,
                                arguments: args["CourseId"]);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4169E1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: SizedBox(
                            width: queryData.size.width,
                            height: queryData.size.height * 0.07,
                            child: const Center(
                              child: Text(
                                "Show Course Content",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: queryData.size.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pushNamed(
                                LiveScreen.routeName,
                                arguments: args["CourseId"]);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4169E1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: SizedBox(
                            width: queryData.size.width,
                            height: queryData.size.height * 0.07,
                            child: const Center(
                              child: Text(
                                "Live Classes",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: queryData.size.height * 0.02),
                        ElevatedButton(
                          onPressed: () async {
                            Navigator.of(context).pushNamed(NotesScreen.routeName,arguments: args["CourseId"]);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4169E1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15))),
                          child: SizedBox(
                            width: queryData.size.width,
                            height: queryData.size.height * 0.07,
                            child: const Center(
                              child: Text(
                                "Notes Screen",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

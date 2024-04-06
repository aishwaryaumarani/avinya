import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';

class AllReviewsScreen extends StatefulWidget {
  static const routeName = "AllReviewsScreen";
  const AllReviewsScreen({Key? key}) : super(key: key);

  @override
  State<AllReviewsScreen> createState() => _AllReviewsScreenState();
}

class _AllReviewsScreenState extends State<AllReviewsScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("AllReviewsScreen", "/AllReviewsScreen");
    //screenTrack.blockSs();
  }
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    return Scaffold(
      backgroundColor: Color(0xFF2B2B2D),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0xFF2B2B2D),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: Icon(Icons.chevron_left,color: Colors.white,),
        ),
        title: const Text(
          "Reviews",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: const [Icon(Icons.shopping_cart,color: Colors.white,)],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: getAllCourses.getReviews(),
          builder: (context, snapshot) {
            print(snapshot.data);
            return snapshot.hasData
                ? ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    reverse: false,
                    itemCount: (snapshot.data! as Map)['data'].length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      //print("${(snapshot.data! as Map)['data'][index]['Course'][0]['CourseName']}");
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  blurRadius: 10.0,
                                  offset: const Offset(0, 10),
                                  spreadRadius: 1,
                                ),
                              ],
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white),
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${(snapshot.data! as Map)['data'][index]['Course'][0]['CourseName']}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      SizedBox(
                                        height: queryData.size.height * 0.02,
                                      ),
                                      Text(
                                        "₹ ${(snapshot.data! as Map)['data'][index]['Course'][0]['CoursePrice']}",
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(
                                        height: queryData.size.height * 0.02,
                                      ),
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.star,
                                            color: Color(0xFFFFC960),
                                          ),
                                          SizedBox(
                                            width: queryData.size.width * 0.02,
                                          ),
                                           Text(
                                            "${(snapshot.data! as Map)['data'][index]['ratingNo']}",
                                            style: const TextStyle(
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
                                            "By Sarah William",
                                            style: TextStyle(
                                              color: Colors.black.withOpacity(0.5),
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
                                            "All Level",
                                            style: TextStyle(
                                              color: Colors.black.withOpacity(0.5),
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: queryData.size.height * 0.02,),
                                      const Text(
                                        "Review",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 24,
                                        ),
                                      ),
                                      SizedBox(height: queryData.size.height * 0.03,),
                                      Text(
                                        "${(snapshot.data! as Map)['data'][index]['Comment']}",
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: const Color(0xFF970909)),
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
                : const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

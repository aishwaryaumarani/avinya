import 'package:english_copy/screen_track.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = "NotificationScreen";
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
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
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Notifications",
          style: TextStyle(
              color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FutureBuilder(
            future: getAllCourses.getAllCourses(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print(snapshot.data);
              }
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: (snapshot.data as Map)["data"].length,
                      scrollDirection: Axis.vertical,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Column(
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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'New Course Added',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            height: queryData.size.height * 0.01,
                                          ),
                                          Text(
                                            '${(snapshot.data as Map)["data"][index]["CourseName"]}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(15),
                                          color: Colors.white),
                                      child: Center(
                                        child:
                                            Image.asset("images/logo/banner4.png"),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: queryData.size.height * 0.02,)
                          ],
                        );
                      },
                    )
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

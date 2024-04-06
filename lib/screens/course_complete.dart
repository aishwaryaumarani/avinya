import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';

class CourseComplete extends StatefulWidget {
  static const routeName = "CourseComplete";
  const CourseComplete({super.key});

  @override
  State<CourseComplete> createState() => _CourseCompleteState();
}

class _CourseCompleteState extends State<CourseComplete> {
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "My Certificates",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                FutureBuilder(
                  future: getAllCourses.getCerti(),
                  builder: (context, snapshot) {
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
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 10.0,
                                          offset: const Offset(0, 10),
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Course Details",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Color(0xFF0E1F46),
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                queryData.size.height * 0.02,
                                          ),
                                          Text(
                                            "${(snapshot.data as Map)["data"][index]["Course"][0]["CourseName"]}",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                queryData.size.height * 0.02,
                                          ),
                                          Text(
                                            "Course Duration: ${(snapshot.data as Map)["data"][index]["Course"][0]["CourseDuration"]}",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                queryData.size.height * 0.02,
                                          ),
                                          Text(
                                            "Course Completion Date: ${(snapshot.data as Map)["data"][index]["CompletionDate"]}",
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                          SizedBox(
                                            height:
                                                queryData.size.height * 0.04,
                                          ),
                                          ElevatedButton(
                                            onPressed: () async {},
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color(0xFF0E1F46),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15))),
                                            child: SizedBox(
                                              width: queryData.size.width,
                                              height: queryData.size.height *
                                                  0.08,
                                              child: const Center(
                                                child: Text(
                                                  "Download Certificate",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: queryData.size.height * 0.03,
                                  )
                                ],
                              );
                            },
                          )
                        : Center(child: CircularProgressIndicator());
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import 'quiz_test.dart';

class QuizOverviewScreen extends StatefulWidget {
  static const routeName = "QuizOverviewScreen";
  const QuizOverviewScreen({Key? key}) : super(key: key);

  @override
  State<QuizOverviewScreen> createState() => _QuizOverviewScreenState();
}

class _QuizOverviewScreenState extends State<QuizOverviewScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("QuizOverviewScreen", "/QuizOverviewScreen");
    //screenTrack.blockSs();
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    int args = ModalRoute.of(context)!.settings.arguments as int;
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
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
          "Quiz Detail",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: FutureBuilder(
            future: getAllCourses.getquizByCourseId(args),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print((snapshot.data as Map)["data"].isNotEmpty);
              }
              return snapshot.hasData
                  ? ((snapshot.data as Map)["data"].isNotEmpty
                      ? Column(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  height: queryData.size.height * 0.04,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(15.0)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${(snapshot.data as Map)["data"][0]["Course"][0]["CourseName"]}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF0E1F46),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: Color(0xFFFFE600),
                                            ),
                                            SizedBox(
                                              width:
                                                  queryData.size.width * 0.02,
                                            ),
                                            const Text(
                                              "4.8",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFF0E1F46)),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.02,
                            ),
                            Expanded(
                              child: Container(
                                width: queryData.size.width,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25.0),
                                        topRight: Radius.circular(25.0)),
                                    color: Colors.white),
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height:
                                              queryData.size.height * 0.03,
                                        ),
                                        const Text(
                                          "Brief explanation about this quiz",
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        SizedBox(
                                          height:
                                              queryData.size.height * 0.03,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey),
                                              child: const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.contact_page,
                                                    color: Colors.black,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  queryData.size.width * 0.03,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${(snapshot.data as Map)["data"][0]["NoofQuizQuestion"]} Question",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                Text(
                                                  "${(snapshot.data as Map)["data"][0]["QuizMarkingSchema"]} point for a correct answer",
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              queryData.size.height * 0.03,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey),
                                              child: const Padding(
                                                padding: EdgeInsets.all(10.0),
                                                child: Center(
                                                  child: Icon(
                                                    Icons.timer,
                                                    color: Colors.black,
                                                    size: 30,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  queryData.size.width * 0.03,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "${(snapshot.data as Map)["data"][0]["QuizTimeDuration"]}",
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                                const Text(
                                                  "Total duration of the quiz",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              queryData.size.height * 0.03,
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width:
                                                  queryData.size.width * 0.1,
                                              height: queryData.size.height *
                                                  0.08,
                                              decoration: const BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.grey),
                                              child: const Padding(
                                                padding: EdgeInsets.all(10.0),
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  queryData.size.width * 0.03,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  "Answer all questions correctly",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height:
                                              queryData.size.height * 0.03,
                                        ),
                                        const Text(
                                          "Please read the text below carefully so you can understand it understand it",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              queryData.size.height * 0.02,
                                        ),
                                        Text(
                                          "• ${(snapshot.data as Map)["data"][0]["QuizMarkingSchema"]} point awarded for a correct answer and no marks for a incorrect answer",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              queryData.size.height * 0.02,
                                        ),
                                        const Text(
                                          "• Tap on options to select the correct answer",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              queryData.size.height * 0.02,
                                        ),
                                        const Text(
                                          "• Tap on the bookmark icon to save interesting questions",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              queryData.size.height * 0.02,
                                        ),
                                        const Text(
                                          "• Click submit if you are sure you want to complete all the quizzes",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              queryData.size.height * 0.04,
                                        ),
                                        Center(
                                          child: SizedBox(
                                            width: queryData.size.width * 0.8,
                                            child: ElevatedButton(
                                              onPressed: () async {
                                                Navigator.of(context)
                                                    .pushNamed(
                                                        QuizTestScreen
                                                            .routeName,
                                                        arguments: {
                                                      "QuizData": (snapshot
                                                                  .data
                                                              as Map)["data"]
                                                          [0]["QuizQuestion"],
                                                      "TotalTime": (snapshot
                                                                      .data
                                                                  as Map)[
                                                              "data"][0][
                                                          "QuizTimeDuration"],
                                                      "Title": (snapshot.data
                                                                      as Map)[
                                                                  "data"][0]
                                                              ["Course"][0]
                                                          ["CourseName"],
                                                      "CourseId": args,
                                                      "QuizId": (snapshot.data
                                                              as Map)["data"]
                                                          [0]["QuizId"]
                                                    });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Color(0xFF4169E1),
                                                  shape:
                                                      RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      15))),
                                              child: SizedBox(
                                                width: queryData.size.width,
                                                height:
                                                    queryData.size.height *
                                                        0.08,
                                                child: Center(
                                                  child: Text(
                                                    "Start Quiz",
                                                    style: TextStyle(
                                                        fontSize: 24,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )
                      : Center(
                          child: Text(
                          "No Quiz Found!",
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        )))
                  : const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

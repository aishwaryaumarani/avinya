import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import 'bottom_nav_screen.dart';
import 'quiz_result.dart';

class QuizTestScreen extends StatefulWidget {
  static const routeName = "QuizTestScreen";
  const QuizTestScreen({Key? key}) : super(key: key);

  @override
  State<QuizTestScreen> createState() => _QuizTestScreenState();
}

class _QuizTestScreenState extends State<QuizTestScreen> {
  int mainIndex = 0;
  int mainValue = 0;
  List marksList = [];
  int corrects = 0;
  int wrongs = 0;
  List optionsList = [];
  bool showList = true;
  String mainAnswer = "";
  Map<int, int> allAnswers = {};

  final Shader selectedGradient = const LinearGradient(
    colors: <Color>[Color(0xff3550DC), Color(0xff27E9F7)],
  ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("QuizTestScreen", "/QuizTestScreen");
    //screenTrack.blockSs();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Map argssss = ModalRoute.of(context)!.settings.arguments as Map;
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    DateFormat dateFormat = DateFormat("HH:mm:ss");
    DateTime dateTime = dateFormat.parse(args["TotalTime"]);
    print(args);
    if (showList) {
      optionsList.add(args["QuizData"][mainIndex]["Option1"]);
      optionsList.add(args["QuizData"][mainIndex]["Option2"]);
      optionsList.add(args["QuizData"][mainIndex]["Option3"]);
      optionsList.add(args["QuizData"][mainIndex]["Option4"]);
      optionsList.shuffle();
      setState(() {
        showList = false;
      });
    }
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
        title: Text(
          "${args["Title"]}",
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: [
          Countdown(
            seconds: Duration(
                    hours: dateTime.hour,
                    minutes: dateTime.minute,
                    seconds: dateTime.second)
                .inSeconds,
            interval: const Duration(seconds: 1),
            build: (BuildContext context, double time) {
              double mainTime = double.parse((time / 60).toStringAsFixed(1));
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.schedule,
                          color: Colors.lightBlue,
                        ),
                        SizedBox(
                          width: queryData.size.height * 0.01,
                        ),
                        Text(
                          "${mainTime.toString().split('.')[0]}:${mainTime.toString().split('.')[1]}",
                          style: TextStyle(
                              foreground: Paint()..shader = selectedGradient),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
            onFinished: () {
              print("dones");
              Navigator.of(context).pushNamed(BottomNavScreen.routeName);
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Quiz Ended! Time Over!")));
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: queryData.size.height * 0.1,
                  width: queryData.size.width,
                  decoration: BoxDecoration(color: Colors.white),
                  child: ListView.builder(
                    itemCount: args["QuizData"].length,
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: mainIndex == index
                                      ? const Color(0xFF4169E1)
                                      : Colors.grey,
                                  border: Border.all(
                                      color: Colors.black, width: 1)),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Center(
                                    child: Text(
                                  "${index + 1}",
                                  style: const TextStyle(color: Colors.white),
                                )),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: LinearProgressIndicator(
                    minHeight: queryData.size.height * 0.015,
                    value: (mainIndex + 1) / args["QuizData"].length,
                    backgroundColor: const Color(0xFF4169E1),
                    color: const Color(0xFFD4D4D4),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.04,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          "${args["QuizData"][mainIndex]["QuizQuestion"]}",
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                        ),
                        SizedBox(
                          height: queryData.size.height * 0.03,
                        ),
                        _buttonContainer(1, "A", queryData, optionsList[0]),
                        SizedBox(
                          height: queryData.size.height * 0.02,
                        ),
                        _buttonContainer(2, "B", queryData, optionsList[1]),
                        SizedBox(
                          height: queryData.size.height * 0.02,
                        ),
                        _buttonContainer(3, "C", queryData, optionsList[2]),
                        SizedBox(
                          height: queryData.size.height * 0.02,
                        ),
                        _buttonContainer(4, "D", queryData, optionsList[3]),
                        SizedBox(
                          height: queryData.size.height * 0.02,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.05,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (mainIndex == (args["QuizData"].length - 1) &&
                        mainValue != 0) {
                      setState(() {
                        String correctAns =
                            "${args["QuizData"][mainIndex]["CorrectAnswer"]}";
                        if (correctAns.compareTo(mainAnswer) == 0) {
                          corrects += 1;
                          print(corrects);
                        }
                      });
                      wrongs = args["QuizData"].length - corrects;
                      print("$corrects,, $wrongs");
                      Navigator.of(context)
                          .pushNamed(QuizResultScreen.routeName, arguments: {
                        "correctAnswer": corrects,
                        "wrongAnswer": wrongs,
                        "TotalAnswer": args["QuizData"].length
                      });
                      // ScaffoldMessenger.of(context).showSnackBar(
                      //     const SnackBar(content: Text("Quiz Submitted")));
                      var result = await getAllCourses.addQuizScore(
                          args["QuizId"],
                          args["Title"],
                          args["QuizId"],
                          args["QuizData"].length,
                          corrects,
                          wrongs);
                    }
                    //print(result);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF4169E1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: mainIndex != 0
                                    ? [
                                        const Color(0xff020064),
                                        const Color(0xff27E9F7)
                                      ]
                                    : [Colors.grey, Colors.grey])),
                        child: IconButton(
                          onPressed: () {
                            if (mainIndex != 0) {
                              setState(() {
                                optionsList.clear();
                                showList = true;
                                mainIndex -= 1;
                                mainValue = allAnswers[mainIndex]!;
                              });
                            }
                          },
                          icon: const Icon(Icons.chevron_left_outlined,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        //width: queryData.size.width * 0.4,
                        height: queryData.size.height * 0.08,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Text(
                              "Submit Quiz",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: mainIndex !=
                                            (args["QuizData"].length - 1) &&
                                        mainValue != 0
                                    ? [
                                        const Color(0xff020064),
                                        const Color(0xff27E9F7)
                                      ]
                                    : [Colors.grey, Colors.grey])),
                        child: IconButton(
                          onPressed: () {
                            if (allAnswers.length > mainIndex) {
                              setState(() {
                                //print("main is $mainIndex");
                                if (allAnswers[mainIndex + 1] != null) {
                                  mainValue = allAnswers[mainIndex + 1]!;
                                  print("we here $mainIndex");
                                } else {
                                  mainValue = 0;
                                }
                              });
                            } else if (mainIndex !=
                                    (args["QuizData"].length - 1) &&
                                mainValue != 0) {
                              print("we here is");
                              //print("main is $mainIndex");
                              String correctAns =
                                  "${args["QuizData"][mainIndex]["CorrectAnswer"]}";
                              setState(() {
                                optionsList.clear();
                                showList = true;
                                allAnswers[mainIndex] = mainValue;
                                if (correctAns.compareTo(mainAnswer) == 0) {
                                  corrects += 1;
                                }
                                print("answer is $allAnswers");
                                //mainIndex += 1;
                                mainValue = 0;
                              });
                            }
                            setState(() {
                              //print("main iss- $mainIndex  quest is ${mainIndex + 1}");
                              mainIndex = mainIndex + 1;
                            });
                          },
                          icon: const Icon(Icons.chevron_right_outlined,
                              color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buttonContainer(
      int index, String title, MediaQueryData query, String option) {
    return InkWell(
        onTap: () {
          setState(() {
            mainValue = index;
            mainAnswer = option;
            print(option);
          });
        },
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: index == mainValue
                          ? [const Color(0xff4169E1), const Color(0xff4169E1)]
                          : [Color(0xFFABDBCB), Color(0xFFABDBCB)])),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            SizedBox(
              width: query.size.width * 0.04,
            ),
            Expanded(
              child: Text(
                option,
                style: TextStyle(fontSize: 20, color: Color(0xFF0E1F46)),
              ),
            )
          ],
        ));
  }
}

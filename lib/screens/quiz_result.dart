import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../screen_track.dart';
import 'bottom_nav_screen.dart';

class QuizResultScreen extends StatefulWidget {
  static const routeName = "QuizResultScreen";
  const QuizResultScreen({Key? key}) : super(key: key);

  @override
  State<QuizResultScreen> createState() => _QuizResultScreenState();
}

class _QuizResultScreenState extends State<QuizResultScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("QuizResultScreen", "/QuizResultScreen");
    //screenTrack.blockSs();
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    double acc = (args["correctAnswer"] / args["TotalAnswer"]) * 100;
    final List<ChartData> chartData = [
      ChartData('Accuracy ${acc.toStringAsFixed(2)}%', acc, Color(0xFFFF4604)),
      ChartData('total 100%', acc - 100, Color(0xFF0E1F46)),
    ];
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
          "Exam Score",
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      width: queryData.size.width * 0.88,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: const Text(
                                "Your Score ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: queryData.size.height * 0.3,
                                  width: queryData.size.width * 0.4,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFFF4604)),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: CustomPaint(
                                            foregroundPainter: PieChartPainter(
                                                args["correctAnswer"],
                                                args["TotalAnswer"]),
                                            child: Container()),
                                      ),
                                      Center(
                                        child: Container(
                                          width: queryData.size.width * 0.3,
                                          height: queryData.size.height * 0.2,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white),
                                          child: Center(
                                            child: Text(
                                              "${args["correctAnswer"]}/${args["TotalAnswer"]}",
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 24,
                                                  decoration:
                                                      TextDecoration.none),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      "Correct Answer: ${args["correctAnswer"]}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    SizedBox(
                                      height: queryData.size.height * 0.02,
                                    ),
                                    Text(
                                      "Wrong Answer:  ${args["wrongAnswer"]}",
                                      style: const TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Percentage',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Color(0xFFE5E4F9)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      '${acc.toStringAsFixed(2)}%',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.02,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: LinearProgressIndicator(
                                minHeight: queryData.size.height * 0.02,
                                value: (args["correctAnswer"] /
                                    args["TotalAnswer"]),
                                backgroundColor: const Color(0xFFD4D4D4),
                                color: const Color(0xFFFF4604),
                              ),
                            ),
                            SizedBox(
                              height: queryData.size.height * 0.02,
                            ),
                            Container(
                              width: queryData.size.width,
                              height: queryData.size.height * 0.25,
                              child: SfCircularChart(
                                  margin: EdgeInsets.zero,
                                  title: ChartTitle(
                                      text: 'Accuracy',
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  legend: Legend(
                                      isVisible: true,
                                      alignment: ChartAlignment.center,
                                      position: LegendPosition.right),
                                  series: <CircularSeries>[
                                    PieSeries<ChartData, String>(
                                        dataSource: chartData,
                                        radius: '75',
                                        pointColorMapper: (ChartData data, _) =>
                                            data.color,
                                        xValueMapper: (ChartData data, _) =>
                                            data.x,
                                        yValueMapper: (ChartData data, _) =>
                                            data.y,
                                        // starting angle of pie
                                        startAngle: 270,
                                        // ending angle of pie
                                        endAngle: 90)
                                  ]),
                            ),
                            // SizedBox(
                            //   height: queryData.size.height * 0.04,
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height * 0.05,
                    ),
                    SizedBox(
                      width: queryData.size.width * 0.88,
                      child: ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context)
                              .pushNamed(BottomNavScreen.routeName);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF4169E1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: SizedBox(
                          width: queryData.size.width,
                          height: queryData.size.height * 0.08,
                          child: Center(
                            child: Text(
                              "Home",
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
                            ),
                          ),
                        ),
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

class PieChartPainter extends CustomPainter {
  int obtainedMarks;
  int totalMarks;

  PieChartPainter(this.obtainedMarks, this.totalMarks);

  @override
  void paint(Canvas canvas, Size size) {
    var startRadian = -pi;
    var sweepRadian = (obtainedMarks / totalMarks) * pi * 2;
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 45;
    paint.color = const Color(0xFF0E1F46);
    Offset center11 = Offset(size.width / 2, size.height / 2);
    double radius12 = min(size.width / 2, size.height / 2);

    canvas.drawArc(Rect.fromCircle(center: center11, radius: radius12),
        startRadian, sweepRadian, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

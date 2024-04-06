import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart' as rat;
import 'package:rate_my_app/rate_my_app.dart';

import '../screen_track.dart';

class AppReviewScreen extends StatefulWidget {
  static const routeName = "AppReviewScreen";
  const AppReviewScreen({Key? key}) : super(key: key);

  @override
  State<AppReviewScreen> createState() => _AppReviewScreenState();
}

class _AppReviewScreenState extends State<AppReviewScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("AppReviewScreen", "/AppReviewScreen");
    //screenTrack.blockSs();
  }
  double mainRating = 3.0;
  final reviewController = TextEditingController();
  WidgetBuilder builder = buildProgressIndicator;

  static Widget buildProgressIndicator(BuildContext context) =>
      const Center(child: CircularProgressIndicator());
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
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
          "App Review",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/logo/background.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                TextFormField(
                  controller: reviewController,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black),
                  maxLines: 8,
                  decoration: InputDecoration(
                    label: Text(
                      "Review",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black),
                    ),
                    hintText: 'Write Your Review',
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Color(0xFFDADADA),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Color(0xFF94ADCF)),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.04,
                ),
                rat.RatingBar(
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
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  onRatingUpdate: (rating) {
                    print(rating);
                    mainRating = rating;
                  },
                ),
                SizedBox(
                  height: queryData.size.height * 0.03,
                ),
                ElevatedButton(
                  onPressed: () {
                    reviewController.clear();
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text("Review added")));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: SizedBox(
                    width: queryData.size.width,
                    height: queryData.size.height * 0.08,
                    child: const Center(
                      child: Text(
                        "Submit Review",
                        style: TextStyle(color: const Color(0xFF6360FF)),
                      ),
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import '../video_player_widget.dart';

class LessionDetails extends StatefulWidget {
  static const routeName = "LessionDetails";
  const LessionDetails({Key? key}) : super(key: key);

  @override
  State<LessionDetails> createState() => _LessionDetailsState();
}

class _LessionDetailsState extends State<LessionDetails> {
  int index = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("LessionDetails", "/LessionDetails");
    //screenTrack.blockSs();
  }
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    GetCoursesProvider coursesProvider = Provider.of(context);
    int args = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: Icon(Icons.chevron_left,color: Colors.black,),
        ),
        title: const Text(
          "1. Introduction",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: coursesProvider.getLessons(args),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? Column(
                  children: [
                    VideoPlayerWidget(
                              key: VideoPlayerWidget.cartKey,
                              arguments: (snapshot.data as Map)["data"][0]
                                  ["lessionImage"][0]["file"],
                              destination: "lesson",courseid: 0, lessionid: 0,coursesProvider: coursesProvider),
                    SingleChildScrollView(
                        child: SizedBox(
                          child: ListView.builder(
                            itemCount: (snapshot.data! as Map)['data'].length,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Container(
                                    width: queryData.size.width,
                                    //height: queryData.size.height * 0.13,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black, width: 1),
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
                                                  "${(snapshot.data! as Map)['data'][index]["lessionName"]}",
                                                  style: const TextStyle(fontSize: 20,color: Colors.black),
                                                ),
                                                SizedBox(
                                                  height: queryData.size.height * 0.01,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      "Video",
                                                      style: TextStyle(
                                                          color: Colors.black.withOpacity(0.5)),
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
                                                      "4 min",
                                                      style: TextStyle(
                                                          color: Colors.black.withOpacity(0.5)),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Checkbox(
                                            value: true,
                                            onChanged: (value) {},
                                            activeColor: const Color(0xFF970909),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import '../video_player_widget.dart';

class CourseContentScreen extends StatefulWidget {
  static const routeName = "CourseContentScreen";
  const CourseContentScreen({Key? key}) : super(key: key);

  @override
  State<CourseContentScreen> createState() => _CourseContentScreenState();
}

class _CourseContentScreenState extends State<CourseContentScreen> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;
  bool showContent = true;
  bool showChant = false;
  final textController = TextEditingController();
  final ScrollController mainScroll = ScrollController();
  int index111 = 0;
  bool showProgress = false;
  String progress = "Downloading...";
  double percent = 0;
  int mainindex = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("CourseContentScreen", "/CourseContentScreen");
    //screenTrack.blockSs();
    // _controller = VideoPlayerController.network(
    //     'https://firebasestorage.googleapis.com/v0/b/englishguruapp-a35c4.appspot.com/o/images11%2F_%C3%82%C2%B0Ae%20Watan%20Song%201_00%20Minute%20lyrics%20Video_%C3%82%C2%B0%5B360p%5D.mp4?alt=media&token=3e181c04-28c1-44ab-8208-ee474a17f844')
    //   ..initialize().then((value) {
    //     _controller!.setVolume(1);
    //     _controller!.play();
    //     setState(() {});
    //   });
  }


  void scrollAnimateToEnd(ScrollController controller) {
    Future.delayed(const Duration(milliseconds: 400)).then((_) {
      try {
        controller
            .animateTo(
          controller.position.maxScrollExtent,
          duration: const Duration(seconds: 1),
          curve: Curves.fastOutSlowIn,
        )
            .then((value) {
          controller.animateTo(
            controller.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
          );
        });
      } catch (e) {
        print('error on scroll $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    GetCoursesProvider coursesProvider = Provider.of(context);
    int args = ModalRoute.of(context)!.settings.arguments as int;
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
          "1. Introduction",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: coursesProvider.getLessons(args).asStream(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              print(snapshot.data);
            }
            // _controller!.addListener(() {
            //   int left = ((_controller!.value.position.inSeconds / _controller!.value.duration.inSeconds) * 100).truncate();
            //   if(left == 95){
            //     var result = coursesProvider.lessonisComplete((snapshot.data as Map)["data"][1]["lessionId"], (snapshot.data as Map)["data"][1]["Course"][0]["CourseId"],
            //      (snapshot.data as Map)["data"][1]["Category"][0]["CategoryId"], (snapshot.data as Map)["data"][1]["SubCategory"][0]["SubCategoryId"]);
            //     print("hullu $result");
            //   }
            // });
            return snapshot.hasData
                ? SizedBox(
                    width: queryData.size.width,
                    height: queryData.size.height,
                    child: Column(
                      children: [
                        VideoPlayerWidget(
                            key: VideoPlayerWidget.cartKey,
                            arguments: (snapshot.data as Map)["data"]
                                [index111]["lessionImage"][0]["file"],
                            destination: "CourseVideo", lessionid: (snapshot.data as Map)["data"][index111]["lessionId"],
                            courseid: (snapshot.data as Map)["data"][index111]["CourseId"],
                            coursesProvider: coursesProvider),
                        Row(
                          children: [
                            SizedBox(
                              width: queryData.size.width / 2,
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    showContent = true;
                                    showChant = false;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: showContent
                                      ? Color(0xFF4169E1)
                                      : Colors.white,
                                ),
                                child: SizedBox(
                                  width: queryData.size.width,
                                  height: queryData.size.height * 0.08,
                                  child: Center(
                                    child: Text(
                                      "Course Content",
                                      style: TextStyle(
                                          color: showContent
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: queryData.size.width / 2,
                              child: ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    showContent = false;
                                    showChant = true;
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: !showChant
                                      ? Colors.white
                                      : const Color(0xFF4169E1),
                                ),
                                child: SizedBox(
                                  width: queryData.size.width,
                                  height: queryData.size.height * 0.08,
                                  child: Center(
                                    child: Text(
                                      "Discussion",
                                      style: TextStyle(
                                          color: showChant
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: showContent,
                          child: Expanded(
                              child: SingleChildScrollView(
                            child: SizedBox(
                              child: ListView.builder(
                                itemCount:
                                    (snapshot.data! as Map)['data'].length,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        index111 = index;
                                      });
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              settings: RouteSettings(
                                                  arguments: args),
                                              builder:
                                                  (BuildContext context) =>
                                                      super.widget));
                                    },
                                    child: Container(
                                      width: queryData.size.width,
                                      //height: queryData.size.height * 0.13,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "${(snapshot.data! as Map)['data'][index]["lessionName"]}",
                                                        style: const TextStyle(
                                                            fontSize: 20,
                                                            color: Colors.black),
                                                      ),
                                                      SizedBox(
                                                        height: queryData
                                                                .size.height *
                                                            0.01,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            "Video",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5)),
                                                          ),
                                                          SizedBox(
                                                            width: queryData
                                                                    .size.width *
                                                                0.02,
                                                          ),
                                                          Text(
                                                            "•",
                                                            style: TextStyle(
                                                              color: Colors.black
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 14,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: queryData
                                                                    .size.width *
                                                                0.02,
                                                          ),
                                                          Text(
                                                            "4 min",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .black
                                                                    .withOpacity(
                                                                        0.5)),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () async {
                                                    setState(() {
                                                      showProgress = true;
                                                    });
                                                    Map<Permission,
                                                            PermissionStatus>
                                                        statuses = await [
                                                      Permission.storage
                                                    ].request();
                                                    if (statuses[
                                                            Permission.storage]!
                                                        .isGranted) {
                                                          setState(() {
                                                            mainindex = index;
                                                          });
                                                      getFileName((snapshot.data as Map)["data"][index]["lessionImage"][0]["file"],coursesProvider);
                                                    }
                                                  },
                                                  icon: Icon(Icons.download),
                                                )
                                                // Checkbox(
                                                //   value: true,
                                                //   onChanged: (value) {},
                                                //   activeColor:
                                                //       const Color(0xFF970909),
                                                // )
                                              ],
                                            ),
                                            SizedBox(height: queryData.size.height * 0.02,),
                                            Visibility(
                                              visible: showProgress && mainindex == index,
                                              child: LinearProgressIndicator(
                                                value: percent,
                                                color:const Color(0xFF0E1F46),
                                                minHeight: 10,
                                              )
                                              // Text(
                                              //   "$percent",
                                              //   style: TextStyle(
                                              //     fontSize: 16,
                                              //     color: Colors.black,
                                              //     fontWeight: FontWeight.w600
                                              //   ),
                                              // ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )),
                        ),
                        Visibility(
                          visible: showChant,
                            child: Expanded(
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: StreamBuilder(
                                      stream: FirebaseFirestore.instance
                                          .collection("Discussion")
                                          .doc("CourseID")
                                          .collection(
                                              "${(snapshot.data as Map)["data"][0]["lessionId"]}")
                                          .snapshots(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<QuerySnapshot>
                                              mainSnap) {
                                        if (mainScroll.hasClients) {
                                          scrollAnimateToEnd(mainScroll);
                                        }
                                        return mainSnap.hasData
                                            ? Column(
                                                children: [
                                                  Expanded(
                                                    child: ListView(
                                                      controller: mainScroll,
                                                      shrinkWrap: true,
                                                      physics:
                                                          BouncingScrollPhysics(),
                                                      children: mainSnap
                                                          .data!.docs
                                                          .map((DocumentSnapshot
                                                              document) {
                                                        Map<String, dynamic>
                                                            data =
                                                            document.data()!
                                                                as Map<String,
                                                                    dynamic>;
                                                        //print(data);
                                                        return Expanded(
                                                          child: Column(
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  const CircleAvatar(
                                                                    radius: 25,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    backgroundImage:
                                                                        AssetImage(
                                                                            'images/logo/logos.jpg'),
                                                                  ),
                                                                  SizedBox(
                                                                    width: queryData
                                                                            .size
                                                                            .width *
                                                                        0.05,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          data[
                                                                              "Name"],
                                                                          style: TextStyle(
                                                                              fontSize: 18,
                                                                              color: Colors.white),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              queryData.size.height * 0.01,
                                                                        ),
                                                                        Text(
                                                                          data[
                                                                              "Message"],
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                18,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              queryData.size.height * 0.01,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            Text(
                                                                              data["likes"] == null ? "Vote (0)" : "Vote (${data["likes"]})",
                                                                              style: TextStyle(fontSize: 14, color: Colors.black),
                                                                            ),
                                                                            SizedBox(
                                                                              width: queryData.size.width * 0.05,
                                                                            ),
                                                                            IconButton(
                                                                              onPressed: () async {
                                                                                QuerySnapshot querySnap = await FirebaseFirestore.instance.collection("Discussion").doc("CourseID").collection("${(snapshot.data as Map)["data"][0]["lessionId"]}").where('userID', isEqualTo: coursesProvider.uUserId).where('Message', isEqualTo: data["Message"]).get();
                                                                                QueryDocumentSnapshot doc = querySnap.docs[0];
                                                                                DocumentReference docRef = doc.reference;
                                                                                if (data["likes"] == null) {
                                                                                  docRef.update({
                                                                                    "likes": 1
                                                                                  });
                                                                                } else {
                                                                                  docRef.update({
                                                                                    "likes": data["likes"] + 1
                                                                                  });
                                                                                }
                                                                                //docRef.update({});
                                                                              },
                                                                              icon: const Icon(Icons.thumb_up_alt_sharp, color: Colors.black),
                                                                            )
                                                                          ],
                                                                        )
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: queryData
                                                                        .size
                                                                        .height *
                                                                    0.02,
                                                              ),
                                                            ],
                                                          ),
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        queryData.size.height *
                                                            0.06,
                                                  )
                                                ],
                                              )
                                            : CircularProgressIndicator();
                                      },
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Container(
                                      width: queryData.size.width,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.black, width: 1),
                                          color: Colors.white),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: TextFormField(
                                                style: TextStyle(
                                                    color: Colors.black),
                                                controller: textController,
                                                decoration: InputDecoration(
                                                  enabledBorder:
                                                      UnderlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .black)),
                                                  label: Text(
                                                    "Post new comment",
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                await FirebaseFirestore.instance
                                                    .collection("Discussion")
                                                    .doc("CourseID")
                                                    .collection(
                                                        "${(snapshot.data as Map)["data"][0]["lessionId"]}")
                                                    .add({
                                                  "Name": coursesProvider.uName,
                                                  "Message":
                                                      textController.text,
                                                  "userID": coursesProvider.uUserId,
                                                  "courseId": 12345,
                                                  "lessonId": (snapshot.data
                                                          as Map)["data"][0]
                                                      ["lessionId"]
                                                }).then((value) {
                                                  print("added yo");
                                                  textController.clear();
                                                });
                                              },
                                              icon: Icon(
                                                Icons.send,
                                                color: Color(0xFF970909),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                        )
                      ],
                    ),
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Future downloadFile(String ref, String names, GetCoursesProvider coursesProvider) async {
    final dir = await getApplicationDocumentsDirectory();
    //final file = File('${dir.path}/video.png');

    try {
      final dirss = await getTemporaryDirectory();
      final path = '${dirss.path}/${names}';

      await Dio().download(
        ref,
        path,
        onReceiveProgress: (count, totalss) {
          if (totalss != -1) {
            // int aa= (count / totalss * 100).floor();
            
            // if(aa == 100){
            //   setState(() {
            //     progress = "Download Completed";
            //   });
            // }
            setState(() {
              percent = (count / totalss);
              print("$percent %");
            });
          }
        },
      ).then((value) async {
        var sharedPref = await SharedPreferences.getInstance();
        List<String> allPaths = [];
        if(sharedPref.getStringList("downloads") != null){
          allPaths = sharedPref.getStringList("downloads")!;
        }
        allPaths.add(path);
        sharedPref.setStringList("downloaded", allPaths);
        setState(() {
          showProgress = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Video Download Completed")));
        print("file downloaded $path");
      });

      // var dir = await DownloadsPathProvider.downloadsDirectory;
      // if(dir!=null){
      //   String savename = "file.pdf";
      //   String savePath = dir.path + "/$savename";

      // }
    } on DioError catch (e) {
      print(e.message);
    }
  }

  getFileName(String url, GetCoursesProvider coursesProvider) {
    RegExp regExp = new RegExp(r'.+(\/|%2F)(.+)\?.+');
    //This Regex won't work if you remove ?alt...token
    var matches = regExp.allMatches(url);
    print("matches are ${url.split('/').last}");
    // var match = matches.elementAt(0);
    // print("this is thiss ${Uri.decodeFull(match.group(2)!)}");
    // //return Uri.decodeFull(match.group(2)!);
    downloadFile(url, url.split('/').last, coursesProvider);
  }
}

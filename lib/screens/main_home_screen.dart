import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:english_copy/screens/download_screen.dart';
import 'package:english_copy/screens/notification_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import 'detailed_course.dart';
import 'home_screen.dart';

class MainHomeScreen extends StatefulWidget {
  static const routeName = "MainHomeScreen";
  const MainHomeScreen({Key? key}) : super(key: key);

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  final _searchCOntroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("MainHomeScreen", "/MainHomeScreen");
    //screenTrack.blockSs();
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 1.0,
                              offset: const Offset(0, 10),
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/update/pfp.png'),
                        )),
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              blurRadius: 1.0,
                              offset: const Offset(0, 10),
                              spreadRadius: 0.5,
                            ),
                          ],
                      ),
                      child: IconButton(
                        onPressed: () => PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(
                            name: NotificationScreen.routeName,
                          ),
                          screen: const NotificationScreen(),
                          withNavBar: true,
                        ),
                        icon: Icon(
                          Icons.notifications_active_outlined,
                          size: 25,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Text(
                  'Hi ${getAllCourses.uName}',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Text(
                  'Find the best \ncourse for you!',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                TextFormField(
                  controller: _searchCOntroller,
                  onChanged: (value) {
                    setState(() {});
                  },
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelStyle: TextStyle(color: Colors.black),
                    labelText: 'Search Courses',
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFF161719)),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFF161719)),
                        borderRadius: BorderRadius.circular(20)),
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
                // SizedBox(
                //   child: Image.asset('images/logo/banner.png'),
                // ),
                Column(
                  children: [
                    Visibility(
                      visible: _searchCOntroller.text.isEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: queryData.size.height * 0.03,
                          ),
                          FutureBuilder(
                            future: getAllCourses.getBannerImages(),
                            builder: (context, snapshot) {
                              List imageList = [];
                              if (snapshot.hasData) {
                                //print(snapshot.data);
                                imageList = (snapshot.data as Map)["data"]
                                    .map((e) => e["BannerImage"][0]["file"])
                                    .toList();
                                imageList
                                    .removeWhere((element) => element == null);
                              }
                              return snapshot.hasData
                                  ? SizedBox(
                                      child: CarouselSlider(
                                        options: CarouselOptions(
                                            enlargeCenterPage: true,
                                            enableInfiniteScroll: false,
                                            autoPlay: true),
                                        items: imageList.map((e) {
                                          return ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Stack(
                                              fit: StackFit.expand,
                                              children: [
                                                // Image.network(
                                                //   e,
                                                //   loadingBuilder: (context, child, loadingProgress) {
                                                //      return loadingProgress == null
                                                //      ? child
                                                //      : Center(child: CircularProgressIndicator());
                                                //   },
                                                //   fit: BoxFit.cover,
                                                // ),
                                                CachedNetworkImage(
                                                  imageUrl: e,
                                                  placeholder: (context, url) =>
                                                      Center(
                                                          child:
                                                              CircularProgressIndicator()),
                                                )
                                              ],
                                            ),
                                          );
                                        }).toList(),
                                      ),
                                    )
                                  : Center(child: CircularProgressIndicator());
                            },
                          ),
                          SizedBox(
                            height: queryData.size.height * 0.02,
                          ),
                          const Text(
                            "All Courses",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontWeight: FontWeight.w600),
                          ),
                          SizedBox(
                            height: queryData.size.height * 0.03,
                          ),
                          FutureBuilder(
                            future: getAllCourses.getCourseCategory(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                //print(snapshot.data);
                              }
                              return snapshot.hasData
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      reverse: false,
                                      shrinkWrap: true,
                                      itemCount:
                                          (snapshot.data as Map)["data"].length,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                // var sharedpref = await SharedPreferences.getInstance();
                                                // var list = sharedpref.getStringList("downloaded");
                                                // print(list);
                                                // PersistentNavBarNavigator
                                                //     .pushNewScreen(
                                                //   context,
                                                //   screen: DownloadScreen(list: list),
                                                //   withNavBar: true,
                                                // );
                                                PersistentNavBarNavigator
                                                    .pushNewScreenWithRouteSettings(
                                                  context,
                                                  settings: RouteSettings(
                                                      name:
                                                          HomeScreen.routeName,
                                                      arguments:
                                                          "${(snapshot.data as Map)["data"][index]["CategoryName"]}"),
                                                  screen: const HomeScreen(),
                                                  withNavBar: true,
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        blurRadius: 10.0,
                                                        offset:
                                                            const Offset(0, 10),
                                                        spreadRadius: 1,
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    color: Colors.white),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      15.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Expanded(
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              '${(snapshot.data as Map)["data"][index]["CategoryName"]}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                            ),
                                                            SizedBox(
                                                              height: queryData
                                                                      .size
                                                                      .height *
                                                                  0.02,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 60,
                                                        height: 60,
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        15),
                                                            color:
                                                                Colors.white),
                                                        child: Center(
                                                          child: Image.asset(
                                                              "images/logo/banner4.png"),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height:
                                                  queryData.size.height * 0.03,
                                            ),
                                          ],
                                        );
                                      },
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator());
                            },
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _searchCOntroller.text.isNotEmpty,
                      child: FutureBuilder(
                        future: getAllCourses.getAllCourses(),
                        builder: (context, snapshot) {
                          List allCourses = [];
                          if (snapshot.hasData) {
                            for (var element
                                in (snapshot.data as Map)["data"]) {
                              if (element["CourseName"].toLowerCase().contains(
                                  _searchCOntroller.text.toLowerCase())) {
                                allCourses.add(element);
                              }
                            }
                          }
                          return allCourses.isNotEmpty
                              ? (allCourses.isNotEmpty
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      reverse: false,
                                      itemCount: allCourses.length,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 20.0),
                                          child: InkWell(
                                            onTap: () {
                                              PersistentNavBarNavigator
                                                  .pushNewScreenWithRouteSettings(
                                                context,
                                                settings: RouteSettings(
                                                    name: DetailedCourseScreen
                                                        .routeName,
                                                    arguments:
                                                        allCourses[index]),
                                                screen:
                                                    const DetailedCourseScreen(),
                                                withNavBar: false,
                                              );
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      blurRadius: 10.0,
                                                      offset:
                                                          const Offset(0, 10),
                                                      spreadRadius: 1,
                                                    ),
                                                  ],
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                  color: Colors.white),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "${allCourses[index]['CourseName']}",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: queryData
                                                                    .size
                                                                    .height *
                                                                0.02,
                                                          ),
                                                          Text(
                                                            "₹ ${allCourses[index]['CoursePrice']}",
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 20,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          SizedBox(
                                                            height: queryData
                                                                    .size
                                                                    .height *
                                                                0.02,
                                                          ),
                                                          Text(
                                                            "${allCourses[index]["Category"][0]["CategoryName"]}",
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: queryData
                                                                    .size
                                                                    .height *
                                                                0.02,
                                                          ),
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                Icons.star,
                                                                color: Color(
                                                                    0xFFFFC960),
                                                              ),
                                                              SizedBox(
                                                                width: queryData
                                                                        .size
                                                                        .width *
                                                                    0.02,
                                                              ),
                                                              const Text(
                                                                "4.5",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: queryData
                                                                        .size
                                                                        .width *
                                                                    0.02,
                                                              ),
                                                              Text(
                                                                "•",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: queryData
                                                                        .size
                                                                        .width *
                                                                    0.02,
                                                              ),
                                                              Text(
                                                                "Dr. Sandip Gawate",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: queryData
                                                                        .size
                                                                        .width *
                                                                    0.02,
                                                              ),
                                                              Text(
                                                                "•",
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.5),
                                                                  fontSize: 14,
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: queryData
                                                                        .size
                                                                        .width *
                                                                    0.02,
                                                              ),
                                                              Expanded(
                                                                child: Text(
                                                                  "All Level",
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.5),
                                                                    fontSize:
                                                                        14,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Container(
                                                      width: 60,
                                                      height: 60,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                          color: const Color(
                                                              0xFF970909)),
                                                      child: const Center(
                                                          child: Icon(
                                                        Icons.circle,
                                                        color:
                                                            Color(0x2BFFFFFF),
                                                      )),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    )
                                  : Center(
                                      child: Text(
                                      "No Courses Found",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )))
                              : const Center(
                                  child: CircularProgressIndicator());
                        },
                      ),
                    )
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

import 'package:english_copy/screen_track.dart';
import 'package:english_copy/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../provider_pages/get_courses.dart';

class LiveScreen extends StatefulWidget {
  static const routeName = "LiveScreen";
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  final _searchCOntroller = TextEditingController();
  List SearchData = [];

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
    int args = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Live Classes",
            style: TextStyle(
                color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
            )
          ]),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder(
            future: getAllCourses.getZoomByCourseId(args),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if(_searchCOntroller.text.isNotEmpty){
                  SearchData.clear();
                  for (var element in (snapshot.data as Map)["data"]) {
                  if (element["ClassTitle"]
                      .toLowerCase()
                      .contains(_searchCOntroller.text.toLowerCase())) {
                        print("heppeninggfgg");
                    SearchData.add(element);
                  }
                }
                }
                print(SearchData.length);
              }
              return snapshot.hasData
                  ? ((snapshot.data as Map)["data"].isNotEmpty
                      ? Column(
                          children: [
                            SizedBox(height: queryData.size.height * 0.02,),
                            TextFormField(
                              controller: _searchCOntroller,
                              onChanged: (value) {
                                setState(() {});
                              },
                              style: TextStyle(color: Colors.black),
                              decoration: InputDecoration(
                                labelStyle: TextStyle(color: Colors.black),
                                filled: true,
                                fillColor: Colors.white,
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
                            SizedBox(
                              height: queryData.size.height * 0.05,
                            ),
                            Stack(
                              children: [
                                Visibility(
                                  visible: _searchCOntroller.text.isEmpty,
                                  child: ListView.builder(
                                    itemCount:
                                        (snapshot.data as Map)["data"].length,
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    physics: BouncingScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: [
                                          Container(
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
                                                color: Color(0xFFE5E4F9)),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
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
                                                          '${(snapshot.data as Map)["data"][index]["ClassTitle"]}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black,
                                                              fontSize: 18,
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
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Start Date:',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            SizedBox(
                                                              width: queryData
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                            ),
                                                            Text(
                                                              '${(snapshot.data as Map)["data"][index]["StartDate"]}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: queryData
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'Start Time:',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            SizedBox(
                                                              width: queryData
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                            ),
                                                            Text(
                                                              '${(snapshot.data as Map)["data"][index]["StartTime"]}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: queryData
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'End Date:',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            SizedBox(
                                                              width: queryData
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                            ),
                                                            Text(
                                                              '${(snapshot.data as Map)["data"][index]["EndDate"]}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: queryData
                                                                  .size
                                                                  .height *
                                                              0.01,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                              'End Time:',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                            SizedBox(
                                                              width: queryData
                                                                      .size
                                                                      .width *
                                                                  0.05,
                                                            ),
                                                            Text(
                                                              '${(snapshot.data as Map)["data"][index]["EndTime"]}',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: queryData
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                        ),
                                                        ElevatedButton(
                                                          onPressed: () =>
                                                              launchUrlsss(
                                                                  Uri.parse(
                                                                      '${(snapshot.data as Map)["data"][index]["JoinURL"]}')),
                                                          style: ElevatedButton.styleFrom(
                                                              backgroundColor: Colors.white,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius.circular(
                                                                          15))),
                                                          child: SizedBox(
                                                            width: queryData
                                                                .size.width,
                                                            height: queryData
                                                                    .size
                                                                    .height *
                                                                0.06,
                                                            child:
                                                                const Center(
                                                              child: Text(
                                                                "Join Class",
                                                                style: TextStyle(
                                                                    color: Colors.black),
                                                              ),
                                                            ),
                                                          ),
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
                                                                .circular(15),
                                                        color: Colors.white),
                                                    child: Center(
                                                      child: Image.asset(
                                                          "images/logo/banner4.png"),
                                                    ),
                                                  ),
                                                ],
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
                                  ),
                                ),
                                Visibility(
                                  visible: _searchCOntroller.text.isNotEmpty,
                                  child: SearchData.isNotEmpty
                                      ? ListView.builder(
                                          itemCount: SearchData.length,
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics: BouncingScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(
                                                                  0.3),
                                                          blurRadius: 10.0,
                                                          offset:
                                                              const Offset(
                                                                  0, 10),
                                                          spreadRadius: 1,
                                                        ),
                                                      ],
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(20.0),
                                                      color: Color(0xFFE5E4F9)),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
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
                                                                '${SearchData[index]["ClassTitle"]}',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18,
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
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    'Start Date:',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                  SizedBox(
                                                                    width: queryData
                                                                            .size
                                                                            .width *
                                                                        0.05,
                                                                  ),
                                                                  Text(
                                                                    '${SearchData[index]["StartDate"]}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: queryData
                                                                        .size
                                                                        .height *
                                                                    0.01,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    'Start Time:',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                  SizedBox(
                                                                    width: queryData
                                                                            .size
                                                                            .width *
                                                                        0.05,
                                                                  ),
                                                                  Text(
                                                                    '${SearchData[index]["StartTime"]}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: queryData
                                                                        .size
                                                                        .height *
                                                                    0.01,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    'End Date:',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                  SizedBox(
                                                                    width: queryData
                                                                            .size
                                                                            .width *
                                                                        0.05,
                                                                  ),
                                                                  Text(
                                                                    '${SearchData[index]["EndDate"]}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: queryData
                                                                        .size
                                                                        .height *
                                                                    0.01,
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Text(
                                                                    'End Time:',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                  SizedBox(
                                                                    width: queryData
                                                                            .size
                                                                            .width *
                                                                        0.05,
                                                                  ),
                                                                  Text(
                                                                    '${SearchData[index]["EndTime"]}',
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                            FontWeight.w400),
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: queryData
                                                                        .size
                                                                        .height *
                                                                    0.02,
                                                              ),
                                                              ElevatedButton(
                                                                onPressed: () =>
                                                                    launchUrlsss(
                                                                        Uri.parse(
                                                                            '${SearchData[index]["JoinURL"]}')),
                                                                style: ElevatedButton.styleFrom(
                                                                    backgroundColor: Colors.white,
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15))),
                                                                child:
                                                                    SizedBox(
                                                                  width: queryData
                                                                      .size
                                                                      .width,
                                                                  height: queryData
                                                                          .size
                                                                          .height *
                                                                      0.06,
                                                                  child:
                                                                      const Center(
                                                                    child:
                                                                        Text(
                                                                      "Join Class",
                                                                      style: TextStyle(
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                  ),
                                                                ),
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
                                                              color: Colors
                                                                  .white),
                                                          child: Center(
                                                            child: Image.asset(
                                                                "images/logo/banner4.png"),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height:
                                                      queryData.size.height *
                                                          0.03,
                                                ),
                                              ],
                                            );
                                          },
                                        )
                                      : Center(
                                          child: Text(
                                          "No ${_searchCOntroller.text} Live Class Found!",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 22),
                                        )),
                                ),
                              ],
                            ),
                          ],
                        )
                      : Center(
                          child: Text(
                          "No Live Classes Found!",
                          style: TextStyle(color: Colors.black, fontSize: 22),
                        )))
                  : Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }

  Future<void> launchUrlsss(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

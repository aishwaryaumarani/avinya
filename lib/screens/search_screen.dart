import 'dart:developer';

import 'package:english_copy/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import 'detailed_course.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "SearchScreen";
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List allCourses = [];
  List searchedCouses = [];
  List CategoryCouses = [];
  bool showmainList = true;
  int selected = -1;
  int filter = -1;
  TextEditingController _searchCOntroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("SearchScreen", "/SearchScreen");
    //screenTrack.blockSs();
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Explore",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () =>
                PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
              context,
              settings: RouteSettings(
                name: CartScreen.routeName,
              ),
              screen: const CartScreen(),
              withNavBar: true,
            ),
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                TextFormField(
                  style: TextStyle(color: Colors.black),
                  controller: _searchCOntroller,
                  onChanged: (String value) {
                    if (value.isNotEmpty) {
                      searchedCouses.clear();
                      for (var element in allCourses) {
                        if (element['CourseName']
                            .toLowerCase()
                            .contains(value.toLowerCase())) {
                          setState(() {
                            searchedCouses.add(element);
                            print('searched are $element');
                          });
                        }
                      }
                    } else if (value.isEmpty) {
                      setState(() {
                        filter = -1;
                      });
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Search Course',
                    labelStyle: TextStyle(color: Colors.black),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.black),
                        borderRadius: BorderRadius.circular(20)),
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.03,
                ),
                Stack(
                  children: [
                    Visibility(
                      visible:
                          _searchCOntroller.text.isNotEmpty ? true : false,
                      child: SizedBox(
                        //height: queryData.size.height * 0.68,
                        child: searchedCouses.isNotEmpty
                            ? Column(
                                children: [
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      children: [
                                        _filterChip(0, 'Newest'),
                                        _filterChip(1, 'Oldest'),
                                        _filterChip(2, 'Alphabatic A-Z'),
                                        _filterChip(3, 'Alphabatic Z-A'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: queryData.size.height * 0.02,
                                  ),
                                  ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    reverse: filter == 1 || filter == 3 ? true : false,
                                    itemCount: searchedCouses.length,
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
                                                      searchedCouses[index]),
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
                                                          "${searchedCouses[index]['CourseName']}",
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
                                                          "₹ ${searchedCouses[index]['CoursePrice']}",
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
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
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
                                                            // SizedBox(
                                                            //   width: queryData.size.width * 0.02,
                                                            // ),
                                                            // Text(
                                                            //   "•",
                                                            //   style: TextStyle(
                                                            //     color: Colors.black.withOpacity(0.5),
                                                            //     fontSize: 14,
                                                            //   ),
                                                            // ),
                                                            // SizedBox(
                                                            //   width: queryData.size.width * 0.02,
                                                            // ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: queryData
                                                                  .size
                                                                  .height *
                                                              0.02,
                                                        ),
                                                        Text(
                                                          "All Level",
                                                          style: TextStyle(
                                                            color: Colors
                                                                .black
                                                                .withOpacity(
                                                                    0.5),
                                                            fontSize: 14,
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
                                  ),
                                ],
                              )
                            : Center(
                                child: Text(
                                "No Courses Found",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              )),
                      ),
                    ),
                    Visibility(
                      visible: _searchCOntroller.text.isEmpty ? true : false,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    "Browse Category",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.chevron_right,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                              InkWell(
                                onTap: () async {
                                  setState(() {
                                    selected = -1;
                                    CategoryCouses.clear();
                                    showmainList = true;
                                  });
                                },
                                child: Center(
                                  child: const Text(
                                    "Clear",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: queryData.size.height * 0.03,
                          ),
                          FutureBuilder(
                            future: getAllCourses.getCourseCategory(),
                            builder: (context, snapshot) {
                              return snapshot.hasData
                                  ? SizedBox(
                                      height: queryData.size.height * 0.1,
                                      width: queryData.size.width,
                                      child: ListView.builder(
                                        physics:
                                            const BouncingScrollPhysics(),
                                        reverse: false,
                                        shrinkWrap: true,
                                        itemCount:
                                            (snapshot.data as Map)["data"]
                                                .length,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          return Row(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(3.0),
                                                child: FilterChip(
                                                  label: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10.0),
                                                    child: Text(
                                                      '${(snapshot.data as Map)["data"][index]["CategoryName"]}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 16),
                                                    ),
                                                  ),
                                                  selectedColor: Color(0xFF4F75FA),
                                                  backgroundColor: Color(0xFF4F75FA),
                                                  selected: index == selected
                                                      ? true
                                                      : false,
                                                  onSelected: (bool value) {
                                                    if (value) {
                                                      setState(() {
                                                        selected = index;
                                                      });
                                                      CategoryCouses.clear();
                                                      for (var element
                                                          in allCourses) {
                                                        if (element['Category']
                                                                    [0][
                                                                'CategoryName']
                                                            .toLowerCase()
                                                            .contains(
                                                                '${(snapshot.data as Map)["data"][index]["CategoryName"]}'
                                                                    .toLowerCase())) {
                                                          setState(() {
                                                            showmainList =
                                                                false;
                                                            CategoryCouses
                                                                .add(element);
                                                            //print(searchedCouses);
                                                          });
                                                        }
                                                      }
                                                    } else {
                                                      setState(() {
                                                        selected = -1;
                                                        CategoryCouses
                                                            .clear();
                                                        showmainList = true;
                                                      });
                                                    }
                                                  },
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator());
                            },
                          ),
                          // FutureBuilder(
                          //   future: getAllCourses.getCourseCategory(),
                          //   builder: (context, snapshot) {
                          //     return GridView.builder(
                          //       shrinkWrap: true,
                          //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          //         crossAxisCount: 3
                          //       ),
                          //       itemCount: (snapshot.data as Map)["data"].length,
                          //       itemBuilder: (context, index) {
                          //         return Row(
                          //             children: [
                          //               FilterChip(
                          //                 label: Padding(
                          //                   padding: const EdgeInsets.all(10.0),
                          //                   child: Text('${(snapshot.data as Map)["data"][index]["CategoryName"]}'),
                          //                 ),
                          //                 selectedColor: const Color(0xFF020064),
                          //                 backgroundColor: const Color(0xFF020064),
                          //                 onSelected: (bool value) {},
                          //               ),
                          //             ],
                          //           );
                          //       },
                          //     );
                          //   },
                          // ),
                          // Row(
                          //   children: [
                          //     FilterChip(
                          //       label: const Text('Technology'),
                          //       selectedColor: const Color(0xFF020064),
                          //       backgroundColor: const Color(0xFF020064),
                          //       onSelected: (bool value) {},
                          //     ),
                          //     SizedBox(
                          //       width: queryData.size.width * 0.02,
                          //     ),
                          //     FilterChip(
                          //       label: const Text('Business'),
                          //       selectedColor: const Color(0xFF020064),
                          //       backgroundColor: const Color(0xFF020064),
                          //       onSelected: (bool value) {},
                          //     ),
                          //     SizedBox(
                          //       width: queryData.size.width * 0.02,
                          //     ),
                          //     FilterChip(
                          //       label: const Text('Finance'),
                          //       selectedColor: const Color(0xFF020064),
                          //       backgroundColor: const Color(0xFF020064),
                          //       onSelected: (bool value) {},
                          //     ),
                          //     SizedBox(
                          //       width: queryData.size.width * 0.02,
                          //     ),
                          //     FilterChip(
                          //       label: const Text('Python'),
                          //       selectedColor: const Color(0xFF020064),
                          //       backgroundColor: const Color(0xFF020064),
                          //       onSelected: (bool value) {},
                          //     ),
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: queryData.size.height * 0.01,
                          // ),
                          // Row(
                          //   children: [
                          //     FilterChip(
                          //       label: const Text('Programming'),
                          //       selectedColor: const Color(0xFF020064),
                          //       backgroundColor: const Color(0xFF020064),
                          //       onSelected: (bool value) {},
                          //     ),
                          //     SizedBox(
                          //       width: queryData.size.width * 0.02,
                          //     ),
                          //     FilterChip(
                          //       label: const Text('Swift'),
                          //       selectedColor: const Color(0xFF020064),
                          //       backgroundColor: const Color(0xFF020064),
                          //       onSelected: (bool value) {},
                          //     ),
                          //     SizedBox(
                          //       width: queryData.size.width * 0.02,
                          //     ),
                          //     FilterChip(
                          //       label: const Text('React Native'),
                          //       selectedColor: const Color(0xFF020064),
                          //       backgroundColor: const Color(0xFF020064),
                          //       onSelected: (bool value) {},
                          //     ),
                          //   ],
                          // ),
                          SizedBox(
                            height: queryData.size.height * 0.03,
                          ),
                          const Text(
                            "Recommended Courses",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: queryData.size.height * 0.03,
                          ),
                          FutureBuilder(
                            future: getAllCourses.getAllCourses(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                allCourses.clear();
                                //print((snapshot.data as Map)["data"]);
                                allCourses = (snapshot.data as Map)["data"]
                                    .map((data) => data)
                                    .toList();
                                allCourses.removeWhere(
                                    (item) => item['CourseName'] == null);
                                if (showmainList) {
                                  CategoryCouses =
                                      (snapshot.data as Map)["data"]
                                          .map((data) => data)
                                          .toList();
                                }
                              }
                              //print(CategoryCouses[0]["Category"][0]["CategoryName"]);
                              return CategoryCouses.isNotEmpty
                                  ? ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      reverse: false,
                                      itemCount: CategoryCouses.length,
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
                                                    arguments: CategoryCouses[
                                                        index]),
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
                                                            "${CategoryCouses[index]['CourseName']}",
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .black,
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
                                                            "₹ ${CategoryCouses[index]['CoursePrice']}",
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
                                                            "${CategoryCouses[index]["Category"][0]["CategoryName"]}",
                                                            style:
                                                                const TextStyle(
                                                              color: Colors
                                                                  .black,
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
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceEvenly,
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
                                                                  fontSize:
                                                                      14,
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
                                                                  fontSize:
                                                                      14,
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
                                                                  fontSize:
                                                                      14,
                                                                ),
                                                              ),
                                                              // SizedBox(
                                                              //   width: queryData.size.width * 0.02,
                                                              // ),
                                                              // Text(
                                                              //   "•",
                                                              //   style: TextStyle(
                                                              //     color: Colors.black.withOpacity(0.5),
                                                              //     fontSize: 14,
                                                              //   ),
                                                              // ),
                                                              // SizedBox(
                                                              //   width: queryData.size.width * 0.02,
                                                              // ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: queryData
                                                                    .size
                                                                    .height *
                                                                0.02,
                                                          ),
                                                          Text(
                                                            "All Level",
                                                            style: TextStyle(
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontSize: 14,
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
                                  : const Center(
                                      child: CircularProgressIndicator());
                            },
                          ),
                          SizedBox(
                            height: queryData.size.height * 0.02,
                          )
                        ],
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

  _filterChip(int index, String title) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: FilterChip(
        label: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16),
          ),
        ),
        selectedColor: Color(0xFF4F75FA),
        backgroundColor: Color(0xFF4F75FA),
        selected: index == filter ? true : false,
        onSelected: (bool value) {
          if (value) {
            setState(() {
              filter = index;
              CategoryCouses.clear();
              CategoryCouses = List.from(searchedCouses);
              if(index == 0 || index == 1){
                searchedCouses.sort(
                (a, b) => a["updatedAt"].compareTo(b["updatedAt"]),
                );
              }else if(index == 2 || index == 3){
                searchedCouses.sort(
                (a, b) => a["CourseName"].compareTo(b["CourseName"]),
              );
              }
            });
            // for (var element
            //     in allCourses) {
            //   if (element['Category']
            //               [0][
            //           'CategoryName']
            //       .toLowerCase()
            //       .contains(
            //           '${(snapshot.data as Map)["data"][index]["CategoryName"]}'
            //               .toLowerCase())) {
            //     setState(() {
            //       CategoryCouses
            //           .add(element);
            //       //print(searchedCouses);
            //     });
            //   }
            // }
          } else {
            setState(() {
              filter = -1;
              print("hello $CategoryCouses");
              searchedCouses.clear();
              searchedCouses = List.from(CategoryCouses);
              // searchedCouses.add([...CategoryCouses]);
            });
          }
        },
      ),
    );
  }
}

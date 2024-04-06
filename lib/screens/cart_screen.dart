import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import 'checkout_screen.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "CartScreen";
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("CartScreen", "/CartScreen");
    //screenTrack.blockSs();
  }

  List allcartCOurses = [];
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
          "Cart",
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: getAllCourses.getAllCart(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      allcartCOurses = (snapshot.data as Map)["data"]
                          .map((data) => data)
                          .toList();
                    }
                    return snapshot.hasData
                        ? ((snapshot.data! as Map)['data']).isNotEmpty
                            ? ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                reverse: false,
                                itemCount:
                                    (snapshot.data! as Map)['data'].length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  blurRadius: 10.0,
                                                  offset: const Offset(0, 10),
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
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
                                                        "${(snapshot.data! as Map)['data'][index]["Course"][0]['CourseName']}",
                                                        style:
                                                            const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: queryData
                                                                .size.height *
                                                            0.02,
                                                      ),
                                                      Text(
                                                        "₹ ${(snapshot.data! as Map)['data'][index]["Course"][0]['CoursePrice']}",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: queryData
                                                                .size.height *
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
                                                            style: TextStyle(
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
                                                            style: TextStyle(
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
                                                            style: TextStyle(
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
                                                                .size.height *
                                                            0.02,
                                                      ),
                                                      Text(
                                                        "All Level",
                                                        style: TextStyle(
                                                          color: Colors.black
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
                                                    color: Color(0x2BFFFFFF),
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              queryData.size.height * 0.04,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                var result = await getAllCourses
                                                    .addSaveLater(
                                                        (snapshot.data!
                                                                    as Map)[
                                                                'data'][index]
                                                            ["CourseId"],
                                                        context)
                                                    .then((value) async {
                                                  var ress = await getAllCourses
                                                      .deleteCart((snapshot
                                                                  .data!
                                                              as Map)['data']
                                                          [index]["CartId"]);
                                                  ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  "Item Saved For Later")));
                                                  setState(() {});
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        blurRadius: 10.0,
                                                        offset: const Offset(
                                                            0, 10),
                                                        spreadRadius: 1,
                                                      ),
                                                    ],
                                                    color: Colors.white),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          15.0),
                                                  child: Text(
                                                    "Save for later",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                var result =
                                                    await getAllCourses
                                                        .deleteCart((snapshot
                                                                        .data!
                                                                    as Map)[
                                                                'data'][index]
                                                            ["CartId"])
                                                        .then((value) {
                                                  ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  "Item Deleted")));
                                                  setState(() {});
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        blurRadius: 10.0,
                                                        offset: const Offset(
                                                            0, 10),
                                                        spreadRadius: 1,
                                                      ),
                                                    ],
                                                    color: Colors.white),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          15.0),
                                                  child: Text(
                                                    "Remove",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                "Your Cart is Empty",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              ))
                        : const Center(child: CircularProgressIndicator());
                  },
                ),
                SizedBox(
                  height: queryData.size.height * 0.03,
                ),
                Divider(
                  height: queryData.size.height * 0.01,
                  color: const Color(0xFF292b2d),
                ),
                SizedBox(
                  height: queryData.size.height * 0.03,
                ),
                const Text(
                  "Saved for later",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: queryData.size.height * 0.03,
                ),
                FutureBuilder(
                  future: getAllCourses.getSaveLater(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ((snapshot.data! as Map)['data']).isNotEmpty
                            ? ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                reverse: false,
                                itemCount:
                                    (snapshot.data! as Map)['data'].length,
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Column(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  blurRadius: 10.0,
                                                  offset: const Offset(0, 10),
                                                  spreadRadius: 1,
                                                ),
                                              ],
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 1),
                                              borderRadius:
                                                  BorderRadius.circular(20.0),
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
                                                        "${(snapshot.data! as Map)['data'][index]["Course"][0]['CourseName']}",
                                                        style:
                                                            const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: queryData
                                                                .size.height *
                                                            0.02,
                                                      ),
                                                      Text(
                                                        "₹ ${(snapshot.data! as Map)['data'][index]["Course"][0]['CoursePrice']}",
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.black,
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      SizedBox(
                                                        height: queryData
                                                                .size.height *
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
                                                            style: TextStyle(
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
                                                            style: TextStyle(
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
                                                            style: TextStyle(
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
                                                                .size.height *
                                                            0.02,
                                                      ),
                                                      Text(
                                                        "All Level",
                                                        style: TextStyle(
                                                          color: Colors.black
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
                                                    color: Color(0x2BFFFFFF),
                                                  )),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              queryData.size.height * 0.04,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                var result = await getAllCourses
                                                    .addToCart(
                                                        (snapshot.data!
                                                                    as Map)[
                                                                'data'][index]
                                                            ["CourseId"],
                                                        context)
                                                    .then((value) async {
                                                  var ress = await getAllCourses
                                                      .deleteSaveforLater((snapshot
                                                                      .data!
                                                                  as Map)[
                                                              'data'][index]
                                                          ["SaveForLaterId"]);
                                                  ScaffoldMessenger.of(
                                                          context)
                                                      .showSnackBar(
                                                          const SnackBar(
                                                              content: Text(
                                                                  "Item Saved For Later")));
                                                  setState(() {});
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        blurRadius: 10.0,
                                                        offset: const Offset(
                                                            0, 10),
                                                        spreadRadius: 1,
                                                      ),
                                                    ],
                                                    color: Colors.white),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          15.0),
                                                  child: Text(
                                                    "Add To Cart",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                var result = await getAllCourses
                                                    .deleteSaveforLater(
                                                        (snapshot.data!
                                                                    as Map)[
                                                                'data'][index]
                                                            [
                                                            "SaveForLaterId"]);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(const SnackBar(
                                                        content: Text(
                                                            "Item Deleted")));
                                                setState(() {});
                                                print(result);
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.3),
                                                        blurRadius: 10.0,
                                                        offset: const Offset(
                                                            0, 10),
                                                        spreadRadius: 1,
                                                      ),
                                                    ],
                                                    color: Colors.white),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(
                                                          15.0),
                                                  child: Text(
                                                    "Remove",
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.5),
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              )
                            : Center(
                                child: Text(
                                "Your Save For Later is Empty",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 22),
                              ))
                        : const Center(child: CircularProgressIndicator());
                  },
                ),
                SizedBox(
                  height: queryData.size.height * 0.05,
                ),
                Divider(
                  height: queryData.size.height * 0.02,
                  color: const Color(0xFF292b2d),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Text(
                  "Total Items",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (allcartCOurses.isNotEmpty) {
                      if (allcartCOurses.length > 1) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "More than 1 item in the cart. Please select only One item.")));
                      } else {
                        //Navigator.of(context).pushNamed(CheckoutScreen.routeName, arguments: allcartCOurses);
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(
                              name: CheckoutScreen.routeName,
                              arguments: allcartCOurses),
                          screen: const CheckoutScreen(),
                          withNavBar: false,
                        );
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Your Cart is Empty!")));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6360FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: SizedBox(
                    width: queryData.size.width,
                    height: queryData.size.height * 0.06,
                    child: const Center(
                      child: Text(
                        "Checkout Now",
                        style: TextStyle(color: Colors.black),
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

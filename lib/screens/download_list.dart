import 'package:english_copy/screen_track.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cart_screen.dart';
import 'download_screen.dart';

class DownloadList extends StatefulWidget {
  const DownloadList({super.key});

  @override
  State<DownloadList> createState() => _DownloadListState();
}

class _DownloadListState extends State<DownloadList> {
  var list;
  Future getprefrence() async {
    var sharedPref = await SharedPreferences.getInstance();
    list = sharedPref.getStringList("downloaded");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    //screenTrack.blockSs();
  }

  @override
  Widget build(BuildContext context) {
    Size queryData = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Color(0xFF2B2B2D),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Downloads",
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
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
                color: Colors.white,
              ),
            )
          ]),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: FutureBuilder(
          future: getprefrence(),
          builder: (context, snapshot) {
            return list != null
                ? ListView.builder(
                    itemCount: list.length,
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              //print(list);
                              if (list[index].split('.').last == 'mp4') {
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  screen: DownloadScreen(list: list![index]),
                                  withNavBar: true,
                                );
                              } else {
                                var res = await OpenFile.open(list![index]);
                                print("result is ${res.message}");
                              }
                              // PersistentNavBarNavigator
                              //     .pushNewScreenWithRouteSettings(
                              //   context,
                              //   settings: RouteSettings(
                              //       name: HomeScreen
                              //           .routeName,
                              //       arguments:
                              //           "${(snapshot.data as Map)["data"][index]["CategoryName"]}"),
                              //   screen:
                              //       const HomeScreen(),
                              //   withNavBar: true,
                              // );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.3),
                                      blurRadius: 10.0,
                                      offset: const Offset(0, 10),
                                      spreadRadius: 1,
                                    ),
                                  ],
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Colors.white),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${list[index].split("/")[6]}',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 20,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          SizedBox(
                                            height: queryData.height * 0.02,
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: 60,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
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
                          ),
                          SizedBox(
                            height: queryData.height * 0.03,
                          ),
                        ],
                      );
                    },
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

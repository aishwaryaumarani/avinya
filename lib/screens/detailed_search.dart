import 'package:flutter/material.dart';

import '../screen_track.dart';

class DetailedSearchScreen extends StatefulWidget {
  static const routeName = "DetailedSearchScreen";
  const DetailedSearchScreen({Key? key}) : super(key: key);

  @override
  State<DetailedSearchScreen> createState() => _DetailedSearchScreenState();
}

class _DetailedSearchScreenState extends State<DetailedSearchScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("DetailedSearchScreen", "/DetailedSearchScreen");
    //screenTrack.blockSs();
  }
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
          "Search Results",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: const [Icon(Icons.shopping_cart)],
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/logo/background.png'),
                fit: BoxFit.cover),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                topRight: Radius.circular(25.0)),
            //border: Border.all(color: Colors.white,width: 1),
            color: Color(0x80000000)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "Results for “Swift UI”",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Total 200",
                      style: TextStyle(
                          color: Color(0x4DF3F3F8),
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                SizedBox(
                  height: queryData.size.height * 0.05,
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10.0,
                          offset: const Offset(0, 10),
                          spreadRadius: 1,
                        ),
                      ],
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Declarative interfaces for any Apple Devices",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: queryData.size.height * 0.02,
                              ),
                              const Text(
                                "IDR 850.000",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: queryData.size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xFFFFC960),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "4.5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "•",
                                    style: TextStyle(
                                      color: Color(0x4DF3F3F8),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "By Sarah William",
                                    style: TextStyle(
                                      color: Color(0x4DF3F3F8),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "•",
                                    style: TextStyle(
                                      color: Color(0x4DF3F3F8),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "All Level",
                                    style: TextStyle(
                                      color: Color(0x4DF3F3F8),
                                      fontSize: 14,
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
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xFF970909)),
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
                  height: queryData.size.height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10.0,
                          offset: const Offset(0, 10),
                          spreadRadius: 1,
                        ),
                      ],
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Declarative interfaces for any Apple Devices",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: queryData.size.height * 0.02,
                              ),
                              const Text(
                                "IDR 850.000",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: queryData.size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xFFFFC960),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "4.5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "•",
                                    style: TextStyle(
                                      color: Color(0x4DF3F3F8),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "By Sarah William",
                                    style: TextStyle(
                                      color: Color(0x4DF3F3F8),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "•",
                                    style: TextStyle(
                                      color: Color(0x4DF3F3F8),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "All Level",
                                    style: TextStyle(
                                      color: Color(0x4DF3F3F8),
                                      fontSize: 14,
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
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xFF970909)),
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
                  height: queryData.size.height * 0.03,
                ),
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10.0,
                          offset: const Offset(0, 10),
                          spreadRadius: 1,
                        ),
                      ],
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.black),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Declarative interfaces for any Apple Devices",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: queryData.size.height * 0.02,
                              ),
                              const Text(
                                "IDR 850.000",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: queryData.size.height * 0.02,
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Color(0xFFFFC960),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "4.5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "•",
                                    style: TextStyle(
                                      color: Color(0x4DF3F3F8),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "By Sarah William",
                                    style: TextStyle(
                                      color: Color(0x4DF3F3F8),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "•",
                                    style: TextStyle(
                                      color: Color(0x4DF3F3F8),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  const Text(
                                    "All Level",
                                    style: TextStyle(
                                      color: Color(0x4DF3F3F8),
                                      fontSize: 14,
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
                              borderRadius: BorderRadius.circular(15),
                              color: const Color(0xFF970909)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

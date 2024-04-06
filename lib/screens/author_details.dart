import 'package:flutter/material.dart';

import '../screen_track.dart';

class AuthorDetails extends StatefulWidget {
  static const routeName = "AuthorDetails";
  const AuthorDetails({Key? key}) : super(key: key);

  @override
  State<AuthorDetails> createState() => _AuthorDetailsState();
}

class _AuthorDetailsState extends State<AuthorDetails> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("AuthorDetails", "/AuthorDetails");
    //screenTrack.blockSs();
  }
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF292B2D),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: Icon(Icons.chevron_left,color: Colors.black,),
        ),
        title: const Text(
          "Author",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: const [Icon(Icons.shopping_cart)],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      backgroundImage: AssetImage('images/logo/logos.jpg'),
                    ),
                    SizedBox(
                      width: queryData.size.width * 0.04,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Welcome back",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "Poetri Lazuardi ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Divider(
                  color: const Color(0xFFF3F3F8),
                  height: queryData.size.height * 0.02,
                ),
                SizedBox(height: queryData.size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFF020064)),
                          child:
                              const Center(child: Icon(Icons.badge_outlined)),
                        ),
                        SizedBox(
                          width: queryData.size.width * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Current Progress",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "50%",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xFF020064)),
                          child:
                              const Center(child: Icon(Icons.badge_outlined)),
                        ),
                        SizedBox(
                          width: queryData.size.width * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Current Progress",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              "50%",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: queryData.size.height * 0.03),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      topRight: Radius.circular(25.0)),
                  color: Color(0x80000000)),
              child: SingleChildScrollView(
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
                            "Courses",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Total 4",
                            style: TextStyle(
                                color: Color(0x4DF3F3F8),
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
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
                            border: Border.all(color: Colors.black),
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
                                      "Declarative interfaces for any Apple Deviceseeeeeee",
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
                              )
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
                            border: Border.all(color: Colors.black),
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
                                      "Declarative interfaces for any Apple Deviceseeeeeee",
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
                              )
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
                            border: Border.all(color: Colors.black),
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
                                      "Declarative interfaces for any Apple Deviceseeeeeee",
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
                              )
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
                            border: Border.all(color: Colors.black),
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
                                      "Declarative interfaces for any Apple Deviceseeeeeee",
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
                              )
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
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0xFF212325)),
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
                                      "Declarative interfaces for any Apple Deviceseeeeeee",
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
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

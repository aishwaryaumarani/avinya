import 'package:english_copy/screens/detailed_notes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import 'cart_screen.dart';

class NotesScreen extends StatefulWidget {
  static const routeName = "NotesScreen";
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context).size;
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    int args = ModalRoute.of(context)!.settings.arguments as int;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            "Notes/Assignments",
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
                future: getAllCourses.getNotes(),
                builder: (context, snapshot) {
                  List mainData = [];
                  if (snapshot.hasData) {
                    //print(snapshot.data);
                    mainData = (snapshot.data as Map)["data"].map((e){
                      if(e["CourseId"] == args){
                        return e;
                      }
                    }).toList();
                    print("mainData is $mainData");
                  }
                  return snapshot.hasData
                      ? (mainData.isNotEmpty
                      ? ListView.builder(
                          itemCount: mainData.length,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                InkWell(
                                  onTap: () => Navigator.of(context).pushNamed(DetailedNotes.routeName,arguments: mainData[index]),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.3),
                                          blurRadius: 10.0,
                                          offset: const Offset(0, 10),
                                          spreadRadius: 1,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.3),
                                                      blurRadius: 15.0,
                                                      offset: const Offset(0, 10),
                                                      spreadRadius: 1,
                                                    ),
                                                  ],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(10.0),
                                                  child: Image.asset(
                                                      "images/logo/category.png"),
                                                ),
                                              ),
                                              Expanded(
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        const Expanded(
                                                          child: Text(
                                                            "Notes Title:",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            "${mainData[index]["NotesTitle"]}",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize: 16),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          queryData.height * 0.01,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Expanded(
                                                          child: Text(
                                                            "Course Name:",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            mainData[index]["Course"].isEmpty
                                                             ? ""
                                                             : "${mainData[index]["Course"][0]["CourseName"]}",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize: 16),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          queryData.height * 0.01,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Expanded(
                                                          child: Text(
                                                            "Category Name:",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            mainData[index]["CourseCategories"].isEmpty
                                                            ? ""
                                                            :"${mainData[index]["CourseCategories"][0]["CategoryName"]}",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize: 16),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          queryData.height * 0.01,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Expanded(
                                                          child: Text(
                                                            "Sub Category Name: ",
                                                            style: TextStyle(
                                                                fontSize: 16),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            mainData[index]["CourseSubCategories"].isEmpty
                                                            ? ""
                                                            : "${mainData[index]["CourseSubCategories"][0]["SubCategoryName"]}",
                                                            style:
                                                                const TextStyle(
                                                                    fontSize: 16),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.3),
                                                          blurRadius: 15.0,
                                                          offset:
                                                              const Offset(0, 10),
                                                          spreadRadius: 1,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(10.0),
                                                      child: IconButton(
                                                    onPressed: () async{
                                                      var result = await getAllCourses
                                                          .deleteNotes(mainData[index]["NotesId"]);
                                                      print(result);
                                                      setState(() {});
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete_forever),
                                                  ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height:
                                                        queryData.height * 0.02,
                                                  ),
                                                ],
                                              )
                                            ],
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
                        :const Center(
                                      child: Text(
                                      "No Notes Found",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 18),
                                    )))
                      : const Center(child: CircularProgressIndicator());
                },
              )
        ),
      ),
    );
  }
}
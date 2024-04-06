import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider_pages/get_courses.dart';

class DetailedNotes extends StatefulWidget {
  static const routeName = "DetailedNotes";
  const DetailedNotes({super.key});

  @override
  State<DetailedNotes> createState() => _DetailedNotesState();
}

class _DetailedNotesState extends State<DetailedNotes> {
  bool showProgress = false;
  String progress = "Downloading...";
  double percent = 0;
  String? path;

  Future _pickFile() async {
    final params = await OpenFileDialogParams(
        dialogType: OpenFileDialogType.document,
        sourceType: SourceType.photoLibrary);

    path = await FlutterFileDialog.pickFile(params: params);
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context).size;
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    print(args);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color(0xFF2B2B2D),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.white,
          ),
        ),
        title: const Text(
          "Notes/Assignment",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        actions: const [
          Icon(
            Icons.shopping_cart,
            color: Colors.white,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
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
                border: Border.all(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Notes Title:",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${args["NotesTitle"]}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: queryData.height * 0.01,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Course Name:",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          args["Course"].isEmpty
                              ? ""
                              : "${args["Course"][0]["CourseName"]}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: queryData.height * 0.01,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Category Name:",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          args["CourseCategories"].isEmpty
                              ? ""
                              : "${args["CourseCategories"][0]["CategoryName"]}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: queryData.height * 0.01,
                  ),
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "Sub Category Name: ",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          args["CourseSubCategories"].isEmpty
                              ? ""
                              : "${args["CourseSubCategories"][0]["SubCategoryName"]}",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: queryData.height * 0.02,
                  ),
                  Visibility(
                      visible: showProgress,
                      child: LinearProgressIndicator(
                        value: percent,
                        color: const Color(0xFF0E1F46),
                        minHeight: 10,
                      )),
                  SizedBox(
                    height: queryData.height * 0.02,
                  ),
                  InkWell(
                    onTap: () => _pickFile().then((value) => setState(() {})),
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1),
                          borderRadius: BorderRadius.circular(10.0)),
                      height: queryData.height * 0.13,
                      width: queryData.width,
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: path != null
                            ? Column(
                                children: [
                                  const Icon(Icons.done_rounded),
                                  SizedBox(
                                    height: queryData.height * 0.02,
                                  ),
                                  const Text(
                                    "File Selected",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  )
                                ],
                              )
                            : const Icon(Icons.cloud_upload),
                      ),
                    ),
                  ),
                  SizedBox(height: queryData.height * 0.02),
                  ElevatedButton(
                    onPressed: () async {
                      if(args["Notes"].isNotEmpty){
                        setState(() {
                        showProgress = true;
                      });
                      Map<Permission, PermissionStatus> statuses =
                          await [Permission.storage].request();
                      if (statuses[Permission.storage]!.isGranted) {
                        getFileName(args["Notes"][0]["file"],getAllCourses);
                      }
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No Notes to Download')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4169E1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: SizedBox(
                      width: queryData.width,
                      height: queryData.height * 0.07,
                      child: const Center(
                        child: Text(
                          "Download",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: queryData.height * 0.02),
                  ElevatedButton(
                    onPressed: () async {
                      if (path != null) {
                        var ress = await getAllCourses.setNotes(
                            args["NotesId"].toString(), path);
                        print(ress);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Assignment Uploaded")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Please! Pick File')));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4169E1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15))),
                    child: SizedBox(
                      width: queryData.width,
                      height: queryData.height * 0.07,
                      child: const Center(
                        child: Text(
                          "Upload Assignment",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Note Download Completed")));
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

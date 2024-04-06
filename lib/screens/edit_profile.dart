import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName = "EditProfileScreen";
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  String? gender;
  DateTime? dueDate = DateTime.now();
  List genderList = ["Male", "Female", "Other"];
  BuildContext? dialogContext;
  TextEditingController dateController = TextEditingController();

  _dropDownWidget(GetCoursesProvider getAll) {
    return DropdownButton<String>(
      dropdownColor: Colors.white,
      isExpanded: true,
      underline: Container(),
      value: gender,
      icon: Icon(Icons.arrow_drop_down,color: Colors.black,),
      elevation: 16,
      hint: Text(
        "Select Gender",
        style: TextStyle(color: Colors.black),
      ),
      onChanged: (String? newVal) {
        setState(() {
          gender = newVal;
          getAll.uGender = newVal;
        });
      },
      items: genderList.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
    );
  }

  Future _selectDate(BuildContext contex,GetCoursesProvider getAllCourses ) async {
    final DateTime? newDate = await showDatePicker(
      context: context,
      initialDate: dueDate!,
      firstDate: DateTime(1950, 1),
      lastDate: DateTime(2030, 7),
      helpText: 'Select a date',
    );
    if (newDate != null) {
      setState(() {
        dueDate = newDate;
        dateController.text = "${dueDate!.year}/${dueDate!.month}/${dueDate!.day}";
        print("hui hui ${getAllCourses.uDob}");
      });
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("EditProfileScreen", "/EditProfileScreen");
    //screenTrack.blockSs();
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context,listen: false);
    dateController.text = (getAllCourses.uDob == null ? null : getAllCourses.uDob) ?? "";
    gender = getAllCourses.uGender == null ? null : getAllCourses.uGender;
  }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    print("${getAllCourses.uName},, ${getAllCourses.uMail},, ${getAllCourses.uDob},, ${getAllCourses.uMob.runtimeType},,, ${getAllCourses.uGender}");
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: Icon(Icons.chevron_left,color: Colors.black,),
        ),
        title: const Text(
          "Edit Profile",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: queryData.size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.black,
                      backgroundImage:  const AssetImage('images/logo/logos.jpg'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: queryData.size.height * 0.02,
            ),
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    TextFormField(
                      initialValue: getAllCourses.uName,
                      onChanged:(value) => getAllCourses.uName = value,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Enter Name',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xFF94ADCF)),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height * 0.02,
                    ),
                    TextFormField(
                      initialValue: getAllCourses.uMob == "null" ? null : getAllCourses.uMob,
                      onChanged: (value) => getAllCourses.uMob = value,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: TextStyle(color: Colors.black),
                      maxLength: 10,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Enter Mobile Number',
                        hintStyle: TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Color(0xFF94ADCF)),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 1, color: Colors.grey),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                    ),
                    // SizedBox(
                    //   height: queryData.size.height * 0.02,
                    // ),
                    Container(
                      height: queryData.size.height * 0.08,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          border:
                              Border.all(width: 1, color: Color(0xFF89909F)),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 3),
                                blurRadius: 8.0,
                                spreadRadius: 2.0),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: _dropDownWidget(getAllCourses),
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height * 0.02,
                    ),
                    // InkWell(
                    //   onTap: () => _selectDate(context),
                    //   child: Container(
                    //     height: queryData.size.height * 0.08,
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //         borderRadius: BorderRadius.circular(20),
                    //         color: Color(0xFFDADADA),
                    //         border: Border.all(
                    //             width: 1, color: Color(0xFF89909F)),
                    //         boxShadow: const [
                    //           BoxShadow(
                    //               color: Colors.black12,
                    //               offset: Offset(0, 3),
                    //               blurRadius: 8.0,
                    //               spreadRadius: 2.0),
                    //         ]),
                    //     child: Padding(
                    //       padding: const EdgeInsets.all(15.0),
                    //       child: Text(
                    //         dueDate == null
                    //         ? "Select D.O.B"
                    //         : "${dueDate!.year}/${dueDate!.month}/${dueDate!.day}",
                    //         style: TextStyle(color: Colors.black),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    InkWell(
                      onTap: () => _selectDate(context, getAllCourses),
                      child: TextFormField(
                        controller: dateController,
                        onChanged: (value) => print("chaging $value"),
                        enabled: false,
                        style: TextStyle(
                            color: Colors.black
                          ),
                        decoration: InputDecoration(
                          labelText: 'D.O.B',
                          labelStyle: TextStyle(
                            color: Colors.black
                          ),
                          hintText: 'Enter D.O.B',
                          hintStyle: TextStyle(
                            color: Colors.black
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFF94ADCF)),
                              borderRadius: BorderRadius.circular(20)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Color(0xFF94ADCF)),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height * 0.04,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                              dialogContext = context;
                              _lodingSection();
                            var result = await getAllCourses.updateUserDetails();
                            getAllCourses.uGender = gender;
                            getAllCourses.uDob = dateController.text;
                            Navigator.of(context).pop(dialogContext);
                            Navigator.of(context).pop(true);
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Profile Updated")));
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF6360FF),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15))),
                      child: SizedBox(
                        width: queryData.size.width,
                        height: queryData.size.height * 0.08,
                        child: const Center(
                          child: Text(
                            "Update Profile",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  _lodingSection(){
    
    return showDialog(
                        context: dialogContext!,
                        builder: (BuildContext context){
                          dialogContext = context;
                          return const Dialog(
                            insetPadding: EdgeInsets.symmetric(horizontal: 0),
                            backgroundColor: Colors.transparent,
                            child: SizedBox(
                              height: double.infinity,
                              width: double.infinity,
                              child: Center(
                                child: SpinKitCircle(
                                  color: const Color(0xFF9A3B81),
                                  size: 100,
                                ),
                              ),
                            ),
                          );
                        }
                      );
                      
  }
}

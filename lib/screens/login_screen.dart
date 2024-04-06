import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../provider_pages/google_sigin.dart';
import '../screen_track.dart';
import 'bottom_nav_screen.dart';
import 'create_account_screen.dart';
import 'enter_email.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = "LoginScreen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool passVisible = false;
  BuildContext? dialogContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack('LoginScreen', "/LoginScreen");
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
              children: [
                Column(
                  children: [
                    Image.asset('images/update/banner.png'),
                    SizedBox(height: queryData.size.height * 0.02,),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                          color: Colors.white,
                          width: queryData.size.width * 0.2,
                          height: queryData.size.height * 0.1,
                          child: Image.asset('images/logo/logos.jpg')),
                    ),
                    SizedBox(
                      height: queryData.size.height * 0.03,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: const Text(
                        "Avinya",
                        style: TextStyle(
                            color: Color(0xFF020064),
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: queryData.size.height * 0.01,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: const Text(
                        "Learn from anything and anywhere",
                        style: TextStyle(
                            color: Color(0xFF020064),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: queryData.size.height * 0.02,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                        color: Color(0xFF4F75FA),
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                TextFormField(
                  controller: _emailController,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Email Id',
                    labelStyle: TextStyle(color: Colors.black),
                    hintText: 'Enter Email Id',
                    hintStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Color(0xFFF0F0F0),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0, style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 0.0, style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                TextFormField(
                  controller: _passController,
                  obscureText: !passVisible,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter Password',
                    hintStyle: TextStyle(color: Colors.black),
                    labelStyle: TextStyle(color: Colors.black),
                    filled: true,
                    fillColor: Color(0xFFF0F0F0),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passVisible ? Icons.visibility : Icons.visibility_off,
                        color: Color(0xFF6360FF),
                      ),
                      onPressed: () {
                        setState(() {
                          passVisible = !passVisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 0.0, style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 0.0, style: BorderStyle.none),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () async {
                    print( await NetworkInterface.list());
                    if (_emailController.text.isNotEmpty &&
                        _passController.text.isNotEmpty) {
                      dialogContext = context;
                      _lodingSection();
                      getAllCourses.uMail = _emailController.text;
                      getAllCourses.uPass = _passController.text;
                      var result = await getAllCourses.loginUser();
                      print(result);
                      if (result["success"] == true) {
                        getAllCourses.uName = result["data"][0]["userName"];
                        getAllCourses.uMail = result["data"][0]["Email"];
                        getAllCourses.uUserId = result["data"][0]["UserId"];
                        getAllCourses.uMob =
                            result["data"][0]["Mobile"].toString();
                        getAllCourses.uGender = result["data"][0]["Gender"];
                        getAllCourses.uDob = result["data"][0]["DOB"];
                        print(
                            "${getAllCourses.uName},, ${getAllCourses.uMail},, ${getAllCourses.uUserId},, ${getAllCourses.uMob},,, ${getAllCourses.uGender}");
                        Navigator.of(context).pop(dialogContext!);
                        Navigator.of(context)
                            .pushNamed(BottomNavScreen.routeName);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Welcome Back User!!")));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                "please enter COrrect email and password")));
                      }

                      //print(result);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4F75FA),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: SizedBox(
                    width: queryData.size.width,
                    height: queryData.size.height * 0.08,
                    child: const Center(
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "Forgot Password?",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontSize: 16)),
                        TextSpan(
                            text: " Click Here",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .pushNamed(EnterEmailScreen.routeName);
                              },
                            style: const TextStyle(
                                color: Color(0xFF1A16DA),
                                fontStyle: FontStyle.italic,
                                fontSize: 16))
                      ]),
                    ),
                  ],
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        const TextSpan(
                            text: "New User?",
                            style: TextStyle(
                                color: Colors.black,
                                fontStyle: FontStyle.italic,
                                fontSize: 16)),
                        TextSpan(
                            text: " Sign Up",
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context)
                                    .pushNamed(CreateAccountScreen.routeName);
                              },
                            style: const TextStyle(
                                color: Color(0xFF1A16DA),
                                fontStyle: FontStyle.italic,
                                fontSize: 16))
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _lodingSection() {
    return showDialog(
        context: dialogContext!,
        builder: (BuildContext context) {
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
        });
  }
}

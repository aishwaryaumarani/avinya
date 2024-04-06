import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../provider_pages/google_sigin.dart';
import '../screen_track.dart';
import 'bottom_nav_screen.dart';
import 'login_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  static const routeName = "CreateAccountScreen";
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool passVisible = false;
  bool boxCheck = false;
  BuildContext? dialogContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("CreateAccountScreen", "/CreateAccountScreen");
    //screenTrack.blockSs();
  }
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    //GoogleProvider googleProvider = Provider.of<GoogleProvider>(context);
    GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/logo/background.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                            width: queryData.size.width * 0.4,
                            height: queryData.size.height * 0.2,
                            color: Colors.white,
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: Image.asset('images/logo/person.png'),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                          color: Color(0xFF020064),
                          fontSize: 28,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Column(
                    children: [
                      SizedBox(
                        height: queryData.size.height * 0.04,
                      ),
                      TextFormField(
                        controller: _nameController,
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Enter Full Name',
                          hintStyle: TextStyle(color: Colors.black),
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Color(0xFFF0F0F0),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0.0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0.0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.02,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email Id',
                          hintText: 'Enter Email Id',
                          hintStyle: TextStyle(color: Colors.black),
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Color(0xFFF0F0F0),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0.0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0.0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.02,
                      ),
                      TextFormField(
                        style: TextStyle(color: Colors.black),
                        obscureText: !passVisible,
                        controller: _passController,
                        decoration: InputDecoration(
                          labelStyle: TextStyle(color: Colors.black),
                          filled: true,
                          fillColor: Color(0xFFF0F0F0),
                          suffixIcon: IconButton(
                            icon: Icon(
                              passVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Color(0xFF6360FF),
                            ),
                            onPressed: () {
                              setState(() {
                                passVisible = !passVisible;
                              });
                            },
                          ),
                          labelText: 'Password',
                          hintText: 'Enter Password',
                          hintStyle: TextStyle(color: Colors.black),
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0.0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(20)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 0.0, style: BorderStyle.none),
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: boxCheck,
                            //checkColor: const Color(0xFF6360FF),
                            //activeColor: Colors.white,
                            side: BorderSide(color: Colors.black),
                            onChanged: (value) => setState(() {
                              boxCheck = value!;
                            }),
                          ),
                          Expanded(
                            child: RichText(
                              textAlign: TextAlign.justify,
                              text: const TextSpan(children: [
                                TextSpan(
                                    text: "By creating an account , you accept",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text: " Terms of Services",
                                    // recognizer: TapGestureRecognizer()
                                    //   ..onTap = () {
                                    //     Navigator.of(context).pushNamed(EnterEmail.routeName);
                                    //   },
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text: " and",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16)),
                                TextSpan(
                                    text: " Privacy Policy .",
                                    // recognizer: TapGestureRecognizer()
                                    //   ..onTap = () {
                                    //     Navigator.of(context).pushNamed(EnterEmail.routeName);
                                    //   },
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16))
                              ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.04,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          if (_nameController.text.isNotEmpty &&
                              _emailController.text.isNotEmpty &&
                              _passController.text.isNotEmpty &&
                              boxCheck) {
                            dialogContext = context;
                            _lodingSection();
                            getAllCourses.uName = _nameController.text;
                            getAllCourses.uMail = _emailController.text;
                            getAllCourses.uPass = _passController.text;
                            var result = await getAllCourses.registerUser();
                            print(result);
                            if (result["success"] == true) {
                              Navigator.of(context).pop(dialogContext!);
                              Navigator.of(context)
                                  .pushNamed(BottomNavScreen.routeName);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("Welcome New User!!")));
                              getAllCourses.uUserId = result["data"]["UserId"];
                            } else {
                              Navigator.of(context).pop(dialogContext!);
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Please enter correct details")));
                            }

                            print("hui hui ${result}");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Please fill all the details")));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0E1F46),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: SizedBox(
                          width: queryData.size.width,
                          height: queryData.size.height * 0.08,
                          child: const Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: queryData.size.height * 0.02,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: "Already Registred ?",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16)),
                              TextSpan(
                                  text: " Sign Up",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.of(context)
                                          .pushNamed(LoginScreen.routeName);
                                    },
                                  style: TextStyle(
                                      color: Color(0xFF1A16DA),
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16))
                            ]),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
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

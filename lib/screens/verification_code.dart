import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import 'login_screen.dart';

class VerificationCodeScreen extends StatefulWidget {
  static const routeName = "VerificationCodeScreen";
  const VerificationCodeScreen({Key? key}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final _otpVerfification = TextEditingController();
  final _passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("VerificationCodeScreen", "/VerificationCodeScreen");
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
                          width: queryData.size.width * 0.2,
                          height: queryData.size.height * 0.1,
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
                SizedBox(height: queryData.size.height * 0.02,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(
                        color: Color(0xFF4169E1),
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.03,
                ),
                TextFormField(
                  controller: _otpVerfification,
                  style: TextStyle(color: Colors.black),
                  // focusNode: myFocusNode1,
                  // onChanged: (val) {
                  //   networkProviderState.umail = val;
                  // },
                  decoration: InputDecoration(
                    // label: const Center(
                    //   child: Text(
                    //     '_  _  _ _ _ _',
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    // ),
                    hintText: 'Enter Verifications Code ',
                    hintStyle: TextStyle(color: Colors.black),
                    // labelStyle: TextStyle(
                    //     color: myFocusNode1.hasFocus
                    //         ? const Color(0xFFE52D2D)
                    //         : const Color(0xFF303640)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFF94ADCF)),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                TextFormField(
                  controller: _passController,
                  style: TextStyle(color: Colors.black),
                  // focusNode: myFocusNode1,
                  // onChanged: (val) {
                  //   networkProviderState.umail = val;
                  // },
                  decoration: InputDecoration(
                    // label: const Center(
                    //   child: Text(
                    //     '_  _  _ _ _ _',
                    //     textAlign: TextAlign.center,
                    //     style: TextStyle(color: Colors.black),
                    //   ),
                    // ),
                    hintText: 'Enter New Password',
                    hintStyle: TextStyle(color: Colors.black),
                    // labelStyle: TextStyle(
                    //     color: myFocusNode1.hasFocus
                    //         ? const Color(0xFFE52D2D)
                    //         : const Color(0xFF303640)),
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 1, color: Color(0xFF94ADCF)),
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(20)),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () async {
                    getAllCourses.uPass = _passController.text;
                    var result =
                        getAllCourses.resetPass(_otpVerfification.text);
                    print("sheesh $result");
                    Navigator.of(context).pushNamed(LoginScreen.routeName);
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Password Reseted")));
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4169E1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: SizedBox(
                    width: queryData.size.width,
                    height: queryData.size.height * 0.07,
                    child: const Center(
                      child: Text(
                        "Verify",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import 'verification_code.dart';

class EnterEmailScreen extends StatefulWidget {
  static const routeName = "EnterEmailScreen";
  const EnterEmailScreen({Key? key}) : super(key: key);

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("EnterEmailScreen", "/EnterEmailScreen");
    //screenTrack.blockSs();
  }
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    //GoogleProvider googleProvider = Provider.of<GoogleProvider>(context);
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
                Column(
                  children: [
                    TextFormField(
                      style: TextStyle(color: Colors.black),
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'Email Id',
                        hintText: 'Enter Email Id',
                        labelStyle: TextStyle(color: Colors.black),
                        filled: true,
                        fillColor: Color(0xFFF0F0F0),
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
                      height: queryData.size.height * 0.04,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        getAllCourses.uMail = _controller.text;
                        var result = await getAllCourses.sendEmail();
                        print("shse ${result["statusText"].runtimeType}");

                        if(result["statusText"].contains("Success")){
                          Navigator.of(context)
                            .pushNamed(VerificationCodeScreen.routeName);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please Check Email For OTP.")));
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result["message"])));
                        }
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
                            "Send",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

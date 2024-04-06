
import 'package:flutter/material.dart';

import '../screen_track.dart';
import 'bottom_nav_screen.dart';

class OrderSuccessScreen extends StatefulWidget {
  static const routeName = "OrderSuccessScreen";
  const OrderSuccessScreen({Key? key}) : super(key: key);

  @override
  State<OrderSuccessScreen> createState() => _OrderSuccessScreenState();
}

class _OrderSuccessScreenState extends State<OrderSuccessScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("OrderSuccessScreen", "/OrderSuccessScreen");
    //
  }
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Color(0xFF2B2B2D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SizedBox(
            width: queryData.size.width,
            height: queryData.size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: queryData.size.height * 0.04,
                ),
                const Text(
                  "SUCCESS!",
                  style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Center(
                      child: Stack(
                        clipBehavior: Clip.none,
                      children: [
                        Image.asset('images/logo/overlay.png'),
                        Positioned(
                      bottom: -20,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.green),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.check,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                      ],
                    )),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Center(child: Image.asset('images/logo/group1.png')),
                    ),
                  ],
                ),
                SizedBox(
                  height: queryData.size.height * 0.04,
                ),
                const Text(
                  "Your order is sucessful.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                const Text(
                  "Thank you for choosing our app!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: queryData.size.height * 0.05,
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.of(context).pushNamed(AddPaymentScreen.routeName);
                //   },
                //   style: ElevatedButton.styleFrom(
                //       primary: Colors.white,
                //       shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(15))),
                //   child: SizedBox(
                //     width: queryData.size.width,
                //     height: queryData.size.height * 0.08,
                //     child: const Center(
                //       child: Text(
                //         "Enjoy your Courses",
                //         style: TextStyle(color: Colors.black),
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(BottomNavScreen.routeName);
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: SizedBox(
                    width: queryData.size.width,
                    height: queryData.size.height * 0.08,
                    child: const Center(
                      child: Text(
                        "BACK TO HOME",
                        style: TextStyle(color: Colors.black),
                      ),
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

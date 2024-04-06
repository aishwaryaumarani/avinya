
import 'package:flutter/material.dart';

import '../screen_track.dart';
import 'order_success_screen.dart';

class AddPaymentScreen extends StatefulWidget {
  static const routeName = "AddPaymentScreen";
  const AddPaymentScreen({Key? key}) : super(key: key);

  @override
  State<AddPaymentScreen> createState() => _AddPaymentScreenState();
}

class _AddPaymentScreenState extends State<AddPaymentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("AddPaymentScreen", "/AddPaymentScreen");
    //screenTrack.blockSs();
  }
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: Icon(Icons.chevron_left,color: Colors.black,),
        ),
        title: const Text(
          "Add Payment Method",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Center(child: Image.asset('images/logo/card.png')),
            SizedBox(
              height: queryData.size.height * 0.04,
            ),
            TextFormField(
              style: TextStyle(color: Colors.black),
              initialValue: "Ex: Bruno Pham",
              // focusNode: myFocusNode1,
              // onChanged: (val) {
              //   networkProviderState.umail = val;
              // },
              decoration: const InputDecoration(
                labelText: 'CardHolder Name',
                labelStyle: TextStyle(color: Colors.black),
                hintText: 'Enter CardHolder Name',
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                // labelStyle: TextStyle(
                //     color: myFocusNode1.hasFocus
                //         ? const Color(0xFFE52D2D)
                //         : const Color(0xFF303640)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xFFDBDBDB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xFFDBDBDB)),
                ),
              ),
            ),
            SizedBox(
              height: queryData.size.height * 0.04,
            ),
            TextFormField(
              initialValue: "**** **** **** 3456",
              style: TextStyle(color: Colors.black),
              // focusNode: myFocusNode1,
              // onChanged: (val) {
              //   networkProviderState.umail = val;
              // },
              decoration: const InputDecoration(
                labelText: 'Card Number',
                hintText: 'Enter Card Number',
                labelStyle: TextStyle(color: Colors.black),
                hintStyle: TextStyle(color: Colors.black),
                filled: true,
                fillColor: Colors.white,
                // labelStyle: TextStyle(
                //     color: myFocusNode1.hasFocus
                //         ? const Color(0xFFE52D2D)
                //         : const Color(0xFF303640)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xFFDBDBDB)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Color(0xFFDBDBDB)),
                ),
              ),
            ),
            SizedBox(height: queryData.size.height * 0.04),
            Row(
              children: [
                SizedBox(
                  width: queryData.size.width * 0.4,
                  child: TextFormField(
                    initialValue: "Ex: 123",
                    style: TextStyle(color: Colors.black),
                    // focusNode: myFocusNode1,
                    // onChanged: (val) {
                    //   networkProviderState.umail = val;
                    // },
                    decoration:  InputDecoration(
                      labelText: 'CVV',
                      hintText: 'Enter CVV',
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      // labelStyle: TextStyle(
                      //     color: myFocusNode1.hasFocus
                      //         ? const Color(0xFFE52D2D)
                      //         : const Color(0xFF303640)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFDBDBDB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFDBDBDB)),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: queryData.size.width * 0.08,
                ),
                SizedBox(
                  width: queryData.size.width * 0.4,
                  child: TextFormField(
                    initialValue: "03/22",
                    style: TextStyle(color: Colors.black),
                    // focusNode: myFocusNode1,
                    // onChanged: (val) {
                    //   networkProviderState.umail = val;
                    // },
                    decoration: const InputDecoration(
                      labelText: 'Expiration Date',
                      hintText: 'Expiration Date',
                      labelStyle: TextStyle(color: Colors.black),
                      hintStyle: TextStyle(color: Colors.black),
                      filled: true,
                      fillColor: Colors.white,
                      // labelStyle: TextStyle(
                      //     color: myFocusNode1.hasFocus
                      //         ? const Color(0xFFE52D2D)
                      //         : const Color(0xFF303640)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFDBDBDB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 1, color: Color(0xFFDBDBDB)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: queryData.size.height * 0.04,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(OrderSuccessScreen.routeName);
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15))),
              child: SizedBox(
                width: queryData.size.width,
                height: queryData.size.height * 0.08,
                child: const Center(
                  child: Text(
                    "ADD NEW CARD",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

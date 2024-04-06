import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import 'add_payment_screen.dart';
import 'order_success_screen.dart';

class ConfirmCHeckoutScreen extends StatefulWidget {
  static const routeName = "ConfirmCHeckoutScreen";
  const ConfirmCHeckoutScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmCHeckoutScreen> createState() => _ConfirmCHeckoutScreenState();
}

class _ConfirmCHeckoutScreenState extends State<ConfirmCHeckoutScreen> {
  String selectedSTate = "Andaman and Nicobar Islands";
  int stateId = 1;
  //final _razorpay = Razorpay();
  _dropdownWidget(List mainList) {
    List stateList = [];
    for (var element in mainList) {
      stateList.add(element["State"]);
    }

    return DropdownButton(
      isExpanded: true,
      value: selectedSTate,
      icon: const Icon(
        Icons.arrow_drop_down,
        color: Colors.black,
      ),
      dropdownColor: Colors.white,
      onChanged: ((String? value) {
        setState(() {
          selectedSTate = value!;
          for (var element in mainList) {
            if (element["State"].contains(selectedSTate)) {
              stateId = element["StateId"];
            }
          }
        });
      }),
      items: stateList.map<DropdownMenuItem<String>>((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(
            e,
            style: TextStyle(color: Colors.black),
          ),
        );
      }).toList(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    // _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    // _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("ConfirmCHeckoutScreen", "/ConfirmCHeckoutScreen");
    //screenTrack.blockSs();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    //_razorpay.clear();
  }

  // void _handlePaymentSuccess(PaymentSuccessResponse response) async {
  //   // Do something when payment succeeds
  //   GetCoursesProvider getAllCourses =
  //       Provider.of<GetCoursesProvider>(context, listen: false);
  //   var resultss = await getAllCourses.verifyPayment(
  //       response.orderId, response.paymentId, response.signature);

  //   print(
  //       "aide chali ${response.orderId}   ${response.paymentId}   ${response.signature}");
  //   print("payment success ${resultss}");
  //   Navigator.of(context).pushNamed(OrderSuccessScreen.routeName);
  // }

  // void _handlePaymentError(PaymentFailureResponse response) {
  //   // Do something when payment fails
  //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error caused due to: ${response.error}")));
  // }

  // void _handleExternalWallet(ExternalWalletResponse response) {
  //   // Do something when an external wallet is selected
  // }

  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    GetCoursesProvider coursesProvider = Provider.of<GetCoursesProvider>(context);
    Map args = ModalRoute.of(context)!.settings.arguments as Map;
    print(args);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          ),
        ),
        title: const Text(
          "Checkout",
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Billing Address",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 24),
                ),
                SizedBox(
                  height: queryData.size.height * 0.04,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Country ",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    Text(
                      "Required",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5), fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Container(
                  height: queryData.size.height * 0.1,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      border: Border.all(width: 2, color: Colors.black),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 3),
                            blurRadius: 8.0,
                            spreadRadius: 2.0),
                      ]),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "India",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                        Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        )
                      ],
                    )),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "State",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    Text(
                      "Required",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5), fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                FutureBuilder(
                  future: coursesProvider.getAllCountry(),
                  builder: (context, snapshot) {
                    List list =[];
                    if (snapshot.hasData) {
                      for (var element in (snapshot.data as Map)["data"]) {
                        list.add(element["State"]);
                      }
                    }
                    return snapshot.hasData
                        ? Container(
                            height: queryData.size.height * 0.1,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 3),
                                      blurRadius: 8.0,
                                      spreadRadius: 2.0),
                                ]),
                            child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: _dropdownWidget((snapshot.data as Map)["data"])),
                          )
                        : Container(
                            height: queryData.size.height * 0.1,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                border:
                                    Border.all(width: 2, color: Colors.black),
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0, 3),
                                      blurRadius: 8.0,
                                      spreadRadius: 2.0),
                                ]),
                            child: Container());
                  },
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Payment",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    Icon(
                      Icons.drive_file_rename_outline,
                      color: Colors.black.withOpacity(0.5),
                    )
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
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white),
                  child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Container(
                              color: Colors.white,
                              width: queryData.size.width * 0.2,
                              height: queryData.size.height * 0.1,
                              child: Image.asset('images/logo/logos.jpg')),
                          SizedBox(
                            width: queryData.size.width * 0.05,
                          ),
                          const Text(
                            "**** **** **** 3947",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w400),
                          )
                        ],
                      )),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                const Text(
                  "Order",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 24),
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
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${args["CourseName"]}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                height: queryData.size.height * 0.02,
                              ),
                              Text(
                                "${args["CoursePrice"]}",
                                style: TextStyle(
                                    color: Colors.black,
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
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  Text(
                                    "•",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  Text(
                                    "Dr. Sandip Gawate",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  Text(
                                    "•",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 14,
                                    ),
                                  ),
                                  SizedBox(
                                    width: queryData.size.width * 0.02,
                                  ),
                                  Expanded(
                                    child: Text(
                                      "All Level",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 14,
                                      ),
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
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                const Text(
                  "Summary",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 24),
                ),
                SizedBox(
                  height: queryData.size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Original Price:",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    Text(
                      "${args["CoursePrice"]}",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5), fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Divider(
                  height: queryData.size.height * 0.03,
                  color: Colors.black,
                ),
                SizedBox(
                  height: queryData.size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total :",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    Text(
                      "${args["CoursePrice"]}",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: queryData.size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total :",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: 18),
                    ),
                    Text(
                      "${args["CoursePrice"]}",
                      style: TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ],
                ),
                SizedBox(
                  height: queryData.size.height * 0.04,
                ),
                RichText(
                  text: const TextSpan(children: [
                    TextSpan(
                        text:
                            "By completing your purchase you agree to these",
                        style: TextStyle(
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontSize: 14)),
                    TextSpan(
                        text: " Terms of Service",
                        // recognizer: TapGestureRecognizer()
                        //   ..onTap = () {
                        //     Navigator.of(context).pushNamed(EnterEmail.routeName);
                        //   },
                        style: TextStyle(
                            color: Color(0xFFFF5F00),
                            fontStyle: FontStyle.italic,
                            fontSize: 14))
                  ]),
                ),
                SizedBox(
                  height: queryData.size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () async {
                    // var result = await coursesProvider.createBilling(
                    //     stateId, args["OrderId"]);
                    // print(result);

                    // var resss = await coursesProvider.getRazorOrderId(args["CoursePrice"], 'reciept_${result["data"]["BillinId"]}');
                    // print(resss);
                    // var options = {
                    //   'key': 'rzp_test_kPZ8zlt5xa2LYh',
                    //   'amount': 100, //in the smallest currency sub-unit.
                    //   'name': 'Sparse matrix.',
                    //   'order_id':
                    //       resss["id"], // Generate order_id using Orders API
                    //   'description': 'Fine T-Shirt',
                    //   'timeout': 60, // in seconds
                    //   'prefill': {
                    //     'email': coursesProvider.uMail
                    //   }
                    // };

                    // _razorpay.open(options);
                    Navigator.of(context)
                        .pushNamed(AddPaymentScreen.routeName);
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
                        "Complete Checkout",
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
    );
  }
}

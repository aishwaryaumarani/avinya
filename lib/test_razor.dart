
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// import 'provider_pages/get_courses.dart';

// class TestRazor extends StatefulWidget {
//   const TestRazor({super.key});

//   @override
//   State<TestRazor> createState() => _TestRazorState();
// }

// class _TestRazorState extends State<TestRazor> {
//   final _razorpay = Razorpay();

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _razorpay.clear();
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     // Do something when payment succeeds
//     GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context, listen: false);
//     var resultss = await getAllCourses.verifyPayment(response.orderId, response.paymentId, response.signature);

//     print("aide chali ${response.orderId}   ${response.paymentId}   ${response.signature}");
//     print("payment success ${resultss}");
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     // Do something when payment fails
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     // Do something when an external wallet is selected
//   }
//   @override
//   Widget build(BuildContext context) {
//     GetCoursesProvider getAllCourses = Provider.of<GetCoursesProvider>(context);
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Center(
//           child: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * 0.08,
//             child: ElevatedButton(
//               onPressed: () async {
//                 var result = await getAllCourses.getRazorOrderId(44,44);
//                 print(result);
//                 var options = {
//                   'key': 'rzp_test_kPZ8zlt5xa2LYh',
//                   'amount': 100, //in the smallest currency sub-unit.
//                   'name': 'Sparse matrix.',
//                   'order_id':result["id"], // Generate order_id using Orders API
//                   'description': 'Fine T-Shirt',
//                   'timeout': 60, // in seconds
//                   'prefill': {
//                     'contact': '919876543210',
//                     'email': 'aa@example.com'
//                   }
//                 };

//                 _razorpay.open(options);
//               },
//               child: Center(
//                   child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Text("Pay Full Money"),
//               )),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

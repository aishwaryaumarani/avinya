
import 'package:english_copy/screens/webview_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../provider_pages/get_courses.dart';
import '../screen_track.dart';
import 'confirm_checkout.dart';

class CheckoutScreen extends StatefulWidget {
  static const routeName = "CheckoutScreen";
  const CheckoutScreen({Key? key}) : super(key: key);

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int totalPrice = 0;
  BuildContext? dialogContext;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("CheckoutScreen", "/CheckoutScreen");
    //screenTrack.blockSs();
  }
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    List args = ModalRoute.of(context)!.settings.arguments as List;
    GetCoursesProvider getCoursesProvider = Provider.of<GetCoursesProvider>(context);
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
          icon: Icon(Icons.chevron_left,color: Colors.black,),
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
                ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  reverse: false,
                  itemCount: args.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: Column(
                        children: [
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
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.white),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${args[index]["Course"][0]['CourseName']}",
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(
                                          height: queryData.size.height * 0.02,
                                        ),
                                        Text(
                                          "₹ ${args[index]["Course"][0]['CoursePrice']}",
                                          style: const TextStyle(
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
                                              width:
                                                  queryData.size.width * 0.02,
                                            ),
                                            const Text(
                                              "4.5",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  queryData.size.width * 0.02,
                                            ),
                                             Text(
                                              "•",
                                              style: TextStyle(
                                                color: Colors.black.withOpacity(0.5),
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  queryData.size.width * 0.02,
                                            ),
                                             Text(
                                              "By Sarah William",
                                              style: TextStyle(
                                                color: Colors.black.withOpacity(0.5),
                                                fontSize: 14,
                                              ),
                                            ),
                                            SizedBox(
                                              width:
                                                  queryData.size.width * 0.02,
                                            ),
                                             Text(
                                              "•",
                                              style: TextStyle(
                                                color: Colors.black.withOpacity(0.5),
                                                fontSize: 14,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height:queryData.size.height * 0.01,),
                                             Text(
                                              "All Level",
                                              style: TextStyle(
                                                color: Colors.black.withOpacity(0.5),
                                                fontSize: 14,
                                              ),
                                            ),
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
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: queryData.size.height * 0.02,
                ),
                Divider(
                  height: queryData.size.height * 0.01,
                  color:  Colors.black,
                ),
                SizedBox(
                  height: queryData.size.height * 0.03,
                ),
                Text(
                  "Total : ₹ ${args[0]["Course"][0]['CoursePrice']}",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: queryData.size.height * 0.04,
                ),
                ElevatedButton(
                  onPressed: () async{
                    print("hi hi hi hi $args");
                    dialogContext = context;
                    _lodingSection();
                    print(args[0]["Course"][0]["CoursePrice"].toString());
                    var res = await getCoursesProvider.payment(args[0]["Course"][0]["CoursePrice"].toString());
                    Navigator.of(context).pop(dialogContext);
                    Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => WebviePayment(
                        mainUrl: res["payment_request"]["longurl"],
                        onFinish: (number) async {
                          // payment done
                          final snackBar = SnackBar(
                            content: Text("Payment done Successfully"),
                            duration: Duration(seconds: 5),
                            action: SnackBarAction(
                              label: 'Close',
                              onPressed: () {
                                // Some code to undo the change.
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  );
                    print("hui hui");
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6360FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                  child: SizedBox(
                    width: queryData.size.width,
                    height: queryData.size.height * 0.06,
                    child: const Center(
                      child: Text(
                        "Checkout Now",
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

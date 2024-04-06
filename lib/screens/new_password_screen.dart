import 'package:flutter/material.dart';

import '../screen_track.dart';

class NewPasswordScreen extends StatefulWidget {
  static const routeName = "NewPasswordScreen";
  const NewPasswordScreen({Key? key}) : super(key: key);

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FIrebaseScreenTrack screenTrack = FIrebaseScreenTrack();
    screenTrack.screenTrack("NewPasswordScreen", "/NewPasswordScreen");
    //screenTrack.blockSs();
  }
  @override
  Widget build(BuildContext context) {
    var queryData = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/logo/background.png'),
                fit: BoxFit.cover)),
        child: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        width: queryData.size.width * 0.4,
                        height: queryData.size.height * 0.2,
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('images/logo/logos.jpg'),
                        )),
                  ),
                  SizedBox(
                    height: queryData.size.height * 0.03,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
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
                    alignment: Alignment.centerLeft,
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
                  "New Password",
                  style: TextStyle(
                      color: Color(0xFF020064),
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(
                height: queryData.size.height * 0.02,
              ),
              TextFormField(
                // focusNode: myFocusNode1,
                // onChanged: (val) {
                //   networkProviderState.umail = val;
                // },
                decoration: InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter New Password ',
                  // labelStyle: TextStyle(
                  //     color: myFocusNode1.hasFocus
                  //         ? const Color(0xFFE52D2D)
                  //         : const Color(0xFF303640)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Color(0xFF94ADCF)),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: const Icon(
                    Icons.lock,
                    // color: myFocusNode1.hasFocus
                    //     ? const Color(0xFFE52D2D)
                    //     : const Color(0xFF303640)),
                  ),
                ),
              ),
              SizedBox(
                height: queryData.size.height * 0.02,
              ),
              TextFormField(
                // focusNode: myFocusNode1,
                // onChanged: (val) {
                //   networkProviderState.umail = val;
                // },
                decoration: InputDecoration(
                  labelText: 'Confirm  Password ',
                  hintText: 'Enter Confirm  Password ',
                  // labelStyle: TextStyle(
                  //     color: myFocusNode1.hasFocus
                  //         ? const Color(0xFFE52D2D)
                  //         : const Color(0xFF303640)),
                  enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Color(0xFF94ADCF)),
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  prefixIcon: const Icon(
                    Icons.lock,
                    // color: myFocusNode1.hasFocus
                    //     ? const Color(0xFFE52D2D)
                    //     : const Color(0xFF303640)),
                  ),
                ),
              ),
              SizedBox(
                height: queryData.size.height * 0.04,
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF020064),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15))),
                child: SizedBox(
                  width: queryData.size.width,
                  height: queryData.size.height * 0.08,
                  child: const Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

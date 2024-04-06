import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class GetCoursesProvider extends ChangeNotifier {
  String? uName;
  String? uMob;
  String? uMail;
  String? uPass;
  String? uUserId;
  String? uDob;
  String? uGender;
  double percent = 0;

  void changeValue(double value) {
    percent = value;
    notifyListeners();
  }

  Future getAllCourses() async {
    Uri uri =
        Uri.parse("https://api.aavinya.app/api/v1/Course/getAllCourseDetails");
    var response = await http.get(uri);

    var decode = jsonDecode(response.body);

    return decode;
  }

  Future getCourseCategory() async {
    Uri categoryUri = Uri.parse(
        "https://api.aavinya.app/api/v1/Category/getAllCourseCategory");
    var response = await http.get(categoryUri);

    var decode = jsonDecode(response.body);

    return decode;
  }

  Future getSUbCategory() async {
    Uri subUri = Uri.parse(
        "https://api.aavinya.app/api/v1/SubCategory/getAllCourseSubCategory");
    var response = await http.get(subUri);

    var decode = jsonDecode(response.body);

    return decode;
  }

  Future getLessons(int courseId) async {
    print("hoi hoi $courseId");
    Uri uriLessons = Uri.parse(
        "https://api.aavinya.app/api/v1/lesson/getAlllessionDetailsbyCourse");

    var responses = await http.post(
      uriLessons,
      body: jsonEncode({"CourseId": courseId}),
      headers: {"Content-Type": "application/json"},
    );

    var decode = jsonDecode(responses.body);
    return decode;
  }

  Future addToCart(int courseId, BuildContext context) async {
    try {
      Uri uriCart = Uri.parse(
          "https://api.aavinya.app/api/v1/addtocart/CreateaddtoCartDetails");
      var response = await http.post(uriCart,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "CourseId": courseId,
            "UserId": uUserId,
          }));

      var decoded = jsonDecode(response.body);
      return decoded;
    } catch (e) {
      return e.toString();
    }
  }

  Future getAllCart() async {
    try {
      Uri getAllcartUri =
          Uri.parse("https://api.aavinya.app/api/v1/addtocart/getAllCart");

      var response = await http.get(getAllcartUri);

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future addReviews(
      String userId, double ratingss, int courseId, String comments) async {
    try {
      Uri reviewUri =
          Uri.parse("https://api.aavinya.app/api/v1/Review/CreatereviewDetails");

      var response = await http.post(
        reviewUri,
        body: jsonEncode(<String, dynamic>{
          "UserId": userId,
          "ratingNo": ratingss,
          "CourseId": courseId,
          "Comment": comments
        }),
        headers: {"Content-Type": "application/json"},
      );
      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future getReviews() async {
    try {
      Uri allReviews =
          Uri.parse("https://api.aavinya.app/api/v1/Review/getAllReview");

      var response = await http.get(allReviews);

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future getquizByCourseId(int courseId) async {
    try {
      Uri getQuiz = Uri.parse(
          "https://api.aavinya.app/api/v1/Quiz/getQuizDetailsbyCourseId");

      var response = await http.post(
        getQuiz,
        body: jsonEncode({"CourseId": courseId}),
        headers: {"Content-Type": "application/json"},
      );

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future deleteCart(int enrollmentId) async {
    try {
      Uri delUri = Uri.parse(
          "https://api.aavinya.app/api/v1/addtocart/deleteCartDetails/$enrollmentId");

      var response = await http.delete(delUri);

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future addQuizScore(int CourseId, String CourseName, int QuizId,
      int TotalQuestion, int TotalCorrectAnswer, int TotalWorngAnswer) async {
    try {
      Uri quizTest =
          Uri.parse("https://api.aavinya.app/api/v1/Score/CreateScoreDetails");
      var response = await http.post(
        quizTest,
        body: jsonEncode({
          "UserId": uUserId,
          "userName": uName,
          "CourseId": CourseId,
          "CourseName": CourseName,
          "QuizId": QuizId,
          "TotalQuestion": TotalQuestion,
          "TotalCorrectAnswer": TotalCorrectAnswer,
          "TotalWorngAnswer": TotalWorngAnswer
        }),
        headers: {"Content-Type": "application/json"},
      );
      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future addOrderDetails(int courseId, int total) async {
    try {
      Uri orderUri =
          Uri.parse("https://api.aavinya.app/api/v1/Order/CreateOrderDetails");

      var response = await http.post(
        orderUri,
        body: jsonEncode({"CourseId": courseId, "Total": total}),
        headers: {"Content-Type": "application/json"},
      );

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future getAllCountry() async {
    try {
      Uri urii = Uri.parse("https://api.aavinya.app/api/v1/State/getAllState");

      var response = await http.get(urii);

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future createBilling(int stateid, int orderid) async {
    try {
      Uri urii = Uri.parse(
          "https://api.aavinya.app/api/v1/Billing/CreatebillingDetails");

      var response = await http.post(
        urii,
        body: jsonEncode({
          "CountryId": 1,
          "StateId": stateid,
          "UserId": uUserId,
          "OrderId": orderid
        }),
        headers: {"Content-Type": "application/json"},
      );
      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future lessonisComplete(
      int lessionId, int CourseId, int CategoryId, int SubCategoryId) async {
    try {
      Uri urii =
          Uri.parse("https://api.aavinya.app/api/v1/createlessoniscomplated");

      var response = await http.post(
        urii,
        body: jsonEncode({
          "lessionId": lessionId,
          "UserId": uUserId,
          "CourseId": CourseId,
          "CategoryId": CategoryId,
          "SubCategoryId": SubCategoryId,
          "Iscomplated": true
        }),
        headers: {"Content-Type": "application/json"},
      );

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future getBannerImages() async {
    try {
      Uri urii =
          Uri.parse("https://api.aavinya.app/api/v1/banner/getAllBannerDetails");

      var response = await http.get(urii);

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future getLessonIsCompleted() async {
    try {
      Uri uriii = Uri.parse(
          "https://api.aavinya.app/api/v1/lession/getAlllessionDetails");

      var response = await http.get(uriii);

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future registerUser() async {
    try {
      Uri uriii =
          Uri.parse("https://api.aavinya.app/api/v1/user/CreateUserDetails");

      var response = await http.post(
        uriii,
        body: jsonEncode({
          "userName": uName,
          "Mobile": uMob,
          "Email": uMail,
          "Password": uPass,
          "AccountStatus": true
        }),
        headers: {"Content-Type": "application/json"},
      );

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {}
  }

  Future loginUser() async {
    try {
      Uri uriii = Uri.parse("https://api.aavinya.app/api/v1/user/Userlogin");

      var response = await http.post(
        uriii,
        body: jsonEncode({
          "Email": uMail,
          "Password": uPass,
        }),
        headers: {"Content-Type": "application/json"},
      );

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future sendEmail() async {
    try {
      Uri uriii =
          Uri.parse("https://api.aavinya.app/api/v1/user/emailSendforUser");

      var response = await http.post(
        uriii,
        body: jsonEncode({"Email": uMail}),
        headers: {"Content-Type": "application/json"},
      );

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future resetPass(String otp) async {
    try {
      Uri uriii =
          Uri.parse("https://api.aavinya.app/api/v1/user/changePasswordforUser");

      var response = await http.post(
        uriii,
        body: jsonEncode({"Email": uMail, "Password": uPass, "otp": otp}),
        headers: {"Content-Type": "application/json"},
      );

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future updateUserDetails() async {
    try {
      Uri uriii =
          Uri.parse("https://api.aavinya.app/api/v1/user/updateUserDetails");

      var response = await http.put(
        uriii,
        body: jsonEncode({
          "UserId": uUserId,
          "userName": uName,
          "Mobile": uMob,
          "dob": uDob,
          "Gender": uGender
        }),
        headers: {"Content-Type": "application/json"},
      );

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future getCourseByCOurseId(int courseId) async {
    try {
      Uri urii = Uri.parse(
          "https://api.aavinya.app/api/v1/Course/getSingleCourseDetails");

      var response = await http.post(
        urii,
        body: jsonEncode({"CourseId": courseId}),
        headers: {"Content-Type": "application/json"},
      );

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future getRazorOrderId(var amount, var recipt) async {
    try {
      Uri uriii = Uri.parse(
          "https://paymentgateway01.azurewebsites.net/api/v1/CreateOrder");

      var response = await http.post(
        uriii,
        body: jsonEncode({"amount": amount, "receipt": recipt}),
        headers: {"Content-Type": "application/json"},
      );

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future verifyPayment(var orderId, var paymentId, var signature) async {
    try {
      Uri uriii = Uri.parse(
          "https://paymentgateway01.azurewebsites.net/api/v1/payVerify");

      var response = await http.post(
        uriii,
        body: jsonEncode({
          "orderId": orderId,
          "paymentId": paymentId,
          "signature": signature
        }),
        headers: {"Content-Type": "application/json"},
      );

      var decode = response.body;

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future addSaveLater(int courseId, BuildContext context) async {
    try {
      Uri uriCart =
          Uri.parse("https://api.aavinya.app/api/v1/CreateSaveforLaterDetails");
      var response = await http.post(uriCart,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "CourseId": courseId,
            "UserId": uUserId,
          }));

      var decoded = jsonDecode(response.body);
      return decoded;
    } catch (e) {
      return e.toString();
    }
  }

  Future getSaveLater() async {
    try {
      Uri getAllcartUri =
          Uri.parse("https://api.aavinya.app/api/v1/getAllSaveforLater");

      var response = await http.get(getAllcartUri);

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future deleteSaveforLater(int enrollmentId) async {
    try {
      Uri delUri = Uri.parse(
          "https://api.aavinya.app/api/v1/deleteSaveforLaterDetails/$enrollmentId");

      var response = await http.delete(delUri);

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future getZoomByCourseId(int courseId) async {
    try {
      Uri urii = Uri.parse(
          "https://api.aavinya.app/api/v1/getAllLiveClassDetailsbyCourseId");

      var response = await http.post(
        urii,
        body: jsonEncode({"CourseId": courseId}),
        headers: {"Content-Type": "application/json"},
      );

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future addLessonCompleted(int courseId) async {
    try {
      Uri uriCart = Uri.parse(
          "https://api.aavinya.app/api/v1/CreateInprogressCourseDetails");
      var response = await http.post(uriCart,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "CourseId": courseId,
            "UserId": uUserId,
          }));

      var decoded = jsonDecode(response.body);
      return decoded;
    } catch (e) {
      return e.toString();
    }
  }

  Future getLessonCompleted() async {
    try {
      Uri urii = Uri.parse(
          "https://api.aavinya.app/api/v1/getAllInprogressCoursebyUserId");

      var response = await http.post(
        urii,
        body: jsonEncode({"UserId": uUserId}),
        headers: {"Content-Type": "application/json"},
      );

      var decode = jsonDecode(response.body);

      return decode;
    } catch (e) {
      return e.toString();
    }
  }

  Future uploadLessonCompleted(int courseId, int lessonId) async {
    try {
      Uri uriCart =
          Uri.parse("https://api.aavinya.app/api/v1/updateInprogressbyUserId");
      var response = await http.post(uriCart,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "CourseId": courseId,
            "UserId": uUserId,
            "lessonComplated": lessonId
          }));

      var decoded = jsonDecode(response.body);
      return decoded;
    } catch (e) {
      return e.toString();
    }
  }

  Future createCerti(int courseId, int lessonId) async {
    try {
      Uri uriCart =
          Uri.parse("https://api.aavinya.app/api/v1/CreateCertificationDetails");
      var response = await http.post(uriCart,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "CourseId": courseId,
            "UserId": uUserId,
            "CompletionDate": "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
            "Status": "Complated"
          }));

      var decoded = jsonDecode(response.body);
      return decoded;
    } catch (e) {
      return e.toString();
    }
  }

  Future getCerti() async {
    try {
      Uri uriCart =
          Uri.parse("https://api.aavinya.app/api/v1/getAllCertificationbyUserId");
      var response = await http.post(uriCart,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "UserId": uUserId,
          }));

      var decoded = jsonDecode(response.body);
      return decoded;
    } catch (e) {
      return e.toString();
    }
  }

  Future getNotes() async{
    try{
      Uri urii = Uri.parse("https://api.aavinya.app/api/v1/getAllStudyMaterial");

      var response = await http.get(urii);

      var decode = jsonDecode(response.body);

      return decode;
    }catch(e){
      return e.toString();
    }
  }

  Future deleteNotes(int id) async{
    try{
      Uri urii = Uri.parse("https://api.aavinya.app/api/v1/deleteStudyMaterialDetails/${id}");

      var response = await http.delete(urii);

      var decode = jsonDecode(response.body);

      return decode;
    }catch(e){
      return e.toString();
    }
  }

  Future setNotes(String id, String? path) async{
      Uri uriss = Uri.parse("https://api.aavinya.app/api/v1/createNotesAnswer");
      var request =  http.MultipartRequest('POST', uriss);
      request.files.add(await http.MultipartFile.fromPath("AssignmentAnswer", path!));
      request.fields.addAll({"NotesId": id,});
      request.headers.addAll({"Content-Type": "application/json"});

      var res = await request.send();

      var response = await http.Response.fromStream(res);

      var decode = response.body;
      
      return decode;
  }

  Future payment(String price) async {
    final Uri uri = Uri.parse(
        "http://3.111.47.3:12410/api/v1/create-instamojo-payment-link");
        print({
            "purpose": "shopping payment",
            "phone": uMob,
            "amount": price,
            "email": uMail,
            "buyer_name": uName,
            "UserId": uUserId,
          });

    try {
      final http.Response response = await http.post(uri,
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            "purpose": "shopping payment",
            "phone": "9854712360",
            "amount": price,
            "email": uMail,
            "buyer_name": uName,
            "UserId": uUserId,
          }));
      final responsebody = json.decode(response.body);
      print("body is $responsebody");

      return responsebody;
    } catch (e) {
      rethrow;
    }
  }
}

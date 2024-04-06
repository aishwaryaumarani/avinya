
import 'package:english_copy/screens/certificate.dart';
import 'package:english_copy/screens/course_complete.dart';
import 'package:english_copy/screens/detailed_notes.dart';
import 'package:english_copy/screens/download_screen.dart';
import 'package:english_copy/screens/live_screen.dart';
import 'package:english_copy/screens/notes_screen.dart';
import 'package:english_copy/screens/notification_screen.dart';
import 'package:english_copy/screens/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'provider_pages/get_courses.dart';
import 'provider_pages/google_sigin.dart';
import 'screens/about.dart';
import 'screens/add_payment_screen.dart';
import 'screens/app_review.dart';
import 'screens/author_details.dart';
import 'screens/bottom_nav_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/confirm_checkout.dart';
import 'screens/course_content.dart';
import 'screens/courses_screen.dart';
import 'screens/create_account_screen.dart';
import 'screens/detailed_course.dart';
import 'screens/detailed_search.dart';
import 'screens/edit_profile.dart';
import 'screens/enter_email.dart';
import 'screens/faq_screen.dart';
import 'screens/home_screen.dart';
import 'screens/lesion.dart';
import 'screens/login_screen.dart';
import 'screens/main_home_screen.dart';
import 'screens/new_password_screen.dart';
import 'screens/order_success_screen.dart';
import 'screens/quiz_overwiev.dart';
import 'screens/quiz_result.dart';
import 'screens/quiz_test.dart';
import 'screens/review_screen.dart';
import 'screens/search_screen.dart';
import 'screens/show_all_reviews.dart';
import 'screens/spalsh_screen.dart';
import 'screens/verification_code.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider<GoogleProvider>(create: (_) => GoogleProvider()),
        ListenableProvider<GetCoursesProvider>(create: (_) => GetCoursesProvider(),)
      ],
      child: MaterialApp(
        title: 'Avinya',
        theme: ThemeData(
          fontFamily: GoogleFonts.inter().fontFamily,
          scaffoldBackgroundColor: Colors.white,
          brightness: Brightness.light,
        ),
        home: const Splash(),
        debugShowCheckedModeBanner: false,
        routes: {
          AddPaymentScreen.routeName:(context) => const AddPaymentScreen(),
          AuthorDetails.routeName:(context) => const AuthorDetails(),
          CartScreen.routeName:(context) => const CartScreen(),
          CheckoutScreen.routeName:(context) => const CheckoutScreen(),
          CourseScreen.routeName:(context) => const CourseScreen(),
          CreateAccountScreen.routeName:(context) => const CreateAccountScreen(),
          DetailedCourseScreen.routeName:(context) => const DetailedCourseScreen(),
          DetailedSearchScreen.routeName:(context) => const DetailedSearchScreen(),
          EnterEmailScreen.routeName:(context) => const EnterEmailScreen(),
          HomeScreen.routeName:(context) => const HomeScreen(),
          LoginScreen.routeName:(context) => const LoginScreen(),
          MainHomeScreen.routeName:(context) => const MainHomeScreen(),
          NewPasswordScreen.routeName:(context) => const NewPasswordScreen(),
          OrderSuccessScreen.routeName:(context) => const OrderSuccessScreen(),
          SearchScreen.routeName:(context) => const SearchScreen(),
          SplashScreen.routeName:(context) => const SplashScreen(),
          VerificationCodeScreen.routeName:(context) => const VerificationCodeScreen(),
          ReviewScreen.routeName:(context) => const ReviewScreen(),
          AllReviewsScreen.routeName:(context) => const AllReviewsScreen(),
          QuizOverviewScreen.routeName:(context) => const QuizOverviewScreen(),
          QuizTestScreen.routeName:((context) => const QuizTestScreen()),
          BottomNavScreen.routeName:(context) => const BottomNavScreen(),
          QuizResultScreen.routeName:(context) => const QuizResultScreen(),
          AboutScreen.routeName:(context) => const AboutScreen(),
          FaqScreen.routeName:(context) => const FaqScreen(),
          ConfirmCHeckoutScreen.routeName:(context) => const ConfirmCHeckoutScreen(),
          CourseContentScreen.routeName:(context) => const CourseContentScreen(),
          LessionDetails.routeName:(context) => LessionDetails(),
          EditProfileScreen.routeName:(context) => EditProfileScreen(),
          AppReviewScreen.routeName:(context) => AppReviewScreen(),
          NotificationScreen.routeName:(context) => NotificationScreen(),
          LiveScreen.routeName:(context) => LiveScreen(),
          CourseComplete.routeName:(context) => CourseComplete(),
          NotesScreen.routeName:(context) => NotesScreen(),
          DetailedNotes.routeName:(context) => DetailedNotes()
        },
      ),
    );
  }
}


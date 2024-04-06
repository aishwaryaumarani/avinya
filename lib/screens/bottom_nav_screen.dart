
import 'package:english_copy/screens/download_list.dart';
import 'package:english_copy/screens/search_screen.dart';
import 'package:english_copy/screens/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import 'cart_screen.dart';
import 'courses_screen.dart';
import 'main_home_screen.dart';

class BottomNavScreen extends StatefulWidget {
  static const routeName = "BottomNavScreen";
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final PersistentTabController _controller = PersistentTabController(initialIndex: 0);
  
  List<Widget> _buildScreens(){
    return [
      const MainHomeScreen(),
      const SearchScreen(),
      DownloadList(),
      const CourseScreen(),
      // const CartScreen(),
      const UserProfileScreen()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems(BuildContext cts) {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home),
        title: ("Home"),
        activeColorPrimary: Color(0xFF4F75FA),
        inactiveColorPrimary: Colors.black
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search),
        title: ("Explore"),
        activeColorPrimary: Color(0xFF4F75FA),
        inactiveColorPrimary: Colors.black
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.download),
        title: ("Downloads"),
        activeColorPrimary: Color(0xFF4F75FA),
        inactiveColorPrimary: Colors.black
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.play_arrow_rounded),
        title: ("My Courses"),
        activeColorPrimary: Color(0xFF4F75FA),
        inactiveColorPrimary: Colors.black
      ),
      // PersistentBottomNavBarItem(
      //   icon: const Icon(Icons.shopping_cart),
      //   title: ("Cart"),
      //   activeColorPrimary: Colors.black,
      //   inactiveColorPrimary: Colors.black
      // ),
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.person_rounded),
        title: ("Account"),
        activeColorPrimary: Color(0xFF4F75FA),
        inactiveColorPrimary: Colors.black
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PersistentTabView(
        context,
        controller: _controller,
        screens: _buildScreens(),
        items: _navBarItems(context),
        stateManagement: false,
        confineInSafeArea: true,
        backgroundColor:  Colors.white,
        popActionScreens: PopActionScreensType.all,
        popAllScreensOnTapOfSelectedTab: true,
        handleAndroidBackButtonPress: true,
        navBarStyle: NavBarStyle.style2,
      ),
    );
  }
}
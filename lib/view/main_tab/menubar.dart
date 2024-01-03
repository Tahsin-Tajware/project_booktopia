import 'package:booktopia/common/color_extension.dart';
import 'package:booktopia/view/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../login/login.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../../search_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({Key? key}) : super(key: key);

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

GlobalKey<ScaffoldState> sideMenuScafflodKey = GlobalKey<ScaffoldState>();

class _MainTabViewState extends State<MainTabView>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  TabController? controller;
  final currentUser = FirebaseAuth.instance;
  int selectMenu = 0;

  Future<void> signout() async {
    final GoogleSignIn googleSign = GoogleSignIn();
    await googleSign.signOut();
    FirebaseAuth.instance.signOut();
  }

  List menuArr = [
    {"name": "Home", "icon": Icons.home},
    {"name": "My Account ", "icon": Icons.person},
    {"name": "Notification", "icon": Icons.notifications},
    {"name": "Setting", "icon": Icons.settings},
    {"name": "Chat", "icon": Icons.chat},
    {"name": "My Order", "icon": Icons.payment},
    {"name": "Sign Out", "icon": Icons.logout},
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    controller = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _pageController.dispose();
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      key: sideMenuScafflodKey,
      endDrawer: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        width: media.width * 0.6,
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: const [
            BoxShadow(color: Colors.black54, blurRadius: 15)
          ]),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: menuArr.map((mObj) {
                    var index = menuArr.indexOf(mObj);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 30),
                      padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                      decoration: selectMenu == index
                          ? BoxDecoration(color: Colors.blue, boxShadow: [
                        BoxShadow(
                            color: Colors.indigoAccent,
                            blurRadius: 10,
                            offset: const Offset(0, 4))
                      ])
                          : null,
                      child: GestureDetector(
                        onTap: () {
                          signout();
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) =>
                                  LoginPage(), // Replace LoginView with your login page
                            ),
                                (Route<dynamic> route) => false,
                          );
                        },
                        child: Row(
                          children: [
                            Icon(
                              mObj["icon"] as IconData? ?? Icons.home,
                              color: selectMenu == index
                                  ? Colors.white
                                  : Colors.blueAccent,
                              size: 33,
                            ),
                            Text(
                              mObj["name"].toString(),
                              style: TextStyle(
                                color: selectMenu == index
                                    ? Colors.white
                                    : TColor.text,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        children: [
          const HomeView(),
          //Container(color: Colors.white24),
          SearchPage(),
          Container(color: Colors.green),
          Container(color: Colors.orange),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.blue.shade600,
        child: AnimatedBottomNavigationBar(
          icons: [
            Icons.home,
            Icons.search,
            Icons.shopping_cart_sharp,
          ],
          activeIndex: _currentIndex,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          leftCornerRadius: 35,
          rightCornerRadius: 35,
          backgroundColor: Colors.blue.shade900,
          activeColor: Colors.white,
          inactiveColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
              _pageController.animateToPage(
                index,
                duration: const Duration(milliseconds: 300),
                curve: Curves.ease,
              );
            });
          },
        ),
      ),
    );
  }
}

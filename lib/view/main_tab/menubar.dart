import 'package:booktopia/common/color_extension.dart';
import 'package:booktopia/view/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../cart.dart';
import '../../chat_pages/chat_home.dart';
import '../../login/login.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import '../../profile/profilepage.dart';
import '../../search_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({Key? key}) : super(key: key);

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

GlobalKey<ScaffoldState> sideMenuScaffoldKey = GlobalKey<ScaffoldState>();

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
    {"name": "Cart", "icon": Icons.shopping_cart_sharp},
    {"name": "Chat", "icon": Icons.chat},
    {"name": "My Order", "icon": Icons.payment},
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

  void _navigateTo(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      key: sideMenuScaffoldKey,
      endDrawer: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        width: media.width * 0.57,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blue[50],
            boxShadow: const [BoxShadow(color: Colors.black54, blurRadius: 15)],
          ),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/logo.png',
                      height: 200,
                      width: 200,
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: menuArr.map((mObj) {
                    var index = menuArr.indexOf(mObj);
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 15),
                      decoration: selectMenu == index
                          ? BoxDecoration(
                              color: Colors.blue,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.indigoAccent,
                                    blurRadius: 10,
                                    offset: const Offset(0, 4))
                              ],
                            )
                          : null,
                      child: GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            _navigateTo(0);
                          } else if (index == 1) {
                            _navigateTo(3); // Navigate to Profilepage
                          }
                          else if (index == 3) {
                            _navigateTo(2); // Navigate to CartPage
                          }
                          else if (index == 4) {
                            _navigateTo(4); // Navigate to ChatHome
                          }
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Icon(
                              mObj["icon"] as IconData? ?? Icons.home,
                              color: selectMenu == index
                                  ? Colors.indigo[900]
                                  : Colors.blue[700],
                              size: 33,
                            ),
                            Text(
                              mObj["name"].toString(),
                              style: TextStyle(
                                color: selectMenu == index
                                    ? Colors.indigo[900]
                                    : Colors.indigo[900],
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                //SizedBox(height: 290,),
                ListTile(
                  onTap: () {
                    signout();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                      (route) => false,
                    );
                  },
                  leading: Icon(
                    Icons.logout,
                    color: Colors.red,
                    size: 33,
                  ),
                  title: Text(
                    "Sign Out",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
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
          SearchPage(),
          CartPage(),
          Profilepage(),
          //CartPage(),
          ChatHome(),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.transparent,
        child: AnimatedBottomNavigationBar(
          icons: [
            Icons.home,
            Icons.search,
            Icons.shopping_cart_sharp,
            Icons.person,
          ],
          activeIndex: _currentIndex,
          gapLocation: GapLocation.none,
          notchSmoothness: NotchSmoothness.verySmoothEdge,
          //leftCornerRadius: 35,
          //rightCornerRadius: 35,
          backgroundColor: Colors.indigo[900],
          activeColor: Colors.cyanAccent,
          inactiveColor: Colors.white24,
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

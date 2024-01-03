import 'package:booktopia/common/color_extension.dart';
import 'package:booktopia/view/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../login/login.dart';
import '../../search_view.dart';

class MainTabView extends StatefulWidget {
  const MainTabView( {super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

GlobalKey<ScaffoldState> sideMenuScafflodKey = GlobalKey<ScaffoldState>();

class _MainTabViewState extends State<MainTabView>
    with TickerProviderStateMixin {
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
    controller = TabController(length: 4, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      key: sideMenuScafflodKey,
      endDrawer: Drawer(
        backgroundColor: Colors.transparent,
        elevation: 0,
        width: media.width * 0.8,
        child: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: const [
            BoxShadow(color: Colors.black54, blurRadius: 15)
          ]),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //const SizedBox(height: 10),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //mainAxisSize: MainAxisSize.min,
                    children: menuArr.map((mObj) {
                      var index = menuArr.indexOf(mObj);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 15),
                        decoration: selectMenu == index
                            ? BoxDecoration(color: TColor.primary, boxShadow: [
                          BoxShadow(
                              color: TColor.primary,
                              blurRadius: 10,
                              offset: const Offset(0, 3))
                        ])
                            : null,
                        child:  GestureDetector(
                          onTap: () {
                            signout();
                            // Navigate to the login page when "Sign Out" is tapped
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => LoginPage(), // Replace LoginView with your login page
                              ),
                                  (Route<dynamic> route) => false,
                            );
                          },
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                mObj["icon"] as IconData? ?? Icons.home,
                                color: selectMenu == index
                                    ? Colors.white
                                    : TColor.primary,
                                size: 33,
                              ),
                              Text(
                                mObj["name"].toString(),
                                style: TextStyle(
                                    color: selectMenu == index
                                        ? Colors.white
                                        : TColor.text,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList()),
              ],
            ),
          ),
        ),
      ),
      body: TabBarView(controller: controller, children: [
        const HomeView(),
        SearchPage(),
        Container(),
        Container(),
      ]),
      bottomNavigationBar: BottomAppBar(
        color: TColor.text,
        child: TabBar(
            controller: controller,
            indicatorColor: Colors.transparent,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            tabs: const [
              Tab(
                icon: Icon(Icons.home),
                text: "Home",
              ),
              Tab(
                icon: Icon(Icons.search),
                text: "Search",
              ),
              Tab(
                icon: Icon(Icons.menu),
                text: "Category",
              ),
              Tab(
                icon: Icon(Icons.shopping_bag),
                text: "Cart",
              ),
            ]),
      ),
    );
  }
}
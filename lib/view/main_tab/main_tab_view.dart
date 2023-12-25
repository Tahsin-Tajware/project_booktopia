import 'package:booktopia/common/color_extension.dart';
import 'package:booktopia/view/home/home_view.dart';
import 'package:flutter/material.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView>
    with TickerProviderStateMixin {
  TabController? controller;

  @override
  void initState() {
    controller = TabController(length: 4, vsync: this);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(controller: controller, children: [
        const HomeView(),
        Container(),
        Container(),
        Container(),
      ]),
      bottomNavigationBar: BottomAppBar(
        color: TColor.text,
        child: TabBar(
            controller: controller,
            indicatorColor: Colors.transparent,
            labelColor: Colors.white70,
            unselectedLabelColor: Colors.white70,
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

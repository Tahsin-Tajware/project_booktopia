import 'package:booktopia/common/color_extension.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../common_widget/best_sellers_cell.dart';
import '../../common_widget/top_picks_cell.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List topPicksArr = [
    {
      "name": "HARRY POTTER and the SORCERER'S STONE",
      "author": "J.K. Rowling",
      "img": "assets/1.jpg"
    },
    {
      "name": "The Name of the Wind",
      "author": "Patrick Rothfuss",
      "img": "assets/2.jpg"
    },
    {
      "name": "The Way of Kings",
      "author": "Brandon Sanderson",
      "img": "assets/3.jpg"
    },
    {
      "name": "The Wicked King",
      "author": "Holly Black",
      "img": "assets/7 .jpg"
    },
    {
      "name": "The Martian",
      "author": "Andy Weir",
      "img": "assets/8.jpg"
    },
    {
      "name": "The Will of the Many",
      "author": "James Islington",
      "img": "assets/9.jpg"
    },
    {
      "name": "Of Darkness and Light",
      "author": "Ryan Cahill",
      "img": "assets/10.jpg"
    }

  ];

  List bestSellerArr = [
    {
      "name": "The Invisible Life of Addie LaRue",
      "author": "V.E. Schwab",
      "img": "assets/4.jpg",
      "rating": 4.5
    },
    {
      "name": "The Wager: A Tale of Shipwreck, Mutiny and Murder",
      "author": "David Grann",
      "img": "assets/5.jpg",
      "rating": 4.5
    },
    {
      "name": "The Covenant of Water ",
      "author": "Abraham Verghese",
      "img": "assets/6.jpg",
      "rating": 4.6
    },
    {
      "name": "1932: FDR,Hoover,and the Dawn of a New America",
      "author": "Scott Martelle",
      "img": "assets/11.jpg",
      "rating": 4.8
    },
    {
      "name": "The Redhead of Auschwitz: A True Story ",
      "author": "Nechama Birnbaum",
      "img": "assets/12.jpg",
      "rating": 4.8
    },
    {
      "name": "Ward D",
      "author": "Freida McFadden",
      "img": "assets/13.jpg",
      "rating": 4.3
    },
    {
      "name": "Burned Out",
      "author": "Dean Mafako",
      "img": "assets/14.jpg",
      "rating": 4.3
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  child: Transform.scale(
                    scale: 1.7,
                    origin: Offset(0, media.width * 0.8),
                    child: Container(
                      width: media.width,
                      height: media.width,
                      decoration: BoxDecoration(
                          color: TColor.text,
                          borderRadius:
                              BorderRadius.circular(media.width * 0.5)),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: media.width * 0.025,
                    ),
                    AppBar(
                      backgroundColor: TColor.text,
                      elevation: 0,
                      title: Row(children: const [
                        Text(
                          "Trending Books",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w800),
                        ),
                      ]),
                      leading: Container(),
                      leadingWidth: 2,
                      actions: [
                        IconButton(
                            color: Colors.white,
                            onPressed: () {},
                            icon: const Icon(Icons.menu))
                      ],
                    ),
                    SizedBox(
                      width: media.width,
                      height: media.width * 0.9,
                      // color:Colors.red,
                      child: CarouselSlider.builder(
                        itemCount: topPicksArr.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          var iObj = topPicksArr[itemIndex] as Map? ?? {};
                          return TopPicksCell(
                            iObj: iObj,
                          );
                        },
                        options: CarouselOptions(
                          height: 530,
                          aspectRatio: 1,
                          viewportFraction: 0.45,
                          initialPage: 0,
                          enableInfiniteScroll: true,
                          reverse: true,
                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.4,
                          enlargeStrategy: CenterPageEnlargeStrategy.zoom,
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(children: [
                        Text(
                          "Available Books",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25,
                              fontWeight: FontWeight.w800),
                        ),
                      ]),
                    ),
                    SizedBox(
                      width: media.width,
                      height: media.width,
                      child: ListView.builder(
                          padding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 6),
                          scrollDirection: Axis.horizontal,
                          itemCount: bestSellerArr.length,
                          itemBuilder: ((context, index) {
                            var bObj = bestSellerArr[index] as Map? ?? {};
                            return BestSellersCell(
                              bObj: bObj,
                            );
                          })),
                    )
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

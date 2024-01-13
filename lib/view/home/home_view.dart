import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../book_details.dart';
import '../main_tab/menubar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blue.shade600,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Align(
                  child: Transform.scale(
                    scale: 0.7,
                    origin: Offset(0, media.width * 0.6),
                    child: Container(
                      width: media.width,
                      height: media.width,
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent.shade400,
                          borderRadius:
                              BorderRadius.circular(media.width * 0.2)),
                    ),
                  ),
                ),
                Align(
                  child: Transform.scale(
                    scale: 2.6,
                    origin: Offset(0, media.width * 0.6),
                    child: Container(
                      width: media.width,
                      height: media.width,
                      decoration: BoxDecoration(
                          color: Colors.lightBlueAccent.shade400,
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
                      backgroundColor: Colors.transparent,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      elevation: 0,
                      title: Row(children: [
                        Text(
                          "Trending Books",
                          style: TextStyle(
                              color: Colors.cyan.shade50,
                              fontSize: 25,
                              fontWeight: FontWeight.w800),
                        ),
                      ]),
                      leading: Container(),
                      leadingWidth: 2,
                      actions: [
                        IconButton(
                          color: Colors.indigo[900],
                          onPressed: () {
                            sideMenuScaffoldKey.currentState?.openEndDrawer();
                          },
                          icon: const Icon(
                            Icons.menu_open_rounded,
                            size: 40,
                          ),
                        )
                      ],
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: firestore
                          .collection('TrendingBooks')
                          .where('trending', isEqualTo: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = snapshot.data!.docs[index];
                              return BookItem(doc: doc);
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Something went wrong');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    SizedBox(
                      // width: media.width,
                      // height: media.width * 0.9,
                      // color:Colors.red,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(children: [
                          Text(
                            "Featured Books",
                            style: TextStyle(
                                color: Colors.cyan.shade50,
                                fontSize: 25,
                                fontWeight: FontWeight.w900),
                          ),
                        ]),
                      ),
                    ),
                    StreamBuilder<QuerySnapshot>(
                      stream: firestore
                          .collection('FeaturedBooks')
                          .where('featured', isEqualTo: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot doc = snapshot.data!.docs[index];
                              return BookItem(doc: doc);
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Text('Something went wrong');
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    ),
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BookItem extends StatelessWidget {
  final DocumentSnapshot doc;

  const BookItem({Key? key, required this.doc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        doc.get('name'),
        style: TextStyle(
          fontSize: 15,
          color: Colors.brown.shade50,
          fontWeight: FontWeight.w900,
          textBaseline: TextBaseline.alphabetic,
        ),
        textAlign: TextAlign.start,
      ),
      subtitle: Text(
        doc.get('author'),
        style: TextStyle(
          fontSize: 14,
          color: Colors.cyan.shade50,
          fontWeight: FontWeight.w900,
        ),
        textAlign: TextAlign.start,
      ),
      leading: Image.network(
        doc.get('imageUrl'),
        fit: BoxFit.contain,
        cacheWidth: 260,
        cacheHeight: 330,
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            doc.get('rating').toString(),
            style: TextStyle(
              fontSize: 17,
              color: Colors.cyan[100],
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          RatingBar.builder(
            itemSize: 20,
            initialRating: double.parse(doc.get('rating')),
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
            itemBuilder: (context, _) => Icon(
              Icons.star_rounded,
              color: Colors.amber[600],
            ),
            onRatingUpdate: (rating) {},
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BookDetails(
              id: doc.id,
            ),
          ),
        );
      },
    );
  }
}

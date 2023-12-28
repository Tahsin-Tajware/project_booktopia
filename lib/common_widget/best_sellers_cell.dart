import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class BestSellersCell extends StatelessWidget {
  final Map bObj;
  const BestSellersCell({super.key, required this.bObj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 18),
      child: SizedBox(
          // color: Colors.red,
          width: media.width * 0.36,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black38,
                          offset: Offset(0, 2),
                          blurRadius: 5)
                    ]),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    bObj["img"].toString(),
                    width: media.width * 0.45,
                    height: media.width * 0.55,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                bObj["name"].toString(),
                maxLines: 4,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                bObj["author"].toString(),
                maxLines: 2,
                textAlign: TextAlign.left,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w700),
              ),
              const SizedBox(
                height: 10,
              ),
              IgnorePointer(
                  ignoring: true,
                  child: RatingBar.builder(
                    initialRating: double.tryParse( bObj["rating"].toString())?? 1,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 15,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                    itemBuilder: (context, _) => Icon(
                      Icons.star_rate_sharp,
                      color: Colors.deepOrange,
                    ),
                    onRatingUpdate: (rating) {

                    },
                  ))
            ],
          )),
    );
  }
}

import 'package:booktopia/common/color_extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopPicksCell extends StatelessWidget {
  final Map iObj;
  const TopPicksCell({super.key, required this.iObj});

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return SizedBox(
        // color: Colors.red,
        width: media.width * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
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
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  iObj["img"].toString(),
                  width: media.width * 0.3425,
                  height: media.width * 0.55,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              iObj["name"].toString(),
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: TColor.text,
                  fontSize: 15,
                  fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              iObj["author"].toString(),
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 13,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ));
  }
}

import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  final Map bookDetails;

  const BookDetails({Key? key, required this.bookDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
        backgroundColor: Colors.blue.shade500,
        iconTheme: IconThemeData(color: Colors.black),
        toolbarTextStyle: TextTheme(
          titleLarge:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ).bodyMedium,
        titleTextStyle: TextTheme(
          titleLarge: TextStyle(
              color: Colors.black, fontSize: 21, fontWeight: FontWeight.bold),
        ).titleLarge,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue.shade200,
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(bookDetails["img"].toString()),
                    fit: BoxFit.contain,
                  ),
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade400,
                      offset: Offset(0, 3),
                      blurRadius: 35,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 14),
              Text(
                "${bookDetails["name"]}",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                "by ${bookDetails["author"]}",
                style: TextStyle(
                    color: Colors.black54,
                    fontSize: 17,
                    fontWeight: FontWeight.w800),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                "Rating: ${bookDetails["rating"]}",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                'Price: \$${bookDetails["price"].toString()}',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                "Short Description: ${bookDetails["description"]}",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  final Map bookDetails;

  const BookDetails({Key? key, required this.bookDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
        backgroundColor: Colors.indigo[600],
        iconTheme: IconThemeData(color: Colors.black),
        toolbarTextStyle: TextTheme(
          titleLarge: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ).bodyMedium,
        titleTextStyle: TextTheme(
          titleLarge: TextStyle(
              color: Colors.black, fontSize: 21, fontWeight: FontWeight.bold),
        ).titleLarge,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.blue.shade100,
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
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                "by ${bookDetails["author"]}",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 17,
                    fontWeight: FontWeight.w700),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                "Rating: ${bookDetails["rating"]}",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900,color: Colors.red),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 4),
              Text(
                'Price : \$${bookDetails["price"].toString()}',
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.w900,color: Colors.indigo),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    icon: Icon(Icons.shopping_cart, color: Colors.black),
                    label: Text(
                      'Buy Now',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange[900],
                    ),
                    icon: Icon(Icons.favorite, color: Colors.black),
                    label: Text(
                      'Add to Cart',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Text(
                "Short Description: ${bookDetails["description"]}",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 24),
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.deepPurple,
                  ),
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                  label: Text(
                    '       back          ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

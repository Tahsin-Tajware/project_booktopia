import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'buy_now.dart';

class BookDetails extends StatelessWidget {
  final String id;

  const BookDetails({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Book Details',
          style: TextStyle(
            fontSize: 24,
            color: Colors.cyan.shade50,
            fontWeight: FontWeight.w900,
          ),
        ),
        backgroundColor: Colors.indigo[600],
        iconTheme: IconThemeData(color: Colors.cyan.shade50),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: fetchBookDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong'));
          } else if (snapshot.data == null) {
            return Center(child: Text('Book not found'));
          }

          var bookData = snapshot.data!;

          return SingleChildScrollView(
            child: Container(
              color: Colors.indigo.shade600,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    height: 300,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(bookData['imageUrl']),
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
                    bookData['name'],
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.cyan.shade50,
                        fontWeight: FontWeight.w900),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 14),
                  Text(
                    'by ' + bookData['author'].toString(),
                    style: TextStyle(
                      color: Colors.cyan.shade50,
                      fontSize: 17.5,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Rating: ' + bookData['rating'].toString(),
                    style: TextStyle(
                      fontSize: 17.5,
                      fontWeight: FontWeight.w900,
                      color: Colors.cyan.shade50,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 14),
                  Text(
                    'Price: ' + bookData['price'].toString(),
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.cyan.shade50,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green),
                        icon: Icon(Icons.shopping_cart, color: Colors.white),
                        label: Text(
                          'Buy Now',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          _addToCart(context, bookData);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange[900],
                        ),
                        icon: Icon(Icons.favorite, color: Colors.white),
                        label: Text(
                          'Add to Cart',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Book Description: ' + bookData['description'].toString(),
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.cyan.shade50,
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 14),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      icon: Icon(Icons.arrow_back, color: Colors.white),
                      label: Text(
                        'Go Back',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<Map<String, dynamic>> fetchBookDetails() async {
    try {
      DocumentSnapshot trendingSnapshot = await FirebaseFirestore.instance
          .collection('TrendingBooks')
          .doc(id)
          .get();

      if (!trendingSnapshot.exists) {
        DocumentSnapshot featuredSnapshot = await FirebaseFirestore.instance
            .collection('FeaturedBooks')
            .doc(id)
            .get();

        if (!featuredSnapshot.exists) {
          return {};
        } else {
          return featuredSnapshot.data() as Map<String, dynamic>;
        }
      } else {
        return trendingSnapshot.data() as Map<String, dynamic>;
      }
    } catch (e) {
      print('Error fetching book details: $e');
      throw Exception('Error fetching book details');
    }
  }

  void _addToCart(BuildContext context, Map<String, dynamic> bookData) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userEmail = user.email!;

        await FirebaseFirestore.instance
            .collection('carts')
            .doc(userEmail)
            .collection('items')
            .add({
          'product_name': bookData['name'],
          'product_image': bookData['imageUrl'],
          'product_price': bookData['price'],
          'product_description': bookData['description'],
          'quantity': 1, // Set default quantity, you can change it as needed
          'total_amount': bookData['price'],
          'timestamp': FieldValue.serverTimestamp(),
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Added to Cart'),
          ),
        );
      }
    } catch (e) {
      print('Error adding to cart: $e');
    }
  }
}

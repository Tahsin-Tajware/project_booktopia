import 'package:booktopia/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  //({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        backgroundColor: Colors.indigo[800],
        title: const Text(
          "Shopping Cart",
          style: TextStyle(
              fontSize: 28, color: Colors.white, fontWeight: FontWeight.w900),
          textAlign: TextAlign.end,
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(18),
          ),
        ),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //     Navigator.of(context).pop();
        //   },
        // ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("carts")
              .doc(FirebaseAuth.instance.currentUser!.email)
              .collection("items")
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Center(child: Text("Something is wrong"));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text("Your Cart is Empty"));
            }

            Map<String, int> bookCounts = {};
            double totalAmount = 0;
            Map<String, double> bookPrices = {};
            double productPrice = 0;
            snapshot.data!.docs.forEach((DocumentSnapshot document) {
              // String totalAmountString =
              //     document['total_amount'].toString().replaceAll('\$', '');
              // double itemTotal = double.parse(totalAmountString);
              // // double itemTotal = double.parse(document['total_amount']);
              // totalAmount += itemTotal;
              String productName = document['product_name'];
              int quantity = document['quantity'];
              String priceString = document['product_price'] ?? '0';
              //.replaceAll('\$', '');
              priceString = priceString.replaceAll('\$', '');
              double itemTotal = double.parse(priceString);

              // Update or add the book count to the map
              bookCounts.update(productName, (value) => value + quantity,
                  ifAbsent: () => quantity);

              // Calculate total amount for each unique book
              totalAmount += quantity * itemTotal;
              if (!bookPrices.containsKey(productName)) {
                bookPrices[productName] = itemTotal;
              }
              // productPrice = itemTotal;
            });
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: bookCounts.length,
                    //snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      //DocumentSnapshot document = snapshot.data!.docs[index];
                      String productName = bookCounts.keys.elementAt(index);
                      int quantity = bookCounts[productName]!;
                      double productPrice = bookPrices[productName] ?? 0;
                      return ListTile(
                        // title: Text(document['product_name']),
                        // subtitle: Text('Price: ${document['product_price']}'),
                        title: Text('$productName (x$quantity)'),
                        subtitle: Text(
                            'Price per copy: \$${productPrice.toStringAsFixed(2)}'),

                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () async {
                            // FirebaseFirestore.instance
                            //     .collection('carts')
                            //     .doc(FirebaseAuth.instance.currentUser!.email)
                            //     .collection("items")
                            //     .doc(document.id)
                            //     .delete();
                            DocumentSnapshot document =
                                snapshot.data!.docs[index];
                            DocumentReference itemRef = FirebaseFirestore
                                .instance
                                .collection('carts')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection('items')
                                .doc(document.id);
                            FirebaseFirestore.instance.runTransaction(
                                (Transaction transaction) async {
                              DocumentSnapshot snapshot =
                                  await transaction.get(itemRef);
                              if (snapshot.exists && snapshot['quantity'] > 1) {
                                transaction.update(itemRef,
                                    {'quantity': snapshot['quantity'] - 1});
                              } else {
                                transaction.delete(itemRef);
                              }
                            });
                          },
                        ),
                      );
                    },
                  ),
                ),

                //               },
                //         ),
                //       );
                //     },
                //   ),
                // ),
                SizedBox(height: 10),
                Text('Total Amount: \$${totalAmount.toStringAsFixed(2)} '),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    // Add logic to proceed to checkout or payment
                    // You can navigate to a new page or implement your desired functionality here
                  },
                  child: Text('Proceed to Checkout'),
                ),
                // Align(
                //   alignment: Alignment.bottomCenter,
                //   child: ElevatedButton.icon(
                //     onPressed: () {
                //       Navigator.pushReplacement(
                //         context,
                //         MaterialPageRoute(builder: (context) => HomeView()),
                //       );
                //       // Navigator.pop(context);
                //     },
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.deepPurple,
                //     ),
                //     icon: Icon(Icons.arrow_back, color: Colors.white),
                //     label: Text(
                //       'Go Back',
                //       style: TextStyle(
                //         fontSize: 20,
                //         color: Colors.white,
                //         fontWeight: FontWeight.w900,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
    );
  }
}

//     );
//   }
// }

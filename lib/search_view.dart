import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController Textcontroller = TextEditingController();

  List<String> products = [
    "HARRY POTTER and the SORCERER'S STONE",
    'The Name of the Wind',
    'The Way of Kings',
    'The Wicked King',
    'The Martian',
    'The Will of the Many',
    'Of Darkness and Light',
    'The Invisible Life of Addie LaRue',
    'The Wager: A Tale of Shipwreck, Mutiny and Murder',
    'The Covenant of Water',
    '1932: FDR,Hoover,and the Dawn of a New America',
    'The Redhead of Auschwitz: A True Story',
    'Ward D',
    'Burned Out',
    // Add more products as needed
  ];

  List<String> searchResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text('Which book you want to find?'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                // Call the function to update search results
                search(value);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue.shade900, width: 3.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade900, width: 3.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 3.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                prefixIcon: Icon(Icons.search, color: Colors.black),
                suffixIcon: SizedBox(width: 40),
                hintText: 'Search Books',
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index]),
                  // Add onTap to navigate to the product or index page
                  onTap: () {
                    navigateToProductPage(index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void search(String query) {
    // Perform the search logic here
    setState(() {
      searchResults = products
          .where(
              (product) => product.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void navigateToProductPage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            ProductDetailsPage(productName: searchResults[index]),
      ),
    );
  }
}

class ProductDetailsPage extends StatelessWidget {
  final String productName;

  ProductDetailsPage({required this.productName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text('Product Details'),
      ),
      body: Container(
        color: Colors.grey.shade200,
        child: Center(
          child: Text(
            'Details for $productName',
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';

import '../common/color_extension.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController _controller = TextEditingController();

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
      appBar: AppBar(
        title: Text('Search Bar'),
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
                contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                prefixIcon: Icon(Icons.search, color: TColor.text),
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
    // Replace this with your actual navigation logic
    // For example, you can use Navigator.push to navigate to a new page
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
        title: Text('Product Details'),
      ),
      body: Center(
        child: Text('Details for $productName'),
      ),
    );
  }
}
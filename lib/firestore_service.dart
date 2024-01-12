import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:booktopia/book_prototype.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getBooks() async {
    QuerySnapshot querySnapshot = await _firestore.collection('books').get();
    return querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}

// class FirestoreService {
//   final CollectionReference _booksCollection =
//       FirebaseFirestore.instance.collection('Books');
//
//   Future<List<Book>> getBooks() async {
//     QuerySnapshot querySnapshot = await _booksCollection.get();
//     return querySnapshot.docs.map((doc) {
//       Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//       return Book(
//         title: data['title'],
//         author: data['author'],
//         rating: data['rating'].toDouble(),
//         imageUrl: data['imageUrl'],
//         description: data['description'],
//       );
//     }).toList();
//   }
// }

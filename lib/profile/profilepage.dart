import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:booktopia/profile/textbox.dart';
import '../login/login.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Profilepage extends StatefulWidget {
  const Profilepage({Key? key}) : super(key: key);

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  late String _name = "";
  late String _address = "";
  File? _imageFile;

  final currentuser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("users");

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.email)
          .get();

      if (userSnapshot.exists) {
        setState(() {
          _name = userSnapshot.get('name') ?? "";
          _address = userSnapshot.get('address') ?? "";
        });
      }
    }
  }

  Future<void> editField(String field) async {
    late String newValue;
    late String fieldName;

    if (field == 'name') {
      fieldName = 'name';
      newValue = _name;
    } else if (field == 'address') {
      fieldName = 'address';
      newValue = _address;
    } else {
      return;
    }

    TextEditingController _controller = TextEditingController(text: newValue);

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'Edit $fieldName',
          style: TextStyle(color: Colors.black),
        ),
        content: TextField(
          controller: _controller,
          autofocus: true,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: 'Enter new $fieldName',
            hintStyle: TextStyle(color: Colors.grey),
          ),
          onChanged: (value) {
            newValue = value;
          },
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text(
              'Save',
              style: TextStyle(color: Colors.black),
            ),
            onPressed: () async {
              if (newValue.isNotEmpty) {
                try {
                  final userDoc =
                  await userCollection.doc(currentuser.email).get();

                  if (userDoc.exists) {
                    await userCollection
                        .doc(currentuser.email)
                        .update({fieldName: newValue});
                    setState(() {
                      if (fieldName == 'name') {
                        _name = newValue;
                      } else if (fieldName == 'address') {
                        _address = newValue;
                      }
                    });
                    print('Updated $fieldName to: $newValue');
                    Navigator.of(context).pop();
                  } else {
                    print('User document not found');
                  }
                } catch (e) {
                  print("Error updating $fieldName: $e");

                }
              } else {
                print('Value cannot be empty');

              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });


    }
  }

  Future<void> _uploadImageToFirebaseStorage() async {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent.shade200,
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 26,
          ),
        ),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(height: 30),
          GestureDetector(
            onTap: _pickImage,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: ClipOval(
                        child: _imageFile != null
                            ? Image.file(
                          _imageFile!,
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                        )
                            : Icon(
                          Icons.person,
                          size: 72,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.teal,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              "Signed in as:",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.purple[500],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(
            currentuser.email!,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          SizedBox(height: 10,),
          TextBox(
            text: _name,
            sectionName: 'Name',
            onPressed: () => editField('name'),
          ),

          TextBox(
            text: _address,
            sectionName: 'Enter your address',
            onPressed: () => editField('address'),
          ),
          SizedBox(height: 50),
          Center(
            child: ElevatedButton(
              onPressed: () => _signOut(context),
              child: Text(
                'Sign Out',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      print("Error signing out: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Error signing out. Please try again.",
            style: TextStyle(color: Colors.red, fontSize: 15),
          ),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}

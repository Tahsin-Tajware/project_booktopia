import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  late String _profileImageURL = "";
  File? _imageFile;
  late Future<void> _userDataFuture;


  final currentuser = FirebaseAuth.instance.currentUser!;
  final userCollection = FirebaseFirestore.instance.collection("users");
  final _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _userDataFuture = _fetchUserData();
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
          _profileImageURL = userSnapshot.get('profile') ?? "";

        });
      }
    }
  }

  Future<void> _uploadImageToFirebaseStorage() async {
    if (_imageFile != null) {
      try {
        final storageRef = FirebaseStorage.instance.ref().child(
            'profile_images/${currentuser.email}.jpg');

        final uploadTask = storageRef.putFile(_imageFile!);
        await uploadTask;

        final downloadURL = await storageRef.getDownloadURL();

        await userCollection
            .doc(currentuser.email)
            .update({'profile': downloadURL});

        setState(() {
          _profileImageURL = downloadURL;
        });

        print('Profile picture URL updated in Firestore: $downloadURL');
      } catch (e) {
        print("Error uploading image: $e");
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
    await _imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });

      await _uploadImageToFirebaseStorage();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      appBar: AppBar(
        title: Text(
          "My Profile",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 26,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.indigo[900],
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(100),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _userDataFuture = _fetchUserData();
          });
          await _userDataFuture;
        },
        child: FutureBuilder<void>(
          future: _userDataFuture,
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return ListView(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: _pickImage,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
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
                                    : _profileImageURL.isNotEmpty
                                    ? Image.network(
                                  _profileImageURL,
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
                                    color: Colors.grey,
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
                  const SizedBox(height: 15),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Signed in as: ",
                          style: TextStyle(
                            color: Colors.greenAccent[400],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          currentuser.email!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
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
                        backgroundColor: Colors.red,
                        padding:
                        EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
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

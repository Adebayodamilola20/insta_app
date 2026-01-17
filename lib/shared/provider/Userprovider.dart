import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Userprovider extends ChangeNotifier {
  String userNAME;
  String newEmail;
  String firstname;
  String phonenumber;

  DateTime? createdAt;
  bool _isLoading = false;

  Userprovider({
    this.userNAME = "",
    this.newEmail = "",
    this.firstname = "",
    this.phonenumber = "",
    this.createdAt, // Initialize the new property
  });

  bool get isLoading => _isLoading;

  void changeUserNAME({required String newuserNAME}) {
    userNAME = newuserNAME;
    notifyListeners();
  }

  void changeuserEmail({required String newuserEmail}) {
    newEmail = newuserEmail;
    notifyListeners();
  }

  void changefirstname({required String newuserfirstname}) {
    firstname = newuserfirstname;
    notifyListeners();
  }

  void changephonenumber({required String newphonenumber}) {
    phonenumber = newphonenumber;
    notifyListeners();
  }

  // Save user data to Firestore
  Future<void> saveUserToFirestore({
    required String userId,
    required String username,
    required String firstName,
    required String email,
    String? phone,
  }) async {
    try {
      // Using consistent keys: 'username', 'firstName', 'email', 'phonenumber'
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'username': username,
        'firstName': firstName,
        'email': email,
        'phonenumber': phone ?? "",
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Update local state
      userNAME = username;
      firstname = firstName;
      newEmail = email;
      phonenumber = phone ?? "";

      createdAt = DateTime.now();
      notifyListeners();
    } catch (e) {
      print('Error saving user to Firestore: $e');
      rethrow;
    }
  }

  Future<void> loadUserData({required String userId}) async {
    _isLoading = true;
    notifyListeners();

    try {
      DocumentSnapshot doc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();

      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        userNAME = data['username'] ?? '';
        firstname = data['firstName'] ?? '';
        newEmail = data['email'] ?? '';
        phonenumber = data['phonenumber'] ?? '';

        // 🛑 FIX 3: Fetch the 'createdAt' Timestamp and convert it to a DateTime
        Timestamp? timestamp = data['createdAt'];
        createdAt = timestamp?.toDate();
      }
    } catch (e) {
      print('Error loading user data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearUserData() {
    userNAME = "";
    newEmail = "";
    firstname = "";
    phonenumber = "";
    createdAt = null; // Clear the date too
    notifyListeners();
  }
}

return Container(
  constraints: BoxConstraints(
    maxWidth: messageWidth.toDouble() - 50,
  ),
  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
  child: MarkdownBody(
    data: text,
    shrinkWrap: true,
    fitContent: true,
    styleSheet: MarkdownStyleSheet(
      p: TextStyle(
        fontSize: 17,
        height: 1.4, // Line height
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      strong: TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      h1: TextStyle(
        fontSize: 20, // Reduced from 24
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      h2: TextStyle(
        fontSize: 18, // Reduced from 20
        fontWeight: FontWeight.bold,
        height: 1.2,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      listBullet: TextStyle(
        fontSize: 17,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.white
            : Colors.black,
      ),
      // Remove spacing between list items
      blockSpacing: 4.0, // Reduced spacing
      listIndent: 20.0, // Less indentation
    ),
    softLineBreak: true,
  ),
);
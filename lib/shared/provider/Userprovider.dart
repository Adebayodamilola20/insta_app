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

Widget _buildCustomInput() {
  // 1. This detects if the keyboard is visible
  final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
  final bool isKeyboardOpen = keyboardHeight > 0;

  return Container(
    // 2. Add bottom margin ONLY when keyboard is open so the curves don't touch the keys
    margin: EdgeInsets.only(
      bottom: isKeyboardOpen ? 10 : 0, 
      left: isKeyboardOpen ? 10 : 0, 
      right: isKeyboardOpen ? 10 : 0
    ),
    decoration: BoxDecoration(
      color: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF1E1E1E) 
          : Colors.white,
      // 3. This is exactly what you asked for: 
      // Top is always rounded. Bottom ONLY rounds when keyboard is open.
      borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(25),
        topRight: const Radius.circular(25),
        bottomLeft: isKeyboardOpen ? const Radius.circular(25) : Radius.zero,
        bottomRight: isKeyboardOpen ? const Radius.circular(25) : Radius.zero,
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ... PASTE ALL YOUR EXISTING CODE HERE ...
        // (selectedImage, selectedFile, the Padding, and the TextField)
      ],
    ),
  );
}
final ScrollController _scrollController = ScrollController();
bool _showBackToBottom = false; // State to track visibility

@override
void initState() {
  super.initState();
  _scrollController.addListener(() {
    // Show button if we are more than 300 pixels away from the bottom
    if (_scrollController.offset < _scrollController.position.maxScrollExtent - 300) {
      if (!_showBackToBottom) setState(() => _showBackToBottom = true);
    } else {
      if (_showBackToBottom) setState(() => _showBackToBottom = false);
    }
  });
}


void _scrollToBottom() {
  _scrollController.animateTo(
    _scrollController.position.maxScrollExtent,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOut,
  );
}

Scaffold(
  floatingActionButton: _showBackToBottom 
    ? FloatingActionButton(
        mini: true, // Makes it small and sleek
        backgroundColor: Colors.blue,
        onPressed: _scrollToBottom,
        child: const Icon(Icons.arrow_downward, color: Colors.white),
      )
    : null,
  body: ListView.builder(
    controller: _scrollController, // 👈 Don't forget to link the controller!
    itemCount: _messages.length,
    itemBuilder: (context, index) => _buildMessage(_messages[index]),
  ),
);
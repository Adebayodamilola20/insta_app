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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
// Note: Apple sign-in doesn't require a specific "signOut" call 
// because it's managed by the OS/Firebase, but Google does.

Future<void> logout(BuildContext context) async {
  try {
    // 1. Clear Google Session (Crucial so they can pick a different account next time)
    final GoogleSignIn googleSignIn = GoogleSignIn();
    if (await googleSignIn.isSignedIn()) {
      await googleSignIn.signOut();
    }

    // 2. Clear Firebase Session (Handles Email/Password and Apple)
    await FirebaseAuth.instance.signOut();

    // 3. Navigate back to Login Screen
    // Replace 'LoginScreen' with your actual login route name
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (Route<dynamic> route) => false,
    );

    onShowSnackbar("Logged out successfully", icon: Icons.exit_to_app, color: Colors.blue);
  } catch (e) {
    onShowSnackbar("Error logging out: $e", icon: Icons.error, color: Colors.red);
  }
}
import 'package:flutter_tts/flutter_tts.dart';

class TtsService {
  static final TtsService _instance = TtsService._internal();
  factory TtsService() => _instance;
  TtsService._internal();

  final FlutterTts _flutterTts = FlutterTts();
  bool _isSpeaking = false;

  Future<void> initialize() async {
    // Configure TTS settings for AI voice
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5); // Speed (0.0 - 1.0, slower to faster)
    await _flutterTts.setVolume(1.0); // Volume (0.0 - 1.0)
    await _flutterTts.setPitch(1.0); // Pitch (0.5 - 2.0, lower to higher)
    
    // iOS specific voice (optional)
    // await _flutterTts.setVoice({"name": "Karen", "locale": "en-AU"}); // Australian female
    
    // Android specific voice (optional)
    // await _flutterTts.setVoice({"name": "en-us-x-sfg#female_1-local", "locale": "en-US"});

    _flutterTts.setCompletionHandler(() {
      _isSpeaking = false;
    });
  }

  Future<void> speak(String text) async {
    if (_isSpeaking) {
      await stop();
    }
    
    // Remove markdown and special characters
    String cleanText = text
        .replaceAll('**', '')
        .replaceAll('```', '')
        .replaceAll('#', '')
        .replaceAll('*', '');
    
    _isSpeaking = true;
    await _flutterTts.speak(cleanText);
  }

  Future<void> stop() async {
    await _flutterTts.stop();
    _isSpeaking = false;
  }

  Future<void> pause() async {
    await _flutterTts.pause();
  }

  bool get isSpeaking => _isSpeaking;

  // Get available voices
  Future<List<dynamic>> getVoices() async {
    return await _flutterTts.getVoices;
  }

  // Set specific voice
  Future<void> setVoice(Map<String, String> voice) async {
    await _flutterTts.setVoice(voice);
  }
}

import '../../../services/tts_service.dart'; // Add this import at top

Widget _buildActionIcons(BuildContext context) {
  final ttsService = TtsService();
  
  return Padding(
    padding: const EdgeInsets.only(left: 8, top: 6),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildAnimatedIcon(context, iconControllers[0], Icons.copy, () {
          Clipboard.setData(ClipboardData(text: (message as types.TextMessage).text));
          onShowSnackbar("Copied to clipboard", icon: Icons.check_circle, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black);
        }),
        const SizedBox(width: 2),
        
        // TTS Button - CHANGE THIS ICON
        _buildAnimatedIcon(
          context,
          iconControllers[2],
          ttsService.isSpeaking ? Icons.stop : Icons.volume_up, // Changed icon
          () async {
            if (ttsService.isSpeaking) {
              await ttsService.stop();
              onShowSnackbar("Stopped speaking", icon: Icons.stop, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black);
            } else {
              await ttsService.speak((message as types.TextMessage).text);
              onShowSnackbar("Speaking...", icon: Icons.volume_up, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black);
            }
          },
        ),
        
        const SizedBox(width: 2),
        _buildAnimatedIcon(
          context,
          iconControllers[3],
          viewModel.isLiked(message.id) ? Icons.thumb_up : Icons.thumb_up_outlined,
          () {
            viewModel.toggleLike(message.id);
            if (viewModel.isLiked(message.id)) {
              onShowSnackbar("Thank you for your feedback!", icon: Icons.thumb_up, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black);
            }
          },
          color: viewModel.isLiked(message.id) ? Colors.blue : null,
        ),
        const SizedBox(width: 2),
        _buildAnimatedIcon(
          context,
          iconControllers[4],
          viewModel.isDisliked(message.id) ? Icons.thumb_down : Icons.thumb_down_outlined,
          () {
            viewModel.toggleDislike(message.id);
            if (viewModel.isDisliked(message.id)) {
              onShowSnackbar("Thank you for your feedback!", icon: Icons.thumb_down, color: Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black);
            }
          },
          color: viewModel.isDisliked(message.id) ? Colors.red : null,
        ),
        const SizedBox(width: 2),
        _buildAnimatedIcon(context, iconControllers[5], Icons.more_horiz_outlined, () {
          // More options logic
        }),
      ],
    ),
  );
}

@override
void initState() {
  super.initState();
  TtsService().initialize(); // Initialize TTS
  // ... your other init code
}

Future<void> _selectVoice() async {
  final voices = await TtsService().getVoices();
  print(voices); // Check console for available voices
  
  // Set a specific voice
  await TtsService().setVoice({
    "name": "Karen", // Voice name
    "locale": "en-AU" // Australian English
  });
}
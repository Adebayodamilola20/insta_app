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
import 'package:flutter/material.dart';
import 'dart:async';

class ChatGPTOnboarding extends StatefulWidget {
  const ChatGPTOnboarding({super.key});

  @override
  State<ChatGPTOnboarding> createState() => _ChatGPTOnboardingState();
}

class _ChatGPTOnboardingState extends State<ChatGPTOnboarding> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentIndex = 0;
  
  final List<String> _phrases = [
    "Let's collaborate",
    "Design with intent",
    "Build the future",
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            _currentIndex = (_currentIndex + 1) % _phrases.length;
          });
          _controller.forward(from: 0); // Loop it
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            // Animation sequence breakdown:
            // 0.0 -> 0.4: Text slides in
            // 0.4 -> 0.6: Dot expands slightly (the "beat")
            // 0.6 -> 0.9: Dot pulls back, absorbing text
            
            double slideIn = Curves.easeOutCubic.transform((_controller.value / 0.4).clamp(0, 1));
            double dotScale = 1.0;
            if (_controller.value > 0.4 && _controller.value < 0.6) {
              dotScale = 1.0 + (0.2 * Curves.easeInOut.transform(((_controller.value - 0.4) / 0.2)));
            }
            double absorption = 0.0;
            if (_controller.value > 0.6) {
              absorption = Curves.backIn.transform(((_controller.value - 0.6) / 0.3).clamp(0, 1));
            }

            return Opacity(
              opacity: (1.0 - absorption).clamp(0, 1),
              child: Transform.translate(
                offset: Offset(20 * (1 - slideIn) - (100 * absorption), 0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _phrases[_currentIndex],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // The "Absorbing" Circle
                    Transform.scale(
                      scale: dotScale,
                      child: Container(
                        width: 14,
                        height: 14,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.4),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
// Function to save the color hex string
Future<void> saveAccentColor(Color color) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('accent_color', color.value.toRadixString(16));
}

// Function to load the color
Future<Color> loadAccentColor() async {
  final prefs = await SharedPreferences.getInstance();
  String? colorHex = prefs.getString('accent_color');
  return colorHex != null 
      ? Color(int.parse(colorHex, radix: 16)) 
      : Colors.blue; // Default color
}

class AppearanceProvider extends ChangeNotifier {
  Color _accentColor = Colors.blue;
  Color get accentColor => _accentColor;

  AppearanceProvider() {
    _init();
  }

  void _init() async {
    _accentColor = await loadAccentColor();
    notifyListeners();
  }

  void setAccentColor(Color color) {
    _accentColor = color;
    saveAccentColor(color); // Save to local storage
    notifyListeners(); // This tells the Chat Bubbles to turn Green/Red/etc.
  }
}

// Inside your Chat Message Widget
Widget build(BuildContext context) {
  final accentColor = context.watch<AppearanceProvider>().accentColor;

  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      // This is where the magic happens. 
      // All bubbles (old and new) will now use the selected color.
      color: isUserMessage ? accentColor : Colors.grey[800],
      borderRadius: BorderRadius.circular(15),
    ),
    child: Text(messageContent),
  );
}


\_buildSettingsTile(
  icon: Icons.color_lens_outlined,
  title: "Accent color",
  // This circle now shows the current selected color dynamically
  trailingWidget: Consumer<AppearanceProvider>(
    builder: (context, provider, child) {
      return Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: provider.accentColor, // Automatically updates
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white24, width: 1),
        ),
      );
    },
  ),
  // When tapped, show the bunch of colors to pick from
  onTap: () => _showColorPickerSheet(context), 
),,

void _showColorPickerSheet(BuildContext context) {
  final provider = Provider.of<AppearanceProvider>(context, listen: false);
  
  showModalBottomSheet(
    context: context,
    backgroundColor: const Color(0xFF1C1C1E), // Match your dark theme
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Choose Accent Color",
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // A Grid of color options
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5, // 5 colors per row
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
              ),
              itemCount: accentOptions.length,
              itemBuilder: (context, index) {
                final color = accentOptions[index];
                return GestureDetector(
                  onTap: () {
                    provider.setAccentColor(color);
                    Navigator.pop(context); // Close sheet after picking
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: provider.accentColor == color ? Colors.white : Colors.transparent,
                        width: 3,
                      ),
                    ),
                    child: provider.accentColor == color 
                        ? const Icon(Icons.check, color: Colors.white) 
                        : null,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    },
  );
}

// Inside your MessageBubble widget
decoration: BoxDecoration(
  // If it's the user's message, use the dynamic accent color
  color: message.isMe 
      ? context.watch<AppearanceProvider>().accentColor 
      : const Color(0xFF2C2C2E),
  borderRadius: BorderRadius.circular(18),
),

theme: DefaultChatTheme(
  inputBackgroundColor: Colors.transparent,
  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
  
  // 1. CHANGE THIS: Listen to your provider for the bubble color
  primaryColor: context.watch<AppearanceProvider>().accentColor, 
  
  secondaryColor: Colors.transparent, 
  inputTextColor: Theme.of(context).brightness == Brightness.dark
      ? Colors.white
      : Colors.black,
  
  // 2. TEXT COLOR: Ensure text stays readable against the accent color
  sentMessageBodyTextStyle: TextStyle(
    color: Colors.white, // Usually white looks best on bright accent colors
    fontWeight: FontWeight.w500,
    fontSize: 16,
  ),
  // ... rest of your theme
),


Widget _bubbleBuilder(
  Widget child, {
  required message,
  required nextMessageInGroup,
}) {
  // ... keep your animation logic ...
  
  // Get the current accent color
  final accentColor = context.watch<AppearanceProvider>().accentColor;
  final isMe = message.author.id == _user.id;

  return Column(
    crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
    children: [
      SlideTransition(
        position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(animation),
        child: FadeTransition(
          opacity: animation,
          child: Container(
            // 3. APPLY ACCENT COLOR HERE
            decoration: BoxDecoration(
              color: isMe ? accentColor : const Color(0xFF2C2C2E),
              borderRadius: BorderRadius.circular(20),
            ),
            child: child, // This is the actual text/content
          ),
        ),
      ),
    ],
  );
}
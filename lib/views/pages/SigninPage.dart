import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:insta_app/views/pages/Signuppp.dart';
import 'package:insta_app/views/widgetThree.dart';
import 'package:insta_app/shared/provider/Userprovider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'dart:ui';


class Signinpage extends StatefulWidget {
  const Signinpage({super.key});

  @override
  State<Signinpage> createState() => _SigninpageState();
}

class _SigninpageState extends State<Signinpage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  bool obsecurePassword = true;
  final formKey = GlobalKey<FormState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void dispose() {
    emailcontroller.dispose();
    passwordcontroller.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  Future<void> loginWithEmailandPassword() async {
    final userProvider = Provider.of<Userprovider>(context, listen: false);
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: passwordcontroller.text.trim(),
          );

      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        
        userProvider.changeUserNAME(newuserNAME: userData['username'] ?? '');
        userProvider.changeuserEmail(newuserEmail: userData['email'] ?? '');
        userProvider.changefirstname(
          newuserfirstname: userData['firstName'] ?? '',
        );
        userProvider.changephonenumber(
          newphonenumber: userData['phonenumber']?.toString() ?? '',
        );
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  Future<void> signInWithGoogle() async {
    final userProvider = Provider.of<Userprovider>(context, listen: false);
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {

        throw Exception("Sign-in cancelled by user.");
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          String username = user.email!.split('@').first; 
          String firstName = user.displayName ?? 'User';
          String email = user.email ?? '';
          String phone = '';

          await userProvider.saveUserToFirestore(
            userId: user.uid,
            username: username,
            firstName: firstName,
            email: email,
            phone: phone,
          );
        } else {
          await userProvider.loadUserData(userId: user.uid);
        }
      }
    } catch (e) {
      print('Error signing in with Google: $e');
      rethrow;
    }
  }

  Future<void> signInWithApple() async {
    final userProvider = Provider.of<Userprovider>(context, listen: false);
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final AuthCredential credential = OAuthProvider('apple.com').credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        DocumentSnapshot userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .get();

        if (!userDoc.exists) {
          String username = user.email?.split('@').first ?? 'apple_user';
          String firstName = appleCredential.givenName ?? user.displayName ?? 'User';
          String email = appleCredential.email ?? user.email ?? '';
          String phone = '';

          await userProvider.saveUserToFirestore(
            userId: user.uid,
            username: username,
            firstName: firstName,
            email: email,
            phone: phone,
          );
        } else {
          await userProvider.loadUserData(userId: user.uid);
        }
      }
    } catch (e) {
      print('Error signing in with Apple: $e');
      rethrow;
    }
  }

  Future<void> resetPassword() async {
    final TextEditingController resetEmailController = TextEditingController();
    
    // Pre-fill with current email if available
    if (emailcontroller.text.isNotEmpty) {
      resetEmailController.text = emailcontroller.text;
    }

    return showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Reset Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Enter your email to receive a password reset link.'),
              const SizedBox(height: 10),
              TextField(
                controller: resetEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: "Email Address",
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final email = resetEmailController.text.trim();
                if (email.isEmpty || !GetUtils.isEmail(email)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter a valid email')),
                  );
                  return;
                }

                Navigator.pop(dialogContext); // Close dialog
                
                // Show loading
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => const Center(
                    child: CircularProgressIndicator(color: Color(0xFF00BFA5)),
                  ),
                );

                final navigator = Navigator.of(context);
                final messenger = ScaffoldMessenger.of(context);

                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                  navigator.pop(); // Close loading
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text('Password reset link sent to $email'),
                      backgroundColor: Colors.green,
                    ),
                  );
                } catch (e) {
                  navigator.pop(); // Close loading
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text('Error: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00BFA5),
              ),
              child: const Text('Send Link'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(''),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Welcome to',
                                style: GoogleFonts.poppins(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'WazoMart',
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF00BFA5),
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            'Enter your email and password to login',
                            style: GoogleFonts.poppins(color: Colors.grey),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          controller: emailcontroller,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Color(0xFF00BFA5),
                            ),
                            hintText: "e.g. rto1680@gmail.com",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email address';
                            }
                            if (!GetUtils.isEmail(value)) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        'Password',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),

                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextFormField(
                          controller: passwordcontroller,
                          obscureText: obsecurePassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(
                              Icons.lock_outline,
                              color: Color(0xFF00BFA5),
                            ),
                            hintText: "Password",
                            hintStyle: const TextStyle(
                              color: Colors.grey,
                              fontSize: 14,
                            ),
                            suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  obsecurePassword = !obsecurePassword;
                                });
                              },
                              icon: Icon(
                                obsecurePassword
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.grey,
                              ),
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 16,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 9) {
                              return 'Password must be at least 9 characters';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 12),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () => resetPassword(),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      ElevatedButton(
                        onPressed: () async {
                          if (!formKey.currentState!.validate()) {
                            return;
                          }

                          final navigator = Navigator.of(context);
                          final messenger = ScaffoldMessenger.of(context);
                         
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            barrierColor: Colors.black.withOpacity(
                              0.3,
                            ), 
                            builder: (context) {
                              return BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Center(
                                  child: Lottie.asset(
                                    'assets/images/Loading animation blue.json',
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                          );

                          try {
                            await loginWithEmailandPassword();
                            navigator.pop();
                            
                            navigator.pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const Widget_Three()
                              ),
                              (Route<dynamic> route) => false,
                            );
                            
                          } catch (e) {
                            navigator.pop();
                            
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text("Login failed: ${e.toString()}"),
                              ),
                            );
                            
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BFA5),
                          minimumSize: const Size(double.infinity, 56),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      const Center(
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),

                      const SizedBox(height: 24),

                      InkWell(
                        onTap: () async {
                          final navigator = Navigator.of(context);
                          final messenger = ScaffoldMessenger.of(context);

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            barrierColor: Colors.black.withOpacity(0.3),
                            builder: (context) {
                              return BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Center(
                                  child: Lottie.asset(
                                    'assets/images/Loading animation blue.json',
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                          );

                          try {
                            await signInWithGoogle();
                            navigator.pop();
                            
                            navigator.pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const Widget_Three(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                            
                          } catch (e) {
                            navigator.pop();
                            
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text("Google sign-in failed: ${e.toString()}"),
                              ),
                            );
                            
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/images/search.png'),
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Continue with Google',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      InkWell(
                        onTap: () async {
                          final navigator = Navigator.of(context);
                          final messenger = ScaffoldMessenger.of(context);

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            barrierColor: Colors.black.withOpacity(0.3),
                            builder: (context) {
                              return BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                                child: Center(
                                  child: Lottie.asset(
                                    'assets/images/Loading animation blue.json',
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              );
                            },
                          );

                          try {
                            await signInWithApple();
                            navigator.pop();
                            
                            navigator.pushAndRemoveUntil(
                              MaterialPageRoute(
                                builder: (context) => const Widget_Three(),
                              ),
                              (Route<dynamic> route) => false,
                            );
                            
                          } catch (e) {
                            navigator.pop();
                            
                            messenger.showSnackBar(
                              SnackBar(
                                content: Text("Apple sign-in failed: ${e.toString()}"),
                              ),
                            );
                            
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/images/apple-logo.png'),
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Continue with Apple',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/images/facebook.png'),
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 12),
                              Text(
                                'Continue with Facebook',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 5),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Dont have  an account yet ?',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w900,
                                color: Colors.grey,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return const Signuppp();
                                    },
                                  ),
                                );
                              },
                              child: Text(
                                'Register',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w900,
                                  color: const Color(0xFF00BFA5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
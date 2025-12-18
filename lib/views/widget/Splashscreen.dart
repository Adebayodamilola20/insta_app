import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_app/views/pages/Onboradingpage1.dart';
import 'dart:async';





class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> 
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    
    
    _animationController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

   
    _animationController.forward();
    
   
    Timer(Duration(seconds: 9), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  OnboardingPage1(), 
        ),
      );
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal, // Your brand color
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Your app logo
              Padding(
                padding: const EdgeInsets.only(top: 50),
                child: Container(
                  width: 240,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child:Center(
                    child: Text('WazoMart™',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w900,
                      fontSize: 30,
                      color: Colors.teal,
                    
                    ),),
                  )
                ),
              ),
              SizedBox(height: 30),
              
              // Your app name
              
              SizedBox(height: 10),
              
              // Tagline or subtitle
              Text(
                '',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              
              SizedBox(height: 50),
              
              // Loading indicator (optional)
              
            ],
          ),
        ),
      ),
    );
  }
}
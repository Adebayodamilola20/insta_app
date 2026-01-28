import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:insta_app/firebase_options.dart';
import 'package:insta_app/shared/provider/Userprovider.dart';
import 'package:insta_app/shared/provider/offer_provider.dart'; 
import 'package:insta_app/views/pages/Onboradingpage1.dart';
import 'package:insta_app/views/widgetThree.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  

  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    if (e.toString().contains('duplicate-app')) {
     
      print('Firebase already initialized');
    } else {
      // Rethrow other errors
      rethrow;
    }
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Userprovider()),
        ChangeNotifierProvider(create: (context) => OfferProvider()), 
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        builder: (context, child) {
         
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaler: TextScaler.linear(
                MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.2),
              ),
            ),
            child: child!,
          );
        },
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          navigationBarTheme: NavigationBarThemeData(
            backgroundColor: Colors.white,
            indicatorColor: Colors.grey.shade200,
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.data != null) {
              return Widget_Three();
            }
            return OnboardingPage1();
          },
        ),
      ),
    );
  }
}
final TextEditingController _destinationController = TextEditingController();

  Future<void> _searchDestination() async {
    try {
      List<Location> locations = await locationFromAddress(_destinationController.text);
      if (locations.isNotEmpty) {
        var dest = locations.first;
        _addMarker(LatLng(dest.latitude, dest.longitude), "Destination");
      }
    } catch (e) {
      print("Location not found: $e");
    }
  }

  Position? _currentPosition;

  // 1. Get Permission and Start Listening
  void _listenToLocation() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high, 
        distanceFilter: 10 // Update every 10 meters
      ),
    ).listen((Position position) {
      setState(() {
        _currentPosition = position;
        // Move the camera to follow the user
        _mapController?.animateCamera(
          CameraUpdate.newLatLng(LatLng(position.latitude, position.longitude))
        );
      });
    });
  }
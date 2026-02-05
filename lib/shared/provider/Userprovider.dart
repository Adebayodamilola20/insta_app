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

  Future<void> _checkLocationPermission() async {
    if (_isCheckingLocation) return;
    _isCheckingLocation = true;

    try {
      bool serviceEnabled;
      LocationPermission permission;

      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return;
      }
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Location permissions are permanently denied, we cannot request permissions.')),
        );
        return;
      }
      await _getCurrentLocation();
    } finally {
      _isCheckingLocation = false;
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      LatLng currentLng = LatLng(position.latitude, position.longtitude);

      _mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentLatLng, zoom: 15),
        ),
      );

      setState(() {
        _markers.add(
          Marker(
            markerId: const MarkerId('current_location'),
            position: currentLatLng,
            infoWindow: const InfoWindow(title: 'My Location'),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueBlue,
            ),
          ),
        );
      });
    } catch (e) {
      debugPrint("Error getting location: $e");
    }
  }

  Future<List<Map<String, dynamic>>> _getLagosSuggestions(String query) async {
    if (query.isEmpty) return [];

    // Use Photon API (Komoot) which is more reliable and faster
    // Biasing search to Lagos (6.5244, 3.3792)
    // Correct path: /api (no trailing slash)
    final url = Uri.https('photon.komoot.io', '/api', {
      'q': query,
      'limit': '5',
      'lat': '6.5244',
      'lon': '3.3792',
      'location_bias_scale': '0.5',
    });

    try {
      final response = await http.get(
        url,
        headers: {
          'User-Agent': 'ReloExpress-Lagos-Courier-App/1.0',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> features = data['features'] ?? [];
        return features.cast<Map<String, dynamic>>();
      } else {
        debugPrint("Photon API Error: ${response.statusCode}");
        return [];
      }
    } catch (e) {
      debugPrint("Error fetching Photon suggestions: $e");
      return [];
    }
  }

  void _onSuggestionSelected(Map<String, dynamic> suggestion, String field) {
    // Photon returns coordinates as [lon, lat] in GeoJSON
    final List<dynamic> coordinates = suggestion['geometry']['coordinates'];
    final double lon = coordinates[0];
    final double lat = coordinates[1];
    
    final Map<String, dynamic> properties = suggestion['properties'];
    final String name = properties['name'] ?? '';
    final String city = properties['city'] ?? '';
    final String street = properties['street'] ?? '';
    final String displayName = [name, street, city].where((s) => s.isNotEmpty).join(', ');

    final LatLng destLatLng = LatLng(lat, lon);

    setState(() {
      if (field == 'pickup') {
        _pickupController.text = displayName;
      } else {
        _destinationController.text = displayName;
      }
    });

    _mapController?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: destLatLng, zoom: 16),
      ),
    );

    String markerId = field == 'pickup' ? 'pickup_location' : 'destination_location';
    double hue = field == 'pickup' ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed;
    String title = field == 'pickup' ? 'Pickup' : 'Destination';

    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerId),
          position: destLatLng,
          infoWindow: InfoWindow(
            title: title,
            snippet: displayName,
          ),
          icon: BitmapDescriptor.defaultMarkerWithHue(hue),
        ),
      );
    });
  }
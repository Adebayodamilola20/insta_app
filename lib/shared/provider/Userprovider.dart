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
final Set<Polyline> _polylines = {}; // To store the line
LatLng? _pickupLatLng;               // To store pickup coordinate
LatLng? _destinationLatLng;      

void _onSuggestionSelected(Map<String, dynamic> suggestion, String field) {
  final List<dynamic> coordinates = suggestion['geometry']['coordinates'];
  final double lon = coordinates[0];
  final double lat = coordinates[1];
  final LatLng point = LatLng(lat, lon);

  final Map<String, dynamic> properties = suggestion['properties'];
  final String displayName = [
    properties['name'] ?? '',
    properties['street'] ?? '',
    properties['city'] ?? '',
  ].where((s) => s.isNotEmpty).join(', ');

  setState(() {
    if (field == 'pickup') {
      _pickupController.text = displayName;
      _pickupLatLng = point;
    } else {
      _destinationController.text = displayName;
      _destinationLatLng = point;
    }

    // Update markers
    _markers.add(
      Marker(
        markerId: MarkerId(field == 'pickup' ? 'pickup_location' : 'destination_location'),
        position: point,
        infoWindow: InfoWindow(title: field == 'pickup' ? 'Pickup' : 'Destination', snippet: displayName),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          field == 'pickup' ? BitmapDescriptor.hueGreen : BitmapDescriptor.hueRed
        ),
      ),
    );

    // DRAW THE LINE IF BOTH ARE SELECTED
    if (_pickupLatLng != null && _destinationLatLng != null) {
      _drawRoute();
      _fitMapToMarkers();
    } else {
      // If only one is selected, just zoom to that point
      _mapController?.animateCamera(CameraUpdate.newLatLngZoom(point, 15));
    }
  });
}
void _drawRoute() {
  _polylines.clear();
  _polylines.add(
    Polyline(
      polylineId: const PolylineId("delivery_route"),
      points: [_pickupLatLng!, _destinationLatLng!], // Connects A to B
      color: Colors.blue,
      width: 5,
    ),
  );
}

void _fitMapToMarkers() {
  if (_pickupLatLng == null || _destinationLatLng == null) return;

  LatLngBounds bounds;
  if (_pickupLatLng!.latitude > _destinationLatLng!.latitude) {
    bounds = LatLngBounds(southwest: _destinationLatLng!, northeast: _pickupLatLng!);
  } else {
    bounds = LatLngBounds(southwest: _pickupLatLng!, northeast: _destinationLatLng!);
  }

  // This automatically zooms out to show both pins
  _mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));
}

GoogleMap(
  initialCameraPosition: _initialPosition,
  markers: _markers,
  polylines: _polylines, // <--- ADD THIS LINE
  myLocationEnabled: true,
  myLocationButtonEnabled: false,
  zoomControlsEnabled: false,
  onMapCreated: (controller) {
    _mapController = controller;
  },
),    // To store destination coordinate
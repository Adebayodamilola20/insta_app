import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_app/data/notifiers.dart';
import 'package:insta_app/views/pages/Homepage.dart';
import 'package:insta_app/views/pages/ProfilePage.dart';
import 'package:insta_app/views/pages/Search.dart';
import 'package:insta_app/views/pages/activities.dart';
import 'package:insta_app/views/widget/Navbottom.dart';


import 'package:lottie/lottie.dart';
const List<String> availableCategories = [
  'Furniture',
  'Electronics',
  'Kitchenware',
  'Phones',
  'Womens Fashion',
  'Computers',
  'Gaming',
  'Men\'s Fashion',
  'Sports & Outdoor',
  'Wearables',
  'Hobbies',
  'Kids',
  'Lifestyle',
  'Artwork',
];

const List<String> availabletime = [
  '5 days',
  '7 days',
  '10 days',
  '14 days',
  '21 days',
  '30 days',
];

const List<Map<String, String>> itemConditions = [
  {'name': 'New', 'description': 'Unopened packaging, unused item.'},
  {
    'name': 'Like new',
    'description':
        'Excellent condition, but has previously been worn or used. No signs of wear or defects.',
  },
  {
    'name': 'Good',
    'description':
        'Minor signs of wear and tear. Item is operational and works as intended.',
  },
  {
    'name': 'Fair',
    'description':
        'Some signs of wear and tear or minor defects. Item is still usable as intended.',
  },
  {
    'name': 'Poor',
    'description': 'Major flaws or defects but still usable as intended.',
  },
];

const List<Map<String, dynamic>> deliveryMethods = [
  {
    'name': 'Bike',
    'description': 'Small loads with maximum of 5kg',
    'icon': Icons.pedal_bike,
  },
  {
    'name': 'Van',
    'description': 'Big loads with weight up to 150kg',
    'icon': Icons.local_shipping_outlined,
  },
];

class Widget_Three extends StatefulWidget {
  const Widget_Three({super.key});

  @override
  State<Widget_Three> createState() => _Widget_ThreeState();
}

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});
  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  bool isclicked = false;
  List<File> _images = [];
  final ImagePicker _picker = ImagePicker();
  String _selectedCategory = '';
  final _textcontroller4 = TextEditingController();
  final _textcontrollerName = TextEditingController();
  final _textcontrollerDescription = TextEditingController();
  final _textcontrollerPrice = TextEditingController();
  String _selectedCondition = '';
  late StateSetter _dialogSetState;
  String _selectedcategory4 = '';
  String _selectedLocation = '';
  String _selectedMethod = 'Bike';
  bool _autoRelist = false;
  bool _enablePickup = false;

  // Validation state
  String? _priceError;
  final double _minPrice = 500.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDialog();
    });

    _textcontrollerPrice.addListener(_validatePrice);
  }

  @override
  void dispose() {
    _textcontroller4.dispose();
    _textcontrollerName.dispose();
    _textcontrollerDescription.dispose();
    _textcontrollerPrice.dispose();
    super.dispose();
  }

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
      });
      _dialogSetState(() {});
    }
  }

  Future<List<String>> uploadImages() async {
    List<String> downloadUrls = [];
    for (int i = 0; i < _images.length; i++) {
      String fileName = 'listing_${DateTime.now().millisecondsSinceEpoch}_$i.jpg';
      Reference ref = FirebaseStorage.instance.ref().child('listings/$fileName');
      UploadTask uploadTask = ref.putFile(_images[i]);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }
    return downloadUrls;
  }

  void _validatePrice() {
    setState(() {
      final priceText = _textcontrollerPrice.text.trim();
      if (priceText.isEmpty) {
        _priceError = null;
      } else {
        final price = double.tryParse(priceText);
        if (price == null) {
          _priceError = 'Invalid price';
        } else if (price < _minPrice) {
          _priceError = 'Amount should not be less than $_minPrice';
        } else {
          _priceError = null;
        }
      }
    });
    if (mounted) {
      _dialogSetState(() {});
    }
  }

  bool get _canPublish {
    return _images.isNotEmpty &&
        _selectedCategory.isNotEmpty &&
        _selectedCondition.isNotEmpty &&
        _selectedcategory4.isNotEmpty &&
        _selectedLocation.isNotEmpty &&
        _textcontrollerName.text.trim().isNotEmpty &&
        _textcontrollerDescription.text.trim().isNotEmpty &&
        _textcontrollerPrice.text.trim().isNotEmpty &&
        _priceError == null &&
        double.parse(_textcontrollerPrice.text) >= _minPrice;
  }

  void _showDeliveryMethodSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(2),
                      ),
                      margin: const EdgeInsets.only(bottom: 15),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Select delivery method',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: const Color(0xFF2B0A0D),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Let the buyer know how you want them to receive this item.',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                  const SizedBox(height: 25),
                  ...deliveryMethods.map((method) {
                    final isSelected = _selectedMethod == method['name'];
                    return InkWell(
                      onTap: () {
                        setModalState(() {
                          _selectedMethod = method['name'];
                        });
                        _dialogSetState(() {});
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFF14B8A6)
                                : const Color(0xFFE5E7EB),
                            width: 2,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF5722).withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                method['icon'],
                                color: const Color(0xFFFF5722),
                                size: 28,
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    method['name'],
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 18,
                                      color: const Color(0xFF2B0A0D),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    method['description'],
                                    style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: const Color(0xFF9CA3AF),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (isSelected)
                              const Icon(
                                Icons.check_circle,
                                color: Color(0xFFFF5722),
                                size: 28,
                              ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: const Color(0xFFE5E7EB),
                        width: 2,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF5722).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.person_outline,
                            color: Color(0xFFFF5722),
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enable pickup option',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: const Color(0xFF2B0A0D),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Buyer can pickup item themselves',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: const Color(0xFF9CA3AF),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _enablePickup,
                          onChanged: (value) {
                            setModalState(() {
                              _enablePickup = value;
                            });
                            _dialogSetState(() {});
                          },
                          activeColor: const Color(0xFFFF5722),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFF5722),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Continue',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showLocationSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: MediaQuery.of(context).size.height * 0.9,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                  margin: const EdgeInsets.only(bottom: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select location',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: const Color(0xFF2B0A0D),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search for a city or postcode',
                  hintStyle: GoogleFonts.poppins(
                    color: const Color(0xFF9CA3AF),
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Color(0xFF9CA3AF),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    borderSide: BorderSide.none,
                  ),
                  fillColor: const Color(0xFFF3F4F6),
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onSubmitted: (value) {
                  _dialogSetState(() {
                    _selectedLocation = value.isNotEmpty ? value : '';
                  });
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 20),
              Text(
                'Recent Searches',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: const Color(0xFF2B0A0D),
                ),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFF14B8A6),
                ),
                title: Text('Lagos, Nigeria', style: GoogleFonts.poppins()),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _dialogSetState(() {
                    _selectedLocation = 'Lagos, Nigeria';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFF14B8A6),
                ),
                title: Text('Abuja, Nigeria', style: GoogleFonts.poppins()),
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {
                  _dialogSetState(() {
                    _selectedLocation = 'Abuja, Nigeria';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showDurationsheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                  margin: const EdgeInsets.only(bottom: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select auction duration',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: const Color(0xFF2B0A0D),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'Let us know how long you want buyers to bid for your item.',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  color: const Color(0xFF9CA3AF),
                ),
              ),
              const SizedBox(height: 20),
              Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                children: availabletime.map((time) {
                  return ActionChip(
                    labelPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      side: BorderSide.none,
                    ),
                    label: Text(
                      time,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                        color: _selectedcategory4 == time
                            ? Colors.white
                            : const Color(0xFF2B0A0D),
                      ),
                    ),
                    backgroundColor: _selectedcategory4 == time
                        ? const Color(0xFF2B0A0D)
                        : const Color(0xFFF3F4F6),
                    onPressed: () {
                      _dialogSetState(() {
                        _selectedcategory4 = time;
                      });
                      Navigator.pop(context);
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showConditionSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                  margin: const EdgeInsets.only(bottom: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Item condition',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: const Color(0xFF2B0A0D),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                'Select the right condition for your item to avoid return claims or reports.',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF9CA3AF),
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 10),
              ...itemConditions.map((condition) {
                final conditionName = condition['name']!;
                final conditionDesc = condition['description']!;
                return InkWell(
                  onTap: () {
                    _dialogSetState(() {
                      _selectedCondition = conditionName;
                    });
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.shade200),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Radio<String>(
                          value: conditionName,
                          groupValue: _selectedCondition,
                          onChanged: (String? value) {
                            if (value != null) {
                              _dialogSetState(() {
                                _selectedCondition = value;
                              });
                              Navigator.pop(context);
                            }
                          },
                          activeColor: const Color(0xFF14B8A6),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                conditionName,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: const Color(0xFF2B0A0D),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                conditionDesc,
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 13,
                                  color: const Color(0xFF9CA3AF),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  void _showCategorySheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.8,
          ),
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                  margin: const EdgeInsets.only(bottom: 15),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Select category',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: const Color(0xFF2B0A0D),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              RichText(
                text: TextSpan(
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: const Color(0xFF2B0A0D),
                  ),
                  children: const [
                    TextSpan(text: 'If it has a category on Rensa, Sell it.\n'),
                    TextSpan(
                      text: 'Please read Rensa\'s ',
                      style: TextStyle(color: Color(0xFF9CA3AF)),
                    ),
                    TextSpan(
                      text: 'Prohibited Items',
                      style: TextStyle(color: Color(0xFFFF5722)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 10.0,
                    runSpacing: 10.0,
                    children: availableCategories.map((category) {
                      return ActionChip(
                        labelPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50.0),
                          side: BorderSide.none,
                        ),
                        label: Text(
                          category,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: _selectedCategory == category
                                ? Colors.white
                                : const Color(0xFF2B0A0D),
                          ),
                        ),
                        backgroundColor: _selectedCategory == category
                            ? const Color(0xFF2B0A0D)
                            : const Color(0xFFF3F4F6),
                        onPressed: () {
                          _dialogSetState(() {
                            _selectedCategory = category;
                          });
                          Navigator.pop(context);
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Create Listing",
      pageBuilder: (context, animation, secondaryAnimation) {
        return StatefulBuilder(
          builder: (context, dialogSetState) {
            _dialogSetState = dialogSetState;
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                title: Text(
                  'New Listing',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: const Color(0xFF2B0A0D),
                  ),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                    selectedValueNotifier.value = 0;
                  },
                  icon: const Icon(Icons.close, color: Color(0xFF2B0A0D)),
                ),
                actions: [
                  IconButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(height: 10),
                                Container(
                                  width: 40,
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(2),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.all(18.0),
                                  child: Column(
                                    children: [
                                      _buildMenuOption(
                                        icon: Icons.error_outline,
                                        title: 'Listing an item',
                                        subtitle: 'Listing rules on Wazomart',
                                        color: const Color(0xFF14B8A6),
                                      ),
                                      _buildMenuOption(
                                        icon: Icons.menu_book_outlined,
                                        title: 'How it works',
                                        subtitle:
                                            'Learn how to buy or sell on WazoMart',
                                        color: const Color(0xFF14B8A6),
                                      ),
                                      _buildMenuOption(
                                        icon: Icons.help_outline,
                                        title: 'Contact support',
                                        subtitle: 'Need help with this item?',
                                        color: const Color(0xFF14B8A6),
                                        isLast: true,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.more_horiz,
                      color: Color(0xFF2B0A0D),
                    ),
                  ),
                ],
              ),
              body: SafeArea(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Photo Upload Section
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: _images.isEmpty
                                ? InkWell(
                                    onTap: pickImage,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12.0),
                                        border: Border.all(
                                          color: const Color(0xFFE5E7EB),
                                          width: 2,
                                        ),
                                      ),
                                      height: 120,
                                      width: 120,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            size: 30,
                                            color: Color(0xFF9CA3AF),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            'Take photo\n& video',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: const Color(0xFF9CA3AF),
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : SizedBox(
                                    height: 120,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: _images.length + 1,
                                      itemBuilder: (context, index) {
                                        if (index == _images.length) {
                                          return InkWell(
                                            onTap: pickImage,
                                            child: Container(
                                              width: 100,
                                              margin: const EdgeInsets.only(left: 8),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.0),
                                                border: Border.all(
                                                  color: const Color(0xFFE5E7EB),
                                                  width: 2,
                                                ),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                size: 30,
                                                color: Color(0xFF9CA3AF),
                                              ),
                                            ),
                                          );
                                        }
                                        return Stack(
                                          children: [
                                            Container(
                                              width: 100,
                                              margin: const EdgeInsets.only(left: 8),
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(12.0),
                                                image: DecorationImage(
                                                  image: FileImage(_images[index]),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                            Positioned(
                                              top: 4,
                                              right: 12,
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    _images.removeAt(index);
                                                  });
                                                  _dialogSetState(() {});
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets.all(4),
                                                  decoration: const BoxDecoration(
                                                    color: Colors.red,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    size: 16,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                          ),

                          // Category Field
                          _buildInputField(
                            label: 'Category',
                            value: _selectedCategory.isEmpty
                                ? ''
                                : _selectedCategory,
                            onTap: _showCategorySheet,
                            isEmpty: _selectedCategory.isEmpty,
                          ),

                          // Item Name Field
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: const Color(0xFFE5E7EB),
                                  width: 2,
                                ),
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: _textcontrollerName,
                                style: GoogleFonts.poppins(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF2B0A0D),
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Item name',
                                  labelStyle: GoogleFonts.poppins(
                                    color: const Color(0xFF9CA3AF),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 15,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  _dialogSetState(() {});
                                },
                              ),
                            ),
                          ),

                          // Description Field
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                border: Border.all(
                                  color: const Color(0xFFE5E7EB),
                                  width: 2,
                                ),
                                color: Colors.white,
                              ),
                              child: TextField(
                                controller: _textcontrollerDescription,
                                maxLines: 5,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF2B0A0D),
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Description',
                                  alignLabelWithHint: true,
                                  labelStyle: GoogleFonts.poppins(
                                    color: const Color(0xFF9CA3AF),
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14,
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 15,
                                  ),
                                  border: InputBorder.none,
                                ),
                                onChanged: (value) {
                                  _dialogSetState(() {});
                                },
                              ),
                            ),
                          ),

                          // Item Condition
                          _buildInputField(
                            label: 'Item condition',
                            value: _selectedCondition.isEmpty
                                ? ''
                                : _selectedCondition,
                            onTap: _showConditionSheet,
                            isEmpty: _selectedCondition.isEmpty,
                          ),

                          // Price Field
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                              vertical: 10.0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.0),
                                    border: Border.all(
                                      color: _priceError != null
                                          ? Colors.red
                                          : const Color(0xFFE5E7EB),
                                      width: 2,
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: TextField(
                                    controller: _textcontrollerPrice,
                                    keyboardType: TextInputType.number,
                                    style: GoogleFonts.poppins(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF2B0A0D),
                                    ),
                                    decoration: InputDecoration(
                                      labelText: 'Price',
                                      labelStyle: GoogleFonts.poppins(
                                        color: const Color(0xFF9CA3AF),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                      prefixText: '₦',
                                      prefixStyle: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF2B0A0D),
                                      ),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 15,
                                          ),
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                if (_priceError != null)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 5,
                                    ),
                                    child: Text(
                                      _priceError!,
                                      style: GoogleFonts.poppins(
                                        color: Colors.red,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  )
                                else if (_textcontrollerPrice.text.isNotEmpty)
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 5,
                                      left: 5,
                                    ),
                                    child: Text(
                                      'Item priced lower than retail price sells faster',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0xFF9CA3AF),
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          // Listing Duration
                          _buildInputField(
                            label: 'Listing duration',
                            value: _selectedcategory4.isEmpty
                                ? ''
                                : _selectedcategory4,
                            onTap: _showDurationsheet,
                            isEmpty: _selectedcategory4.isEmpty,
                          ),

                          // Delivery Method
                          _buildInputField(
                            label: 'Delivery method',
                            value: _selectedMethod.isEmpty
                                ? ''
                                : _enablePickup
                                ? '$_selectedMethod and Pickup'
                                : _selectedMethod,
                            onTap: _showDeliveryMethodSheet,
                            isEmpty: false,
                          ),

                          // Item Location
                          _buildInputField(
                            label: 'Item location',
                            value: _selectedLocation,
                            onTap: _showLocationSheet,
                            isEmpty: _selectedLocation.isEmpty,
                            icon: Icons.location_on_outlined,
                          ),

                          const SizedBox(height: 20),

                          // Auto-relist Section
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFFBF5),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFFE5E7EB),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Auto-relist',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: const Color(0xFF2B0A0D),
                                          ),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          'Keep your listing active until it\'s sold',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 13,
                                            color: const Color(0xFF9CA3AF),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Switch(
                                    value: _autoRelist,
                                    onChanged: (value) {
                                      _dialogSetState(() {
                                        _autoRelist = value;
                                      });
                                    },
                                    activeColor: const Color(0xFFFF5722),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Seller Protection Section
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20.0,
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF8F9FA),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF14B8A6),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: const Icon(
                                      Icons.verified_user_outlined,
                                      color: Colors.white,
                                      size: 30,
                                    ),
                                  ),
                                  const SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Seller protection',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 16,
                                            color: const Color(0xFF2B0A0D),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        RichText(
                                          text: TextSpan(
                                            style: GoogleFonts.poppins(
                                              fontSize: 13,
                                              color: const Color(0xFF6B7280),
                                            ),
                                            children: const [
                                              TextSpan(
                                                text:
                                                    'Enjoy secure transactions with just a ',
                                              ),
                                              TextSpan(
                                                text: '2%',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                              TextSpan(
                                                text:
                                                    ' seller protection fee per sale. You only pay when your item sells!',
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          'Learn more',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 13,
                                            color: const Color(0xFFFF5722),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),
                        ],
                      ),
                    ),
                  ),

                  // Publish Button
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _canPublish
                            ? () async {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) => Center(
                                    child: Lottie.asset(
                                      'assets/images/Loading animation blue.json',
                                      width: 120,
                                      height: 120,
                                    ),
                                  ),
                                );

                                try {
                                  List<String> imageUrls = await uploadImages();

                                  String userId = FirebaseAuth.instance.currentUser!.uid;

                                  // Convert duration string to milliseconds
                                  int durationMs = 0;
                                  switch (_selectedcategory4) {
                                    case '5 days':
                                      durationMs = Duration(days: 5).inMilliseconds;
                                      break;
                                    case '7 days':
                                      durationMs = Duration(days: 7).inMilliseconds;
                                      break;
                                    case '10 days':
                                      durationMs = Duration(days: 10).inMilliseconds;
                                      break;
                                    case '14 days':
                                      durationMs = Duration(days: 14).inMilliseconds;
                                      break;
                                    case '21 days':
                                      durationMs = Duration(days: 21).inMilliseconds;
                                      break;
                                    case '30 days':
                                      durationMs = Duration(days: 30).inMilliseconds;
                                      break;
                                  }

                                  await FirebaseFirestore.instance.collection('listings').add({
                                    'title': _textcontrollerName.text.trim(),
                                    'description': _textcontrollerDescription.text.trim(),
                                    'price': '₦${_textcontrollerPrice.text.trim()}',
                                    'category': _selectedCategory,
                                    'condition': _selectedCondition,
                                    'location': _selectedLocation,
                                    'images': imageUrls,
                                    'deliveryOptions': _enablePickup ? ['Pickup', _selectedMethod] : [_selectedMethod],
                                    'userId': userId,
                                    'createdAt': FieldValue.serverTimestamp(),
                                    'duration': durationMs,
                                  });

                                  Navigator.pop(context); // Close loading dialog
                                  Navigator.pop(context); // Close create dialog
                                  selectedValueNotifier.value = 0; // Go to home

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Listing published successfully!')),
                                  );
                                } catch (e) {
                                  Navigator.pop(context);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text('Error publishing listing: $e')),
                                  );
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _canPublish
                              ? const Color(0xFF00BFA5)
                              : const Color(0xFFE5E7EB),
                          disabledBackgroundColor: const Color(0xFFE5E7EB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Publish',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            color: _canPublish
                                ? Colors.white
                                : const Color(0xFF9CA3AF),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ),
              ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInputField({
    required String label,
    required String value,
    required VoidCallback onTap,
    required bool isEmpty,
    IconData? icon,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: GoogleFonts.poppins(
                        color: const Color(0xFF9CA3AF),
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                    if (value.isNotEmpty) ...[
                      const SizedBox(height: 5),
                      Text(
                        value,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF2B0A0D),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Icon(
                icon ?? Icons.keyboard_arrow_down,
                color: const Color(0xFF9CA3AF),
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    bool isLast = false,
  }) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isLast ? Colors.transparent : const Color(0xFFE5E7EB),
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25.0),
                color: color.withOpacity(0.1),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: const Color(0xFF2B0A0D),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w400,
                      fontSize: 13,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white);
  }
}

List<Widget> pages = [
  Homepage(),
  Search(),
  const CreatePage(),
  Activities(),
  const Profilepage(),
];

class _Widget_ThreeState extends State<Widget_Three> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ValueListenableBuilder(
        valueListenable: selectedValueNotifier,
        builder: (context, selectedvalue, child) {
          return pages.elementAt(selectedvalue);
          
        },
      ),
      bottomNavigationBar: Navbottom(),
    );
  }
  Future<void> _useClassStateMethod() async{
    final pi
  }
}

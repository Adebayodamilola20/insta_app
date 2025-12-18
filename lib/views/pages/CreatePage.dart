/*
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../shared/provider/listing_provider.dart';
import '../../shared/provider/userprovider.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});
  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  
  String _selectedCategory = '';
  final _textController4 = TextEditingController();
  final _textControllerName = TextEditingController();
  final _textControllerPrice = TextEditingController();
  String _selectedCondition = '';
  late StateSetter _dialogSetState;
  String _selectedDuration = '';
  String _selectedLocation = '';
  String _selectedMethod = 'Bike';
  bool _autoRelist = false;
  bool _enablePickup = false;
  bool _isUploading = false;

  String? _priceError;
  final double _minPrice = 500.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDialog();
    });
    _textControllerPrice.addListener(_validatePrice);
  }

  @override
  void dispose() {
    _textController4.dispose();
    _textControllerName.dispose();
    _textControllerPrice.dispose();
    super.dispose();
  }

  // Show bottom sheet for image source selection
  void _showImageSourceSheet() {
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
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
                margin: const EdgeInsets.only(bottom: 20),
              ),
              Text(
                'Add Photos',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF2B0A0D),
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF14B8A6).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.camera_alt, color: Color(0xFF14B8A6)),
                ),
                title: Text(
                  'Take Photo',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF5722).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.photo_library, color: Color(0xFFFF5722)),
                ),
                title: Text(
                  'Choose from Gallery',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
                onTap: () async {
                  Navigator.pop(context);
                  await _pickImage(ImageSource.gallery);
                },
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  // Pick image from camera or gallery
  Future<void> _pickImage(ImageSource source) async {
    try {
      if (source == ImageSource.gallery) {
        final List<XFile> images = await _picker.pickMultiImage();
        if (images.isNotEmpty) {
          _dialogSetState(() {
            _selectedImages.addAll(images.map((xFile) => File(xFile.path)));
            if (_selectedImages.length > 6) {
              _selectedImages = _selectedImages.sublist(0, 6);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Maximum 6 images allowed', 
                    style: GoogleFonts.poppins()),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          });
        }
      } else {
        final XFile? image = await _picker.pickImage(source: source);
        if (image != null) {
          _dialogSetState(() {
            if (_selectedImages.length < 6) {
              _selectedImages.add(File(image.path));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Maximum 6 images allowed', 
                    style: GoogleFonts.poppins()),
                  backgroundColor: Colors.orange,
                ),
              );
            }
          });
        }
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  void _validatePrice() {
    setState(() {
      final priceText = _textControllerPrice.text.trim();
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
    return _selectedCategory.isNotEmpty &&
        _selectedCondition.isNotEmpty &&
        _selectedDuration.isNotEmpty &&
        _selectedLocation.isNotEmpty &&
        _textControllerName.text.trim().isNotEmpty &&
        _textController4.text.trim().isNotEmpty &&
        _textControllerPrice.text.trim().isNotEmpty &&
        _priceError == null &&
        _selectedImages.isNotEmpty &&
        double.parse(_textControllerPrice.text) >= _minPrice;
  }

  Future<void> _publishListing(BuildContext context) async {
    if (!_canPublish) return;

    setState(() {
      _isUploading = true;
    });

    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception('User not logged in');
      }

      final userProvider = Provider.of<Userprovider>(context, listen: false);
      final listingProvider = Provider.of<ListingProvider>(context, listen: false);

      await listingProvider.createListing(
        title: _textControllerName.text.trim(),
        price: '₦${_textControllerPrice.text.trim()}',
        location: _selectedLocation,
        description: _textController4.text.trim(),
        category: _selectedCategory,
        condition: _selectedCondition,
        duration: _selectedDuration,
        deliveryMethod: _selectedMethod,
        enablePickup: _enablePickup,
        autoRelist: _autoRelist,
        userId: user.uid,
        userName: userProvider.userNAME.isNotEmpty 
            ? userProvider.userNAME 
            : userProvider.firstname,
        images: _selectedImages,
      );

      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Listing published successfully!', 
            style: GoogleFonts.poppins()),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}', 
            style: GoogleFonts.poppins()),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isUploading = false;
      });
    }
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
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Color(0xFF2B0A0D)),
                ),
              ),
              body: _isUploading
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircularProgressIndicator(
                            color: Color(0xFF14B8A6),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Publishing your listing...',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Photo Upload Section
                                Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Photos (${_selectedImages.length}/6)',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            InkWell(
                                              onTap: _showImageSourceSheet,
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
                                                  children: [
                                                    const Icon(Icons.add, size: 30),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      'Add photos',
                                                      style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            ..._selectedImages.asMap().entries.map((entry) {
                                              int index = entry.key;
                                              File image = entry.value;
                                              return Padding(
                                                padding: const EdgeInsets.only(right: 10),
                                                child: Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(12),
                                                      child: Image.file(
                                                        image,
                                                        height: 120,
                                                        width: 120,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 5,
                                                      right: 5,
                                                      child: InkWell(
                                                        onTap: () {
                                                          _dialogSetState(() {
                                                            _selectedImages.removeAt(index);
                                                          });
                                                        },
                                                        child: Container(
                                                          padding: const EdgeInsets.all(5),
                                                          decoration: const BoxDecoration(
                                                            color: Colors.red,
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: const Icon(
                                                            Icons.close,
                                                            color: Colors.white,
                                                            size: 16,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // Item Name
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: TextField(
                                    controller: _textControllerName,
                                    decoration: InputDecoration(
                                      labelText: 'Item name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onChanged: (value) => _dialogSetState(() {}),
                                  ),
                                ),

                                // Description
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: TextField(
                                    controller: _textController4,
                                    maxLines: 4,
                                    decoration: InputDecoration(
                                      labelText: 'Description',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    onChanged: (value) => _dialogSetState(() {}),
                                  ),
                                ),

                                // Category
                                _buildInputField(
                                  label: 'Category',
                                  value: _selectedCategory,
                                  onTap: () => _showCategorySheet(dialogSetState),
                                  isEmpty: _selectedCategory.isEmpty,
                                ),

                                // Condition
                                _buildInputField(
                                  label: 'Item condition',
                                  value: _selectedCondition,
                                  onTap: () => _showConditionSheet(dialogSetState),
                                  isEmpty: _selectedCondition.isEmpty,
                                ),

                                // Price
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TextField(
                                        controller: _textControllerPrice,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          labelText: 'Price',
                                          prefixText: '₦',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                            borderSide: BorderSide(
                                              color: _priceError != null 
                                                  ? Colors.red 
                                                  : const Color(0xFFE5E7EB),
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (_priceError != null)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Text(
                                            _priceError!,
                                            style: GoogleFonts.poppins(
                                              color: Colors.red,
                                              fontSize: 13,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),

                                // Duration
                                _buildInputField(
                                  label: 'Listing duration',
                                  value: _selectedDuration,
                                  onTap: () => _showDurationSheet(dialogSetState),
                                  isEmpty: _selectedDuration.isEmpty,
                                ),

                                // Delivery Method
                                _buildInputField(
                                  label: 'Delivery method',
                                  value: _enablePickup 
                                      ? '$_selectedMethod and Pickup'
                                      : _selectedMethod,
                                  onTap: () => _showDeliveryMethodSheet(dialogSetState),
                                  isEmpty: false,
                                ),

                                // Location
                                _buildInputField(
                                  label: 'Item location',
                                  value: _selectedLocation,
                                  onTap: () => _showLocationSheet(dialogSetState),
                                  isEmpty: _selectedLocation.isEmpty,
                                  icon: Icons.location_on_outlined,
                                ),

                                const SizedBox(height: 30),
                              ],
                            ),
                          ),
                        ),

                        // Publish Button
                        Container(
                          padding: const EdgeInsets.all(20),
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: ElevatedButton(
                              onPressed: _canPublish 
                                  ? () => _publishListing(context)
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _canPublish
                                    ? const Color(0xFF2B0A0D)
                                    : const Color(0xFFE5E7EB),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text(
                                'Publish',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18,
                                  color: _canPublish ? Colors.white : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 2),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(label, style: GoogleFonts.poppins(
                      color: const Color(0xFF9CA3AF),
                      fontSize: 14,
                    )),
                    if (value.isNotEmpty)
                      Text(value, style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      )),
                  ],
                ),
              ),
              Icon(icon ?? Icons.keyboard_arrow_down),
            ],
          ),
        ),
      ),
    );
  }

  // Keep your existing bottom sheet methods (_showCategorySheet, _showConditionSheet, etc.)
  // Just update them to use the dialogSetState parameter instead of _dialogSetState
  
  void _showCategorySheet(StateSetter dialogSetState) {
    // Your existing category sheet code
    // Replace setState calls with dialogSetState
  }
  
  void _showConditionSheet(StateSetter dialogSetState) {
    // Your existing condition sheet code
  }
  
  void _showDurationSheet(StateSetter dialogSetState) {
    // Your existing duration sheet code
  }
  
  void _showDeliveryMethodSheet(StateSetter dialogSetState) {
    // Your existing delivery method sheet code
  }
  
  void _showLocationSheet(StateSetter dialogSetState) {
    // Your existing location sheet code
  }

  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.white);
  }
}
*/
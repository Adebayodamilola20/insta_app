import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:insta_app/models/offer_model.dart'; 
import 'package:insta_app/shared/provider/offer_provider.dart'; 

class OfferPage extends StatefulWidget {
  final String sellingPrice;
  final String productTitle;
  final double minimumOffer;
  final String imageUrl;
  final String location;
  final Duration currentDuration;

  const OfferPage({
    super.key,
    required this.sellingPrice,
    required this.productTitle,
    required this.minimumOffer,
    required this.imageUrl,
    required this.location,
    required this.currentDuration,
  });

  @override
  State<OfferPage> createState() => _OfferPageState();
}

class _OfferPageState extends State<OfferPage> {
  String offerAmount = '';
  bool isLoading = false;
  String? errorMessage;

  List<String> getQuickOffers() {
    final baseAmount = widget.minimumOffer;
    return [
      '₦${(baseAmount + 3000).toStringAsFixed(0)}',
      '₦${(baseAmount + 5000).toStringAsFixed(0)}',
      '₦${(baseAmount + 7000).toStringAsFixed(0)}',
    ];
  }

  void _onNumberPressed(String number) {
    setState(() {
      if (offerAmount.length < 10) {
        offerAmount += number;
        errorMessage = null;
      }
    });
  }

  void _onDeletePressed() {
    setState(() {
      if (offerAmount.isNotEmpty) {
        offerAmount = offerAmount.substring(0, offerAmount.length - 1);
        errorMessage = null;
      }
    });
  }

  void _onQuickOfferPressed(String offer) {
    setState(() {
      offerAmount = offer.replaceAll('₦', '').replaceAll(',', '');
      errorMessage = null;
    });
  }

  Future<void> _submitOffer() async {
    if (offerAmount.isEmpty) {
      setState(() {
        errorMessage = 'Please enter an offer amount';
      });
      return;
    }

    final offerValue = double.tryParse(offerAmount);
    if (offerValue == null) {
      setState(() {
        errorMessage = 'Please enter a valid amount';
      });
      return;
    }

    if (offerValue < widget.minimumOffer) {
      setState(() {
        errorMessage =
            'Your offer must be at least ₦${widget.minimumOffer.toStringAsFixed(0)}';
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });
    
    final offeredPriceFormatted = '₦${offerValue.toStringAsFixed(0)}';
    
    final newOffer = OfferModel(
      productTitle: widget.productTitle,
      offeredPrice: offeredPriceFormatted,
      sellingPrice: widget.sellingPrice,
      imageUrl: widget.imageUrl,
      location: widget.location,
      submissionTime: DateTime.now(),
      originalDuration: widget.currentDuration,
    );
    
    Provider.of<OfferProvider>(context, listen: false).addOffer(newOffer);
    
    await Future.delayed(const Duration(seconds: 5));

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Offer submitted!',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    'The seller will be notified of your ₦${offerValue.toStringAsFixed(0)} offer',
                    style: GoogleFonts.poppins(fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF00BFA5),
        duration: const Duration(seconds: 4),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );

    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      Navigator.pop(context);
    }
  }

  String _formatDisplayAmount() {
    if (offerAmount.isEmpty) return '₦0';
    final value = int.tryParse(offerAmount) ?? 0;
    return '₦${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}';
  }

  @override
  Widget build(BuildContext context) {
    final quickOffers = getQuickOffers();
    final canSubmit = offerAmount.isNotEmpty && !isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Padding(
          padding: const EdgeInsets.only(top: 16.0, left: 20.0, right: 16.0, bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Make offer',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.close, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Stack(
              children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        widget.sellingPrice,
                        style: GoogleFonts.poppins(
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Selling price',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        _formatDisplayAmount(),
                        style: GoogleFonts.poppins(
                          fontSize: 27,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF00BFA5),
                        ),
                      ),
                      const SizedBox(height: 1),
                      if (errorMessage != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            errorMessage!,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.red,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )
                      else
                        Text(
                          'Your offer must be at least ₦${widget.minimumOffer.toStringAsFixed(0)}',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.red.shade400,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: quickOffers.map((offer) {
                          return Flexible(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6.0,
                              ),
                              child: ElevatedButton(
                                onPressed: isLoading
                                    ? null
                                    : () => _onQuickOfferPressed(offer),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey.shade100,
                                  foregroundColor: Colors.black87,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  offer,
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Text(
                          'By submitting an offer, you are making a commitment to purchase this item if accepted',
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.grey.shade700,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: canSubmit ? _submitOffer : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00BFA5),
                            disabledBackgroundColor: Colors.grey.shade300,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28),
                            ),
                            elevation: 0,
                          ),
                          child: Text(
                            'Submit offer',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 200),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(color: Colors.grey.shade100),
                child: Column(
                  children: [
                    for (var row in [
                      ['1', '2', '3'],
                      ['4', '5', '6'],
                      ['7', '8', '9'],
                      ['', '0', 'delete'],
                    ])
                      Row(
                        children: row.map((key) {
                          if (key.isEmpty) {
                            return const Expanded(child: SizedBox(height: 60));
                          }
                          return Expanded(
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 0.5,
                                  ),
                                  right:
                                      key != '3' &&
                                          key != '6' &&
                                          key != '9' &&
                                          key != 'delete'
                                      ? BorderSide(
                                          color: Colors.grey.shade300,
                                          width: 0.5,
                                        )
                                      : BorderSide.none,
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: isLoading
                                      ? null
                                      : key == 'delete'
                                      ? _onDeletePressed
                                      : () => _onNumberPressed(key),
                                  child: Center(
                                    child: key == 'delete'
                                        ? const Icon(
                                            Icons.backspace_outlined,
                                            color: Colors.black87,
                                            size: 24,
                                          )
                                        : Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                key,
                                                style: const TextStyle(
                                                  fontSize: 28,
                                                  fontWeight: FontWeight.w900,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              if (key != '0' && key != '1')
                                                Text(
                                                  {
                                                        '2': '',
                                                        '3': ' ',
                                                        '4': '',
                                                        '5': '',
                                                        '6': '',
                                                        '7': '',
                                                        '8': '',
                                                        '9': '',
                                                      }[key] ??
                                                      '',
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                    letterSpacing: 1,
                                                    color: Colors.grey.shade600,
                                                    fontWeight: FontWeight.w900,
                                                  ),
                                                ),
                                            ],
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (isLoading)
            Container(
              color: Colors.black.withOpacity(0.3),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Lottie.asset(
                        'assets/images/Loading animation blue.json',
                        width: 80,
                        height: 80,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Please wait...',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
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
  }
}
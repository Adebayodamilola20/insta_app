import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Wazomart extends StatefulWidget {
  const Wazomart({super.key});

  @override
  State<Wazomart> createState() => _WazomartState();
}

class _WazomartState extends State<Wazomart>
    with SingleTickerProviderStateMixin {
  late TabController _tabcontroller2;
  static const Color _tealColor = Color(0xFF009688);
  static const Color _deepBrown = Color(0xFF00BFA5);

  @override
  void initState() {
    // Corrected length from 3 to 2
    _tabcontroller2 = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabcontroller2.dispose();
    super.dispose();
  }

  Widget _buildStepItem(String number, String title, String description) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey[200]!)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  // Border color changed to Teal
                  border: Border.all(color: _tealColor.withOpacity(0.5)),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: _deepBrown,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              // Expanded ensures the text column doesn't overflow horizontally
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: _deepBrown,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
          color: _deepBrown,
        ),
        title: Text(
          'How it works',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            color: _deepBrown,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 26.0,
              vertical: 20.0,
            ),
            child: Container(
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: TabBar(
                controller: _tabcontroller2,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(color: _tealColor, width: 4.0),
                  insets: const EdgeInsets.symmetric(horizontal: 20.0),
                ),
                indicatorSize: TabBarIndicatorSize.label,
                dividerColor: Colors.transparent,
                tabs: const [
                  Tab(text: '',),
                  Tab(text: ''),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabcontroller2,
              children: [
                // Tab 1: Buying on WazoMart (Fully Fixed)
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0),
                        child: Text(
                          'Buying on WazoMart',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            color: _deepBrown,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildStepItem(
                        '1',
                        'Explore listing',
                        'Browse through a wide range of quality used items available for sell on WazoMart.',
                      ),
                      _buildStepItem(
                        '2',
                        'Place bids',
                        'Find an item you like and place your bid or make a buy now offer.',
                      ),
                      _buildStepItem(
                        '3',
                        'Winning bid',
                        'If you have the highest bid when the auction ends or your offer is accepted by seller, you win the item.',
                      ),
                      _buildStepItem(
                        '4',
                        'Schedule delivery & pay',
                        'Pick a preferred delivery date and make payment for item and delivery fee through a secure escrow system.',
                      ),
                      _buildStepItem(
                        '5',
                        'Item receipt',
                        'Once you receive the item, confirm its condition. The payment is then released to the seller.',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 34.0,
                          vertical: 40.0,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // Action to move to the next tab
                            _tabcontroller2.animateTo(1);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 60),
                            backgroundColor: _tealColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Continue',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Tab 2: Selling on WazoMart (FIXED)
                SingleChildScrollView(
                  // <-- FIX: Wrap in SingleChildScrollView to prevent overflow
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26.0),
                        child: Text(
                          'Selling on WazoMart',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            color: _deepBrown,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      _buildStepItem(
                        '1',
                        'List your item',
                        'List your items with real photos, descriptions, and auction prices.',
                      ),
                      _buildStepItem(
                        '2',
                        'Auction management',
                        'Every item sells fast. Track the progress of your listing and monitor competing bids in real-time.',
                      ),
                      _buildStepItem(
                        '3',
                        'Winning bidder',
                        'When the auction ends, WazoMart notifies you of the winning bidder.',
                      ),
                      _buildStepItem(
                        '4',
                        'Buyer confirmation',
                        'WazoMart delivers the item to the buyer. Payment is released to your bank account after buyer confirmation.',
                      ),
                      _buildStepItem(
                        '5',
                        'WazoMart commission',
                        'WazoMart takes a small commission on every sold item.',
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 34.0,
                          vertical: 40.0,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 60),
                            backgroundColor: _tealColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          child: Text(
                            'Start Shopping',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
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
    );
  }
}

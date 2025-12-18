import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:insta_app/models/offer_model.dart';
import 'package:insta_app/shared/provider/offer_provider.dart';

import 'package:insta_app/models/countdown_timer.dart';

// Converted to StatefulWidget to use TabController
class Activities extends StatefulWidget {
  const Activities({super.key});

  @override
  State<Activities> createState() => _ActivitiesState();
}

class _ActivitiesState extends State<Activities>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 120,
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Large "Activity" title
              Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 16.0,
                  bottom: 8.0,
                ),
                child: Text(
                  'Activity',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                    color: Colors.black,
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 19.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: Color.fromARGB(133, 238, 238, 238),
                  ),
                  padding: EdgeInsets.all(4.0),
                  child: TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: const Color.fromARGB(255, 255, 255, 255),
                    unselectedLabelColor: Colors.grey,
                    indicator: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicatorPadding: EdgeInsets.zero,
                    labelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                    unselectedLabelStyle: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                    tabs: const [
                      Tab(text: 'Buying'),
                      Tab(text: 'Selling'),
                      Tab(text: 'Orders'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: TabBarView(
              controller: _tabController,
              children: const [
                _BuyingOffersList(),

                Center(child: Text('Selling Activity')),

                Center(child: Text('Order History')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BuyingOffersList extends StatelessWidget {
  const _BuyingOffersList();

  @override
  Widget build(BuildContext context) {
    // Note: The context.watch must be inside the widget where data is used
    final offerProvider = context.watch<OfferProvider>();
    final offers = offerProvider.userOffers;

    if (offers.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'You haven\'t made any offers yet.',
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12.0),
      itemCount: offers.length,
      itemBuilder: (context, index) {
        final offer = offers[index];
        return _OfferCard(offer: offer);
      },
    );
  }
}

// Your existing _OfferCard widget (nested inside _BuyingOffersList)
class _OfferCard extends StatelessWidget {
  final OfferModel offer;

  const _OfferCard({required this.offer});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                offer.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    offer.productTitle,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  // This is the offer submitted badge (based on your screenshot)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFC8E6C9), // Light green background
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Offer submitted',
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                        color: Colors.green.shade800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Displaying the price info
                  Row(
                    children: [
                      Text(
                        'Offer submitted ',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          '${offer.offeredPrice}',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 8),

                  CountdownTimer(
                    initialDuration: offer.originalDuration,
                    backgroundColor: const Color(0xFF00BFA5),
                  ),
                ],
              ),
            ),
            // Moved Submission Time to top right, simplified location
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  DateFormat('d MMM, h:mm a').format(offer.submissionTime),
                  style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey),
                ),
                // Location is not clearly displayed in the screenshot, omitted or simplified.
              ],
            ),
          ],
        ),
      ),
    );
  }
}

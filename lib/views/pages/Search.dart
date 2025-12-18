import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_app/views/pages/Offer_Page.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:insta_app/views/pages/Wazomart.works.dart';
import 'dart:async';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController searchController = TextEditingController();
  String selectedFilter = 'All';
  String searchQuery = '';

  final List<Map<String, dynamic>> allProperties = [
    {
      'id': 1,
      'title': 'Dell Latitude 7420',
      'price': '₦550000',
      'location': 'Gbagada Phase II/bariga',
      'image': 'assets/images/IMG_2716.jpg',
      'images': [
        'assets/images/IMG_2716.jpg',
        'assets/images/IMG_2717.jpg',
        'assets/images/IMG_2718.jpg',
        'assets/images/IMG_2719.jpg',
      ],
      'type': 'Computers',
      'description':
          'The Dell Latitude 7420 is a professional business laptop that delivers exceptional performance and reliability for demanding work environments.',
      'category': 'Laptops',
      'condition': 'Like new',
      'deliveryOptions': ['Bike delivery', 'Pickup'],
      'itemLocation': 'Gbagada/Phase II, Lagos',
    },
    {
      'id': 2,
      'title': 'Black Bluetooth',
      'price': '₦50,000',
      'location': 'Victoria Island',
      'image': 'assets/images/IMG_2780.jpg',
      'images': ['assets/images/IMG_2780.jpg', 'assets/images/IMG_2781.jpg'],
      'type': 'Electronics',
      'description':
          'The Soundcore 3 is a portable Bluetooth speaker that delivers high-quality stereo sound, deep bass, and long battery life for wireless music playback.',
      'category': 'Electronics',
      'condition': 'Like new',
      'deliveryOptions': ['Bike delivery', 'Pickup'],
      'itemLocation': 'Ajah/Sangotedo, Lagos',
    },
    {
      'id': 3,
      'title': 'MacBook Pro 2020',
      'price': '₦850000',
      'location': 'Ikeja GRA',
      'image': 'assets/images/IMG_2782.jpg',
      'images': [
        'assets/images/IMG_2782.jpg',
        'assets/images/IMG_2783.jpg',
        'assets/images/IMG_2785.jpg',
      ],
      'type': 'Computers',
      'description':
          'Apple MacBook Pro 2020 model with M1 chip, delivering incredible performance and battery life for professional creative work.',
      'category': 'Laptops',
      'condition': 'Excellent',
      'deliveryOptions': ['Bike delivery', 'Pickup'],
      'itemLocation': 'Ikeja/GRA, Lagos',
    },
    {
      'id': 4,
      'title': 'Samsung Galaxy S21',
      'price': '₦280000',
      'location': 'Lekki Phase 1',
      'image': 'assets/images/IMG_2789.jpg',
      'images': ['assets/images/IMG_2789.jpg', 'assets/images/IMG_2788.jpg'],
      'type': 'Phone',
      'description':
          'Samsung Galaxy S21 with stunning display and powerful camera system for capturing every moment.',
      'category': 'Smartphones',
      'condition': 'Good',
      'deliveryOptions': ['Bike delivery', 'Pickup'],
      'itemLocation': 'Lekki/Phase 1, Lagos',
    },
    {
      'id': 5,
      'title': 'Microwave Oven',
      'price': '₦45000',
      'location': 'Surulere',
      'image': 'assets/images/IMG_2790.jpg',
      'images': [
        'assets/images/IMG_2790.jpg',
        'assets/images/IMG_2791.jpg',
        'assets/images/IMG_2792.jpg',
      ],
      'type': 'Kitchen',
      'description':
          'High-quality microwave oven with multiple cooking modes and timer functions.',
      'category': 'Kitchen Appliances',
      'condition': 'Like new',
      'deliveryOptions': ['Bike delivery', 'Pickup'],
      'itemLocation': 'Surulere, Lagos',
    },
    {
      'id': 6,
      'title': 'Acer Swift 3',
      'price': '₦380000',
      'location': 'Maryland',
      'image': 'assets/images/IMG_2982.jpg',
      'images': [
        'assets/images/IMG_2982.jpg',
        'assets/images/IMG_2983.jpg',
        'assets/images/IMG_2985.jpg',
      ],
      'type': 'Computers',
      'description':
          'Acer Swift 3 is a lightweight and affordable laptop perfect for students and everyday computing tasks.',
      'category': 'Laptops',
      'condition': 'Good',
      'deliveryOptions': ['Bike delivery', 'Pickup'],
      'itemLocation': 'Maryland, Lagos',
    },
    {
      'title': 'Dell XPS 13',
      'price': '₦890000',
      'location': 'Ajah',
      'image': 'assets/images/IMG_2986.jpg',
      'images': [
        'assets/images/IMG_2986.jpg',
        'assets/images/IMG_2987.jpg',
        'assets/images/IMG_2988.jpg',
      ],
      'type': 'Computers',
      'description':
          'Dell XPS 13 features stunning InfinityEdge display and premium build quality in an ultra-compact design.',
      'category': 'Laptops',
      'condition': 'Excellent',
      'deliveryOptions': ['Bike delivery', 'Pickup'],
      'itemLocation': 'Ajah, Lagos',
    },
    {
      'title': 'HP Pavilion 15',
      'price': '₦450000',
      'location': 'Festac',
      'image': 'assets/images/IMG_2989.jpg',
      'images': [
        'assets/images/IMG_2989.jpg',
        'assets/images/IMG_2990.jpg',
        'assets/images/IMG_2991.jpg',
      ],
      'type': 'Electronics',
      'description':
          'HP Pavilion 15 offers reliable performance and generous screen size for work and entertainment.',
      'category': 'Laptops',
      'condition': 'Good',
      'deliveryOptions': ['Bike delivery', 'Pickup'],
      'itemLocation': 'Festac, Lagos',
    },
    {
      'title': 'HP Pavilion 15',
      'price': '₦450000',
      'location': 'Festac',
      'image': 'assets/images/IMG_2992.jpg',
      'images': [
        'assets/images/IMG_2992.jpg',
        'assets/images/IMG_2993.jpg',
        'assets/images/IMG_2994.jpg',
      ],
      'type': 'Electronics',
      'description':
          'HP Pavilion 15 offers reliable performance and generous screen size for work and entertainment.',
      'category': 'Laptops',
      'condition': 'Good',
      'deliveryOptions': ['Bike delivery', 'Pickup'],
      'itemLocation': 'Festac, Lagos',
    },
    {
      'title': 'HP Pavilion 15',
      'price': '₦450000',
      'location': 'Festac',
      'image': 'assets/images/IMG_2996.jpg',
      'images': [
        'assets/images/IMG_2996.jpg',
        'assets/images/IMG_2999.PNG',
        'assets/images/IMG_2998.jpg',
      ],
      'type': 'Phone',
      'description':
          'HP Pavilion 15 offers reliable performance and generous screen size for work and entertainment.',
      'category': 'Laptops',
      'condition': 'Good',
      'deliveryOptions': ['Bike delivery', 'Pickup'],
      'itemLocation': 'Festac, Lagos',
    },
  ];

  List<Map<String, dynamic>> getFilteredProperties() {
    List<Map<String, dynamic>> filtered = allProperties;

    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((property) {
        return property['title'].toLowerCase().contains(
              searchQuery.toLowerCase(),
            ) ||
            property['type'].toLowerCase().contains(searchQuery.toLowerCase());
      }).toList();
    }

    if (selectedFilter != 'All') {
      filtered = filtered.where((property) {
        return property['type'] == selectedFilter;
      }).toList();
    }

    return filtered;
  }

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

  void _showCustomSideSheet(BuildContext context, Map<String, dynamic> product) {
    final List<String> images = product.containsKey('images')
        ? List<String>.from(product['images'])
        : [product['image']];
    final Duration duration = product['duration'] ?? const Duration(hours: 24);

    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: "Side side sheetp",
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        final width = MediaQuery.of(context).size.width;
        final widthFactor = width > 800 ? 0.5 : 1.0;
        return Align(
          alignment: Alignment.topRight,
          child: FractionallySizedBox(
            widthFactor: widthFactor,
            heightFactor: 1.0,
            child: Material(
              child: Scaffold(
                backgroundColor: Colors.white,
                body: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: 500,
                        child: Stack(
                          children: [
                            PageView.builder(
                              itemCount: images.length,
                              itemBuilder: (context, index) {
                                return Image.asset(
                                  images[index],
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                            Positioned(
                              top: 50,
                              left: 0,
                              right: 0,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconButton(
                                      onPressed: () => Navigator.pop(context),
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.white,
                                      ),
                                      icon: const Icon(
                                        Icons.arrow_back_ios,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            try {
                                              final result = await Share.share(
                                                '${product['title']}\n${product['price']}\nLocation: ${product['location']}\n\nCheck out this item!',
                                              );

                                              print(
                                                'Share result: ${result.status}',
                                              );
                                            } catch (e) {
                                              print('Error sharing: $e');
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Error sharing: $e',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          style: IconButton.styleFrom(
                                            backgroundColor: Colors.white,
                                          ),
                                          icon: const Icon(
                                            Icons.ios_share,
                                            color: Colors.black,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                              backgroundColor: Colors.white,
                                              isScrollControlled: true,
                                              context: context,
                                              builder: (context) {
                                                return SizedBox(
                                                  height: 400,
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        margin:
                                                            const EdgeInsets.only(
                                                              top: 8,
                                                              bottom: 12,
                                                            ),
                                                        width: 40,
                                                        height: 4,
                                                        decoration: BoxDecoration(
                                                          color:
                                                              Colors.grey[400],
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                10,
                                                              ),
                                                        ),
                                                      ),

                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.symmetric(
                                                              horizontal: 16.0,
                                                            ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              'More options',
                                                              style: GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                                fontSize: 18,
                                                              ),
                                                            ),
                                                            IconButton(
                                                              icon: const Icon(
                                                                Icons.close,
                                                              ),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                  context,
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ),

                                                      const SizedBox(
                                                        height: 20,
                                                      ),

                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.all(
                                                              16.0,
                                                            ),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.all(
                                                                17.0,
                                                              ),
                                                          child: Column(
                                                            children: [
                                                              InkWell(
                                                                onTap: () {},
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          50,
                                                                      width: 50,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              50.0,
                                                                            ),
                                                                        color: Color(
                                                                          0xFF14B8A6,
                                                                        ),
                                                                      ),
                                                                      child: Icon(
                                                                        Icons
                                                                            .flag,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 30,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          'Report this item',
                                                                          style: GoogleFonts.poppins(
                                                                            fontWeight:
                                                                                FontWeight.w900,
                                                                            fontSize:
                                                                                17,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Price gouging,prohibited item etc',
                                                                          style: GoogleFonts.poppins(
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 30,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (
                                                                            context,
                                                                          ) {
                                                                            return Wazomart();
                                                                          },
                                                                    ),
                                                                  );
                                                                },
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          50,
                                                                      width: 50,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              50.0,
                                                                            ),
                                                                        color: Color(
                                                                          0xFF14B8A6,
                                                                        ),
                                                                      ),
                                                                      child: Icon(
                                                                        LucideIcons
                                                                            .shieldAlert,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 30,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          'How it works',
                                                                          style: GoogleFonts.poppins(
                                                                            fontWeight:
                                                                                FontWeight.w900,
                                                                            fontSize:
                                                                                17,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Learn how to buy or sell on\n WazoMart',
                                                                          style: GoogleFonts.poppins(
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                height: 40,
                                                              ),
                                                              InkWell(
                                                                onTap: () {},
                                                                child: Row(
                                                                  children: [
                                                                    Container(
                                                                      height:
                                                                          50,
                                                                      width: 50,
                                                                      decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                              50.0,
                                                                            ),
                                                                        color: Color(
                                                                          0xFF14B8A6,
                                                                        ),
                                                                      ),
                                                                      child: Icon(
                                                                        Icons
                                                                            .flag,
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width: 30,
                                                                    ),
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          'Contact support ',
                                                                          style: GoogleFonts.poppins(
                                                                            fontWeight:
                                                                                FontWeight.w900,
                                                                            fontSize:
                                                                                17,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          'Need help with this items',
                                                                          style: GoogleFonts.poppins(
                                                                            color:
                                                                                Colors.grey,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          style: IconButton.styleFrom(
                                            backgroundColor: Colors.white,
                                          ),
                                          icon: const Icon(
                                            Icons.more_horiz,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              top: 120,
                              left: 16,
                              child: SearchCountdownTimer(
                                initialDuration: duration,
                                backgroundColor: Colors.teal,
                              ),
                            ),
                            Positioned(
                              bottom: 16,
                              left: 0,
                              right: 0,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  images.length,
                                  (index) => Container(
                                    width: 8,
                                    height: 8,
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 4,
                                    ),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white.withOpacity(0.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Container(
                        color: Colors.white,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Text(
                                    product['title'],
                                    style: GoogleFonts.montserrat(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      product['price'],
                                      style: GoogleFonts.montserrat(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Selling price',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 12,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          padding: const EdgeInsets.all(4.0),
                          child: TabBar(
                            controller: _tabController,
                            labelColor: Colors.white,
                            unselectedLabelColor: Colors.grey,
                            indicator: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            indicatorSize: TabBarIndicatorSize.tab,
                            dividerColor: Colors.transparent,
                            tabs: [
                              Tab(
                                child: Text(
                                  'Details',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Q&A',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  'Seller',
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: SizedBox(
                        height: 800,
                        child: TabBarView(
                          controller: _tabController,
                          children: [
                            SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFF5F5),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            '🔥',
                                            style: TextStyle(fontSize: 24),
                                          ),
                                          SizedBox(width: 12),
                                          Expanded(
                                            child: Text(
                                              'View your offer history',
                                              style: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 24),

                                    // Description Section
                                    Text(
                                      'Description',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 20,
                                      ),
                                    ),
                                    SizedBox(height: 12),
                                    Text(
                                      product['description'] ??
                                          'No description available',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        height: 1.5,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    SizedBox(height: 24),

                                    // Category Section
                                    Text(
                                      'Category',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF5F5F5),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        product['category'] ?? 'General',
                                        style: GoogleFonts.montserrat(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 24),

                                    // Condition Section
                                    Row(
                                      children: [
                                        Text(
                                          'Condition',
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.info_outline,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      product['condition'] ?? 'Used',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 24),

                                    // Delivery Options
                                    Row(
                                      children: [
                                        Text(
                                          'Delivery & Pickup Options',
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w800,
                                            fontSize: 16,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Icon(
                                          Icons.info_outline,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 12),
                                    Row(
                                      children:
                                          (product['deliveryOptions']
                                                      as List<dynamic>? ??
                                                  ['Pickup'])
                                              .map<Widget>((option) {
                                                return Container(
                                                  margin: EdgeInsets.only(
                                                    right: 12,
                                                  ),
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 16,
                                                    vertical: 10,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF5F5F5),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        option ==
                                                                'Bike delivery'
                                                            ? Icons.pedal_bike
                                                            : Icons
                                                                  .person_pin_circle,
                                                        size: 18,
                                                      ),
                                                      SizedBox(width: 8),
                                                      Text(
                                                        option,
                                                        style:
                                                            GoogleFonts.montserrat(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              fontSize: 14,
                                                            ),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              })
                                              .toList(),
                                    ),
                                    SizedBox(height: 24),

                                    // Item Location
                                    Text(
                                      'Item location',
                                      style: GoogleFonts.montserrat(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          product['itemLocation'] ??
                                              product['location'] ??
                                              'Lagos',
                                          style: GoogleFonts.montserrat(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        OutlinedButton(
                                          onPressed: () {},
                                          style: OutlinedButton.styleFrom(
                                            side: BorderSide(
                                              color: Colors.teal,
                                              width: 2,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 10,
                                            ),
                                          ),
                                          child: Text(
                                            'Get Estimate',
                                            style: GoogleFonts.montserrat(
                                              color: Colors.teal,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 24),

                                    Container(
                                      padding: EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFF8F9FA),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color: Color(0xFFE0E0E0),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                              color: Colors.blue,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Icon(
                                              Icons.shield,
                                              color: Colors.white,
                                              size: 30,
                                            ),
                                          ),
                                          SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Buyer protection included',
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                SizedBox(height: 4),
                                                Text(
                                                  'Receive your item as described or your money back on eligible orders',
                                                  style: GoogleFonts.montserrat(
                                                    fontSize: 12,
                                                    color: Colors.grey[700],
                                                  ),
                                                ),
                                                SizedBox(height: 8),
                                                TextButton(
                                                  onPressed: () {},
                                                  child: Text(
                                                    'Learn more',
                                                    style:
                                                        GoogleFonts.montserrat(
                                                          fontSize: 12,
                                                          color: Colors.teal,
                                                          fontWeight:
                                                              FontWeight.bold,
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

                            // Q&A TAB
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.question_answer_outlined,
                                      size: 80,
                                      color: Colors.grey[300],
                                    ),
                                    SizedBox(height: 1),
                                    Text(
                                      'No questions yet',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Be the first to ask a question',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.store_outlined,
                                      size: 80,
                                      color: Colors.grey[300],
                                    ),
                                    SizedBox(height: 16),
                                    Text(
                                      'Seller information',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'Coming soon',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 14,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                bottomNavigationBar: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 15.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),

                  child: ElevatedButton(
                    onPressed: () {
                      // 1. Extract and clean price data
                      String priceStr = product['price']
                          .replaceAll('₦', '')
                          .replaceAll(',', '');
                      double sellingPriceValue = double.tryParse(priceStr) ?? 0;

                      // 2. Calculate minimum offer (70% of selling price)
                      double minimumOffer = sellingPriceValue * 0.70;

                      // 3. Extract the new required data from the product map
                      final String imageUrl =
                          images[0]; // Assuming first image is the main one
                      final String location = product['location'];
                      final Duration currentDuration = duration;

                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0),
                          ),
                        ),
                        builder: (context) {
                          return FractionallySizedBox(
                            heightFactor: 0.87,
                            child: Column(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  height: 5,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                Expanded(
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(25.0),
                                      topRight: Radius.circular(25.0),
                                    ),
                                    child: OfferPage(
                                      sellingPrice: product['price'],
                                      productTitle: product['title'],
                                      minimumOffer: minimumOffer,

                                      imageUrl: imageUrl,
                                      location: location,
                                      currentDuration: currentDuration,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00BFA5),
                      minimumSize: const Size(double.infinity, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'Make offer',
                      style: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(anim1),
          child: child,
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredProperties = getFilteredProperties();

    return Scaffold(
      appBar: AppBar(title: Text('Search Properties'), centerTitle: false),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: SingleChildScrollView(
              child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: searchController,
                      onChanged: (value) {
                        setState(() {
                          searchQuery = value;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Search products...',
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: searchQuery.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    searchController.clear();
                                    searchQuery = '';
                                  });
                                },
                              )
                            : null,
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterChip(
                          label: Text('All'),
                          selected: selectedFilter == 'All',
                          onSelected: (selected) {
                            setState(() {
                              selectedFilter = 'All';
                            });
                          },
                          selectedColor: Colors.black,
                          labelStyle: TextStyle(
                            color: selectedFilter == 'All'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                        FilterChip(
                          label: Text('Phone'),
                          selected: selectedFilter == 'Phone',
                          onSelected: (selected) {
                            setState(() {
                              selectedFilter = 'Phone';
                            });
                          },
                          selectedColor: Colors.black,
                          labelStyle: TextStyle(
                            color: selectedFilter == 'Phone'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                        FilterChip(
                          label: Text('Electronics'),
                          selected: selectedFilter == 'Electronics',
                          onSelected: (selected) {
                            setState(() {
                              selectedFilter = 'Electronics';
                            });
                          },
                          selectedColor: Colors.black,
                          labelStyle: TextStyle(
                            color: selectedFilter == 'Electronics'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                        FilterChip(
                          label: Text('Computers'),
                          selected: selectedFilter == 'Computers',
                          onSelected: (selected) {
                            setState(() {
                              selectedFilter = 'Computers';
                            });
                          },
                          selectedColor: Colors.black,
                          labelStyle: TextStyle(
                            color: selectedFilter == 'Computers'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                        FilterChip(
                          label: Text('Kitchen'),
                          selected: selectedFilter == 'Kitchen',
                          onSelected: (selected) {
                            setState(() {
                              selectedFilter = 'Kitchen';
                            });
                          },
                          selectedColor: Colors.black,
                          labelStyle: TextStyle(
                            color: selectedFilter == 'Kitchen'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                        SizedBox(width: 8),
                        FilterChip(
                          label: Text('Men Fashion'),
                          selected: selectedFilter == 'Wave',
                          onSelected: (selected) {
                            setState(() {
                              selectedFilter = 'Wave';
                            });
                          },
                          selectedColor: Colors.black,
                          labelStyle: TextStyle(
                            color: selectedFilter == 'Wave'
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // Results Section
            filteredProperties.isEmpty
                ? Container(
                    height: 400,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search_off, size: 80, color: Colors.grey),
                          SizedBox(height: 16),
                          Text(
                            'No products found',
                            style: TextStyle(fontSize: 18, color: Colors.grey),
                          ),
                          Text(
                            'Try adjusting your search or filters',
                            style: TextStyle(fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          '${filteredProperties.length} products found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),

                      // Grid View - Responsive
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                            return GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: filteredProperties.length,
                              itemBuilder: (context, index) {
                                return buildProductCard(filteredProperties[index]);
                              },
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
          ],
        ),
      ),
      ),
      ),
      ),
    );
  }

  Widget buildProductCard(Map<String, dynamic> product) {
    return InkWell(
      onTap: () {
        _showCustomSideSheet(context, product);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.asset(
                  product['image'],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    product['title'],
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4),
                  Text(
                    product['location'],
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 8),
                  Text(
                    product['price'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
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
}

class SearchCountdownTimer extends StatefulWidget {
  final Duration initialDuration;
  final Color backgroundColor;

  const SearchCountdownTimer({
    Key? key,
    required this.initialDuration,
    this.backgroundColor = Colors.teal,
  }) : super(key: key);

  @override
  State<SearchCountdownTimer> createState() => _SearchCountdownTimerState();
}

class _SearchCountdownTimerState extends State<SearchCountdownTimer> {
  late Timer _timer;
  late Duration _duration;

  @override
  void initState() {
    super.initState();
    _duration = widget.initialDuration;
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      setState(() {
        const int reduceSecondsBy = 1;
        final seconds = _duration.inSeconds - reduceSecondsBy;
        if (seconds < 0) {
          _timer.cancel();
          _duration = Duration.zero;
        } else {
          _duration = Duration(seconds: seconds);
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final days = twoDigits(duration.inDays);
    final hours = twoDigits(duration.inHours.remainder(24));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '${days}d:${hours}h:${minutes}m:${seconds}s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        formatDuration(_duration),
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_app/views/pages/Offer_Page.dart';

import 'package:insta_app/views/pages/Wazomart.works.dart';

import 'dart:async';
import 'package:share_plus/share_plus.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:insta_app/views/pages/Onboradingpage1.dart';

final List<String> imageAssets = [
  'assets/images/IMG_2716.jpg',
  'assets/images/IMG_2717.jpg',
  'assets/images/IMG_2718.jpg',
  'assets/images/IMG_2719.jpg',
];
final List<String> imageAssets2 = [
  'assets/images/IMG_2780.jpg',
  'assets/images/IMG_2781.jpg',
];
final List<String> imageAssets3 = [
  'assets/images/IMG_2782.jpg',
  'assets/images/IMG_2783.jpg',
  'assets/images/IMG_2785.jpg',
];
final List<String> imageAssets4 = [
  'assets/images/IMG_2789.jpg',
  'assets/images/IMG_2788.jpg',
];
final List<String> imageAssets5 = [
  'assets/images/IMG_2790.jpg',
  'assets/images/IMG_2791.jpg',
  'assets/images/IMG_2792.jpg',
];
final List<String> imageAssets6 = [
  'assets/images/IMG_2978.jpg',
  'assets/images/IMG_2979.jpg',
  'assets/images/IMG_2980.jpg',
];
final List<String> imageAssets7 = [
  'assets/images/IMG_2982.jpg',
  'assets/images/IMG_2983.jpg',
  'assets/images/IMG_2985.jpg',
];
final List<String> imageAssets8 = [
  'assets/images/IMG_2986.jpg',
  'assets/images/IMG_2987.jpg',
  'assets/images/IMG_2988.jpg',
];
final List<String> imageAssets9 = [
  'assets/images/IMG_2989.jpg',
  'assets/images/IMG_2990.jpg',
  'assets/images/IMG_2991.jpg',
];
final List<String> imageAssets10 = [
  'assets/images/IMG_2992.jpg',
  'assets/images/IMG_2993.jpg',
  'assets/images/IMG_2994.jpg',
];
final List<String> imageAssets11 = [
  'assets/images/IMG_2996.jpg',
  'assets/images/IMG_2999.PNG',
  'assets/images/IMG_2998.jpg',
];
final List<Map<String, dynamic>> productData = [
  {
    'title': 'Dell Latitude 7420',
    'price': '₦550000',
    'location': 'Gbagada Phase II/bariga',
    'images': imageAssets,
    'duration': Duration(days: 9, hours: 9, minutes: 57, seconds: 59),
    'description':
        'The Dell Latitude 7420 is a professional business laptop that delivers exceptional performance and reliability for demanding work environments.',
    'category': 'Laptops',
    'condition': 'Like new',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Gbagada/Phase II, Lagos',
  },
  {
    'title': 'Black Bluetooth',
    'price': '₦50,000',
    'location': 'Victoria Island',
    'images': imageAssets2,
    'duration': Duration(days: 5, hours: 12, minutes: 30, seconds: 45),
    'description':
        'The Soundcore 3 is a portable Bluetooth speaker that delivers high-quality stereo sound, deep bass, and long battery life for wireless music playback.',
    'category': 'Electronics',
    'condition': 'Like new',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Ajah/Sangotedo, Lagos',
  },
  {
    'title': 'MacBook Pro 2020',
    'price': '₦850000',
    'location': 'Ikeja GRA',
    'images': imageAssets3,
    'duration': Duration(days: 3, hours: 8, minutes: 15, seconds: 20),
    'description':
        'Apple MacBook Pro 2020 model with M1 chip, delivering incredible performance and battery life for professional creative work.',
    'category': 'Laptops',
    'condition': 'Excellent',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Ikeja/GRA, Lagos',
  },
  {
    'title': 'Lenovo ThinkPad X1',
    'price': '₦680000',
    'location': 'Lekki Phase 1',
    'images': imageAssets4,
    'duration': Duration(days: 7, hours: 15, minutes: 45, seconds: 30),
    'description':
        'Lenovo ThinkPad X1 Carbon is an ultralight business laptop with premium build quality and enterprise-grade security features.',
    'category': 'Laptops',
    'condition': 'Good',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Lekki/Phase 1, Lagos',
  },
  {
    'title': 'Asus ROG Gaming',
    'price': '₦920000',
    'location': 'Surulere',
    'images': imageAssets5,
    'duration': Duration(days: 2, hours: 18, minutes: 20, seconds: 10),
    'description':
        'Asus ROG gaming laptop with powerful graphics card and high refresh rate display for immersive gaming experience.',
    'category': 'Gaming Laptops',
    'condition': 'Like new',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Surulere, Lagos',
  },
  {
    'title': 'Surface Laptop 4',
    'price': '₦750000',
    'location': 'Yaba',
    'images': imageAssets6,
    'duration': Duration(days: 4, hours: 6, minutes: 40, seconds: 55),
    'description':
        'Microsoft Surface Laptop 4 combines elegant design with powerful performance for productivity and entertainment.',
    'category': 'Laptops',
    'condition': 'Like new',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Yaba, Lagos',
  },
  {
    'title': 'Acer Swift 3',
    'price': '₦380000',
    'location': 'Maryland',
    'images': imageAssets7,
    'duration': Duration(days: 1, hours: 22, minutes: 10, seconds: 5),
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
    'images': imageAssets8,
    'duration': Duration(days: 6, hours: 14, minutes: 25, seconds: 40),
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
    'images': imageAssets9,
    'duration': Duration(days: 8, hours: 10, minutes: 35, seconds: 15),
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
    'images': imageAssets10,
    'duration': Duration(days: 8, hours: 10, minutes: 35, seconds: 15),
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
    'images': imageAssets11,
    'duration': Duration(days: 8, hours: 10, minutes: 35, seconds: 15),
    'description':
        'HP Pavilion 15 offers reliable performance and generous screen size for work and entertainment.',
    'category': 'Laptops',
    'condition': 'Good',
    'deliveryOptions': ['Bike delivery', 'Pickup'],
    'itemLocation': 'Festac, Lagos',
  },
];

class CountdownTimer extends StatefulWidget {
  final Duration initialDuration;
  final Color backgroundColor;

  const CountdownTimer({
    Key? key,
    required this.initialDuration,
    this.backgroundColor = Colors.teal,
  }) : super(key: key);

  @override
  State<CountdownTimer> createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
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

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  static String currentView = "flow"; // flow, split, stack

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

  void _showViewOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Text(
                'View Options',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.view_stream),
                title: const Text('Flow View'),
                trailing: currentView == 'flow'
                    ? const Icon(Icons.check, color: Colors.teal)
                    : null,
                onTap: () {
                  setState(() => currentView = 'flow');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.grid_view),
                title: const Text('Split View'),
                trailing: currentView == 'split'
                    ? const Icon(Icons.check, color: Colors.teal)
                    : null,
                onTap: () {
                  setState(() => currentView = 'split');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.view_carousel),
                title: const Text('Stack View'),
                trailing: currentView == 'stack'
                    ? const Icon(Icons.check, color: Colors.teal)
                    : null,
                onTap: () {
                  setState(() => currentView = 'stack');
                  Navigator.pop(context);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () async {
                  Navigator.pop(context); // Close sheet
                  // Show loading
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) => const Center(
                      child: CircularProgressIndicator(color: Colors.teal),
                    ),
                  );
                  
                  try {
                    await FirebaseAuth.instance.signOut();
                    if (mounted) {
                      Navigator.pop(context); 
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const OnboardingPage1(),
                        ),
                        (route) => false,
                      );
                    }
                  } catch (e) {
                    if (mounted) {
                      Navigator.pop(context); // Close loading
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error signing out: $e')),
                      );
                    }
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showCustomSideSheet(
    BuildContext context,
    Map<String, dynamic> product,
  ) {
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
                              itemCount: product['images'].length,
                              itemBuilder: (context, index) {
                                return Image.asset(
                                  product['images'][index],
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
                              child: CountdownTimer(
                                initialDuration: product['duration'],
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
                                  product['images'].length,
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
                          product['images'][0]; // Assuming first image is the main one
                      final String location = product['location'];
                      final Duration currentDuration = product['duration'];

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

  Widget _buildFlowView() {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 800),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: const Color(0xFFE0F7FA),
                      ),
                      width: double.infinity,
                      height: 238,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Join shop lovers community ',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF4A7C7A),
                                  height: 1.3,
                                ),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Share your daily shopping cart,\nconnect with others ',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color(0xFF6B9B98),
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    foregroundColor: const Color(0xFF4A7C7A),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 24,
                                      vertical: 12,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Join now!',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.0),
                          child: Image.asset(
                            'assets/images/991.png',
                            width: 200.0,
                            height: 500.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ...List.generate(productData.length, (index) {
            final product = productData[index];
            final PageController productPageController = PageController(
              initialPage: 1000,
            );
            int productCurrentPage = 1000;

            return StatefulBuilder(
              builder: (context, setState) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18.0,
                    vertical: 10.0,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 500,
                    child: Stack(
                      children: [
                        PageView.builder(
                          controller: productPageController,
                          itemCount: 99999,
                          onPageChanged: (pageIndex) {
                            setState(() {
                              productCurrentPage = pageIndex;
                            });
                          },
                          itemBuilder: (context, pageIndex) {
                            final contentIndex =
                                pageIndex % product['images'].length;
                            final assetPath = product['images'][contentIndex];
                            return InkWell(
                              onTap: () =>
                                  _showCustomSideSheet(context, product),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.black,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: Image.asset(
                                    assetPath,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        Positioned(
                          top: 20,
                          left: 20,
                          right: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CountdownTimer(
                                initialDuration: product['duration'],
                                backgroundColor: Colors.teal,
                              ),
                              Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                ),
                                child: IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      backgroundColor: Colors.transparent,
                                      isScrollControlled: true,
                                      builder: (context) {
                                        return Container(
                                          margin: EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(24),
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              // Handle bar
                                              Container(
                                                margin: EdgeInsets.only(
                                                  top: 12,
                                                  bottom: 20,
                                                ),
                                                width: 40,
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: Colors.grey[300],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        10,
                                                      ),
                                                ),
                                              ),

                                              // Close button
                                              Align(
                                                alignment: Alignment.topRight,
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                    right: 16,
                                                  ),
                                                  child: IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon: Icon(
                                                      Icons.close,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // Icon
                                              Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        50,
                                                      ),
                                                  color: Color(0xFFD4F4E8),
                                                ),
                                                child: Icon(
                                                  Icons
                                                      .directions_walk_rounded,
                                                  size: 50,
                                                  color: Color(0xFF4CAF50),
                                                ),
                                              ),

                                              SizedBox(height: 24),

                                              // Title
                                              Text(
                                                'Pickup Available',
                                                style: GoogleFonts.poppins(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black87,
                                                ),
                                              ),

                                              SizedBox(height: 16),

                                              // Description
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 32,
                                                ),
                                                child: Text(
                                                  'This item can be picked up from sellers location. The seller\'s contact and location are displayed after payment.',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    color: Colors.grey[600],
                                                    height: 1.5,
                                                  ),
                                                ),
                                              ),

                                              SizedBox(height: 32),

                                              // Button
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  bottom: 20,
                                                ),
                                                child: SizedBox(
                                                  width: double.infinity,
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                          Colors.black,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                            vertical: 16,
                                                          ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                      30,
                                                                    ),
                                                          ),
                                                    ),
                                                    child: Text(
                                                      'Got it',
                                                      style: GoogleFonts.poppins(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
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
                                  icon: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          bottom: 120,
                          left: 0,
                          right: 0,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              product['images'].length,
                              (dotIndex) => Container(
                                width: 8,
                                height: 8,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 4,
                                ),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      (productCurrentPage %
                                              product['images'].length) ==
                                          dotIndex
                                          ? Colors.white
                                          : Colors.white.withOpacity(0.5),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 5,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          product['title'],
                                          style: const TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        Text(
                                          product['price'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 1),
                                    Row(
                                      children: [
                                        Text(
                                          product['location'],
                                          style: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const Spacer(),
                                        const Text('Selling Price'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
        ],
      ),
        ),
      ),
    );
  }

  Widget _buildSplitView() {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth > 900
            ? 4
            : constraints.maxWidth > 600
                ? 3
                : 2;
        return GridView.builder(
          padding: const EdgeInsets.all(10),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            childAspectRatio: 0.7,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: productData.length,
          itemBuilder: (context, index) {
            final product = productData[index];
            return InkWell(
              onTap: () => _showCustomSideSheet(context, product),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        child: Image.asset(
                          product['images'][0],
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['title'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            product['price'],
                            style: GoogleFonts.montserrat(
                              color: Colors.teal,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildStackView() {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      itemCount: productData.length,
      itemBuilder: (context, index) {
        final product = productData[index];
        return Stack(
          fit: StackFit.expand,
          children: [
            StackItemSlideshow(
              images: List<String>.from(product['images']),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'],
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product['price'],
                    style: GoogleFonts.montserrat(
                      color: Colors.tealAccent,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _showCustomSideSheet(context, product),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                    ),
                    child: const Text('View Details'),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Container(
            width: 98,
            height: 38,
            decoration: BoxDecoration(
              color: Colors.teal,
              borderRadius: BorderRadius.circular(40.0),
            ),
            child: Center(
              child: Text(
                'WazoMart',
                style: GoogleFonts.urbanist(
                  fontWeight: FontWeight.w900,
                  fontSize: 17,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.tune, color: Colors.black),
            onPressed: () => _showViewOptions(context),
          ),
        ],
      ),
      body: Builder(
        builder: (context) {
          switch (currentView) {
            case "split":
              return _buildSplitView();
            case "stack":
              return _buildStackView();
            case "flow":
            default:
              return _buildFlowView();
          }
        },
      ),
    );
  }
}

class StackItemSlideshow extends StatefulWidget {
  final List<String> images;
  const StackItemSlideshow({super.key, required this.images});

  @override
  State<StackItemSlideshow> createState() => _StackItemSlideshowState();
}

class _StackItemSlideshowState extends State<StackItemSlideshow>
    with TickerProviderStateMixin {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;
  late AnimationController _zoomController;
  late Animation<double> _zoomAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    
    // Initialize zoom controller
    _zoomController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4), // Slightly longer than slide duration
    );

    _zoomAnimation = Tween<double>(begin: 1.1, end: 1.0).animate(
      CurvedAnimation(parent: _zoomController, curve: Curves.easeOut),
    );

    _startSlideshow();
    _zoomController.forward();
  }

  void _startSlideshow() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (!mounted) return;
      if (_currentPage < widget.images.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      if (_pageController.hasClients) {
        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
        
        // Reset and restart zoom animation on page change
        _zoomController.reset();
        _zoomController.forward();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    _zoomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.images.length,
      physics: const NeverScrollableScrollPhysics(), // Disable manual scrolling to keep sync
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _zoomAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _zoomAnimation.value,
              child: child,
            );
          },
          child: Image.asset(
            widget.images[index],
            fit: BoxFit.cover,
          ),
        );
      },
    );
  }
}

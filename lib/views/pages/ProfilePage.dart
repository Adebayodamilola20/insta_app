import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:insta_app/shared/provider/Userprovider.dart';
import 'package:insta_app/views/pages/ContactPage.dart';
import 'package:insta_app/views/pages/SigninPage.dart';
import 'package:insta_app/views/pages/editingusername.dart';
import 'package:insta_app/views/pages/imagePicker.dart';
import 'package:insta_app/views/pages/sharefeedback.dart';
import 'package:provider/provider.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:intl/intl.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  bool isSwiched = false;
  bool isSwiched2 = false;
  bool isSwiched3 = false;
  Widget _buildDialogInfoContainer(
    BuildContext context, {
    required String label,
    required String value,
    required Userprovider userProvider,
  }) {
    String displayValue = value;
    if (label == 'Phone number' && value.isEmpty) {
      displayValue = 'Not provided';
    } else if (value.isEmpty && !userProvider.isLoading) {
      displayValue = 'N/A';
    } else if (userProvider.isLoading) {
      displayValue = 'Loading...';
    }

    return Container(
      width: double.infinity,
      height: 68,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(
          color: const Color.fromARGB(217, 235, 235, 235),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 133, 127, 127),
              ),
            ),
            Text(
              displayValue,
              style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w900,
                fontSize: 17,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        actions: [
          OutlinedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Sharefeedback();
                  },
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              backgroundColor: Colors.white,
              side: const BorderSide(color: Colors.teal, width: 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              minimumSize: const Size(0, 0),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text(
              'Give feedback',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w900,
                color: Colors.teal,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: InkWell(
                  onTap: () {
                    showGeneralDialog(
                      context: context,
                      transitionDuration: const Duration(milliseconds: 300),
                      barrierDismissible: true,
                      barrierLabel: 'Close',
                      barrierColor: Colors.black.withOpacity(0.4),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const _ProfileDialogContent();
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      border: Border.all(
                        color: const Color.fromARGB(217, 235, 235, 235),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/IMG_2780.jpg',
                            ),
                            radius: 35,
                          ),
                          const SizedBox(width: 15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.watch<Userprovider>().userNAME,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                context.watch<Userprovider>().createdAt != null
                                    // If NOT null, format the DateTime into a String
                                    ? 'Joined ${DateFormat.yMMMd().format(context.watch<Userprovider>().createdAt!)}'
                                    : 'Joined: N/A',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: const Color.fromARGB(
                                    255,
                                    148,
                                    148,
                                    148,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.arrow_forward_sharp),
                            iconSize: 30,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xFF00BFA5),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 0, 0, 0),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_downward,
                            color: Colors.teal,
                            size: 17,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pending inflow',
                              style: GoogleFonts.montserrat(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₦0.00',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.arrow_upward,
                            color: Colors.teal,
                            size: 17,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pending outflow',
                              style: GoogleFonts.montserrat(
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: 10,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '₦0.00',
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Buying & Selling',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(
                        Icons.credit_card,
                        color: Colors.teal,
                        size: 24,
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Manage listing',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'View and manage all your listing',
                            style: GoogleFonts.montserrat(
                              color: const Color(0xFF9E9E9E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Imagepicker();
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(
                        Icons.receipt_long,
                        color: Colors.teal,
                        size: 24,
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order history',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manage account details',
                            style: GoogleFonts.montserrat(
                              color: const Color(0xFF9E9E9E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        showGeneralDialog(
                          barrierDismissible: true,
                          barrierLabel: "side sheet",
                          transitionDuration: Duration(milliseconds: 300),
                          context: context,
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                                return StatefulBuilder(
                                  builder: (context, setDialogState) {
                                    return Material(
                                      color: Colors.white,
                                      child: Column(
                                        children: [
                                          AppBar(
                                            backgroundColor: Colors.white,
                                            title: Text(
                                              'Order history',
                                              style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w800,
                                                letterSpacing: 2,
                                              ),
                                            ),
                                            centerTitle: true,
                                            leading: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(
                                                Icons.arrow_back_sharp,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 300),
                                          Column(
                                            children: [
                                              Center(
                                                child: Text(
                                                  'No orders yet',
                                                  style: GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.w700,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 20),
                                              ElevatedButton(
                                                onPressed: () {},
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  minimumSize: Size(100, 40),
                                                  side: BorderSide(
                                                    color: const Color.fromARGB(
                                                      255,
                                                      220,
                                                      220,
                                                      220,
                                                    ),
                                                    width: 1.0,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20.0,
                                                        ),
                                                  ),
                                                ),
                                                child: Text(
                                                  'Refresh',
                                                  style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(
                        Icons.settings,
                        color: Colors.teal,
                        size: 24,
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Settings',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Manage notification, account and more',
                            style: GoogleFonts.montserrat(
                              color: const Color(0xFF9E9E9E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        showGeneralDialog(
                          barrierDismissible: true,
                          barrierLabel: "side sheet",
                          context: context,
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return StatefulBuilder(
                              builder: (context, setDialogState) {
                                return Material(
                                  color: Colors.white,
                                  child: Column(
                                    children: [
                                      AppBar(
                                        title: Text(
                                          'Settings',
                                          style: GoogleFonts.poppins(
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        centerTitle: true,
                                        leading: IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: Icon(Icons.arrow_back_sharp),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(30.0),
                                        child: Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                               
                                              },
                                              child: Container(
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        
                                                      },
                                                      child: Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                20.0,
                                                              ),
                                                          color: Color(
                                                            0xFFD9F5F5,
                                                          ),
                                                        ),

                                                        child: Icon(
                                                          LucideIcons.landmark,
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      'Bank account',
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                            Container(
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20.0,
                                                          ),
                                                      color: Color(0xFFD9F5F5),
                                                    ),

                                                    child: Icon(
                                                      LucideIcons.lock,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10),
                                                  Text(
                                                    'Change Password',
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {},
                                              child: Container(
                                                height: 80,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border(
                                                    bottom: BorderSide(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              20.0,
                                                            ),
                                                        color: Color(
                                                          0xFFD9F5F5,
                                                        ),
                                                      ),

                                                      child: Icon(
                                                        LucideIcons.bell,
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    Text(
                                                      'Get notified when new\n listing drops',
                                                      maxLines: 2,
                                                      style:
                                                          GoogleFonts.poppins(
                                                            fontWeight:
                                                                FontWeight.w900,
                                                          ),
                                                    ),
                                                    const Spacer(),
                                                    Switch.adaptive(
                                                      value: isSwiched,
                                                      onChanged: (bool value) {
                                                        setDialogState(() {
                                                          isSwiched = value;
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20.0,
                                                          ),
                                                      color: Color(0xFFD9F5F5),
                                                    ),

                                                    child: Icon(
                                                      LucideIcons.rotateCw,
                                                    ),
                                                  ),

                                                  Text(
                                                    'Auto-relist after buyer declines\ncheckout',
                                                    maxLines: 2,
                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Switch.adaptive(
                                                    value: isSwiched2,
                                                    onChanged: (bool value) {
                                                      setDialogState(() {
                                                        isSwiched2 = value;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: 80,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                border: Border(
                                                  bottom: BorderSide(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 40,
                                                    width: 40,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            20.0,
                                                          ),
                                                      color: Color(0xFFD9F5F5),
                                                    ),

                                                    child: Icon(
                                                      LucideIcons.rotateCw,
                                                    ),
                                                  ),

                                                  Text(
                                                    'Auto-relist after it expires',

                                                    style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  ),
                                                  const Spacer(),
                                                  Switch.adaptive(
                                                    value: isSwiched3,
                                                    onChanged: (bool value) {
                                                      setDialogState(() {
                                                        isSwiched3 = value;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Help & Support',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(
                        Icons.help_outline,
                        color: Colors.teal,
                        size: 24,
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get Help',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        showGeneralDialog(
                          context: context,
                          pageBuilder:
                              (context, animation, secondaryAnimation) {
                                return Contactpage();
                              },
                        );
                      },
                    ),
                  ),

                  Container(
                    height: 80, // Adjusted height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(
                        Icons.bookmark_outline,
                        color: Colors.teal,
                        size: 24,
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'WazMart guidelines',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Learn how it works and other guidelines',
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF9E9E9E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Others',
                        style: GoogleFonts.montserrat(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 80, // Adjusted height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(
                        Icons.favorite,
                        color: Colors.teal,
                        size: 24,
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rate App',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Tell us how you feel about this app ',
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF9E9E9E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Container(
                    height: 80, // Adjusted height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(
                        Icons.description_outlined,
                        color: Colors.teal,
                        size: 24,
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Legals',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Learn about our policies',
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF9E9E9E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Container(
                    height: 80, // Adjusted height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[200]!),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: const Icon(
                        Icons.people,
                        color: Colors.teal,
                        size: 24,
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About us',
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w800,
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Learn about Wazo mart',
                            style: GoogleFonts.montserrat(
                              color: Color(0xFF9E9E9E),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: Text(
                      'Version 1.7.0 (62)',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w900,
                        color: const Color.fromARGB(255, 91, 91, 91),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      ),
      ),
      ),
    );
  }
}

class _ProfileDialogContent extends StatefulWidget {
  const _ProfileDialogContent();

  @override
  State<_ProfileDialogContent> createState() => _ProfileDialogContentState();
}

class _ProfileDialogContentState extends State<_ProfileDialogContent> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        Provider.of<Userprovider>(
          context,
          listen: false,
        ).loadUserData(userId: userId);
      }
    });
  }

  Widget _buildDialogInfoContainer(
    BuildContext context, {
    required String label,
    required String value,
    required Userprovider userProvider,
  }) {
    String displayValue = value;
    if (label == 'Phone number' && value.isEmpty) {
      displayValue = 'Not provided';
    } else if (value.isEmpty && !userProvider.isLoading) {
      displayValue = 'N/A';
    } else if (userProvider.isLoading) {
      displayValue = 'Loading...';
    }

    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 255, 255),
        border: Border.all(
          color: const Color.fromARGB(217, 235, 235, 235),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 133, 127, 127),
              ),
            ),
            Text(
              displayValue,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = context.watch<Userprovider>();

    if (userProvider.isLoading && userProvider.userNAME.isEmpty) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_sharp),
        ),
        title: const Text('Profile details'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return Container(
                    color: Colors.white,

                    height: MediaQuery.of(context).size.height * 0.4,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 10.0,
                            bottom: 5.0,
                          ),
                          child: Container(
                            height: 4.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                              color: Colors
                                  .grey[300], // Light grey color for the handle
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                          ),
                        ),

                        // --- Custom Header/App Bar ---
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'More options',
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 20,
                                ),
                              ),

                              IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(Icons.close_sharp),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return Editingusername();
                                  },
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFF7E4DC),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: const Icon(
                                    Icons.person_outline,
                                    color: Color(0xFFE55A00),
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 20.0),
                                // Text styling
                                const Text(
                                  'Edit username',

                                  style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
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
            icon: const Icon(Icons.more),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/IMG_2791.jpg'),
                  radius: 60,
                ),
              ),
              const SizedBox(height: 20),
              _buildDialogInfoContainer(
                context,
                label: 'Email address',
                value: userProvider.newEmail,
                userProvider: userProvider,
              ),
              const SizedBox(height: 20),
              _buildDialogInfoContainer(
                context,
                label: 'First Name',
                value: userProvider.firstname,
                userProvider: userProvider,
              ),
              const SizedBox(height: 20),
              _buildDialogInfoContainer(
                context,
                label: 'Username',
                value: userProvider.userNAME,
                userProvider: userProvider,
              ),
              const SizedBox(height: 20),
              _buildDialogInfoContainer(
                context,
                label: 'Phone number',
                value: userProvider.phonenumber,
                userProvider: userProvider,
              ),
              const SizedBox(height: 150),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (context) {
                        return const Signinpage();
                      },
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  backgroundColor: const Color.fromARGB(255, 248, 207, 203),
                ),
                child: Text(
                  'Log out',
                  style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w900,
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
            
          ),
        ),
      ),
      ),
      ),
      ),
    );
  }
}

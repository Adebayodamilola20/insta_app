import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:insta_app/views/pages/Homepage.dart';

import 'package:lucide_icons/lucide_icons.dart';

class Sharefeedback extends StatefulWidget {
  const Sharefeedback({super.key});

  @override
  State<Sharefeedback> createState() => _SharefeedbackState();
}

class _SharefeedbackState extends State<Sharefeedback> {
  String selectedSubject = 'Others';

  final _textcontroller = TextEditingController();

  final List<String> subjects = [
    'Buying',
    'Selling',
    'Making offers',
    'Delivery',
    'Checkout',
    'Onboarding',
    'Others',
  ];

  @override
  void dispose() {
    _textcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Colors.teal;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Share your feedback',
          style: GoogleFonts.montserrat(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(LucideIcons.messageCircle),
          ),
        ],
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              String feedback = _textcontroller.text;
              print('Selected Subject: $selectedSubject');
              print('Feedback: $feedback');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return Homepage();
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 0,
            ),
            child: Text(
              'Submit',
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10.0,
              ),
              child: Text(
                'We are all ears on Wazomart!! love a feature or have an idea to make buying and selling second hand more secure and better',
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.black87),
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Feedback subject',
                      style: GoogleFonts.poppins(
                        color: const Color.fromARGB(255, 129, 129, 129),
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                  ),

                  Wrap(
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: subjects.map((subject) {
                      final bool isSelected = selectedSubject == subject;
                      return ChoiceChip(
                        label: Text(
                          subject,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: accentColor,

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          side: BorderSide(
                            color: isSelected
                                ? accentColor
                                : Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        backgroundColor: Colors.transparent,

                        onSelected: (bool newSelected) {
                          if (newSelected) {
                            setState(() {
                              selectedSubject = subject;
                            });
                          }
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: Text(
                      'Share feedback here',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w700,
                        color: const Color.fromARGB(255, 121, 121, 121),
                        fontSize: 14,
                      ),
                    ),
                  ),

                  TextFormField(
                    controller: _textcontroller,
                    maxLines: 8,
                    minLines: 8,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 16.0,
                    ),

                    decoration: InputDecoration(
                      hintText:
                          'Tell us what you like, or what we can improve.',
                      hintStyle: GoogleFonts.poppins(
                        color: Colors.grey.shade500,
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade50,

                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: const BorderSide(
                          color: accentColor,
                          width: 2.0,
                        ),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
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
      ),
    );
  }
}

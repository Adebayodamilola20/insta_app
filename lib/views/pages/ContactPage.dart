import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Contactpage extends StatelessWidget {
  const Contactpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Support',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w900, fontSize: 19),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_sharp),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              children: [
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey[300]!,
                )),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.asset(
                        'assets/images/social.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  SizedBox(width: 30),
                  Text(
                    'Whatsapp',
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w900),
                  ),
                ],
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

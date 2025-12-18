import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_app/shared/provider/Userprovider.dart';
import 'package:provider/provider.dart';

class Editingusername extends StatefulWidget {
  const Editingusername({super.key});

  @override
  State<Editingusername> createState() => _EditingusernameState();
}

class _EditingusernameState extends State<Editingusername> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit username')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<Userprovider>().changeUserNAME(
                  newuserNAME: _controller.text,
                );
                FocusManager.instance.primaryFocus?.unfocus();
                _controller.clear();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00BFA5),
                minimumSize: Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0,
              ),
              child: Text(
                'Save',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
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

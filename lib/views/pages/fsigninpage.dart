import 'package:flutter/material.dart';

class Fsigninpage extends StatefulWidget {
  const Fsigninpage({super.key});

  @override
  State<Fsigninpage> createState() => _FsigninpageState();
}

class _FsigninpageState extends State<Fsigninpage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();
  final TextEditingController _firstnamecontroller = TextEditingController();
  final TextEditingController _dateofbcontroller = TextEditingController();
  final TextEditingController _lastname = TextEditingController();

    InputDecoration _customInputDecoration({
    required String labelText,
    required IconData prefixIcon,
    String? hintText,
    Widget? suffixIcon
  }) {
    const Color fillColor = Color(0xFFF0F0F0);

    return InputDecoration(
      filled: true,
      fillColor: fillColor,
      labelText: labelText,
      labelStyle: const TextStyle(color: Colors.grey),
      prefixIcon: Icon(prefixIcon, color: Colors.grey),
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: Colors.red, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up'),
        centerTitle: false,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailcontroller,
                      keyboardType: TextInputType.text,
                      decoration: _customInputDecoration(
                        labelText: 'user name',
                        prefixIcon: Icons.email_outlined,
                        hintText: "Enter your username",
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _passwordcontroller,
                      keyboardType: TextInputType.text,
                      decoration: _customInputDecoration(
                        labelText: 'user name',
                        prefixIcon: Icons.email_outlined,
                        hintText: "Enter your username",
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _firstnamecontroller,
                      keyboardType: TextInputType.text,
                      decoration: _customInputDecoration(
                        labelText: 'user name',
                        prefixIcon: Icons.email_outlined,
                        hintText: "Enter your username",
                      ),
                    ),
                    const SizedBox(height: 30),
                    TextFormField(
                      controller: _dateofbcontroller,
                      keyboardType: TextInputType.text,
                      decoration: _customInputDecoration(
                        labelText: 'user name',
                        prefixIcon: Icons.email_outlined,
                        hintText: "Enter your username",
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

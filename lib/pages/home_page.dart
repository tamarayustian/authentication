import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  // Sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: Icon(
              Icons.logout,
              size: screenSize.width < 600 ? 32 : 48, // Responsive icon size
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(
          'LOGGED IN AS: ${user.email!}',
          style: TextStyle(
            fontSize: screenSize.width < 600 ? 16 : 24, // Responsive font size
            fontWeight: FontWeight.bold, // Make text bold for emphasis
          ),
          textAlign: TextAlign.center, // Center align the text
        ),
      ),
    );
  }
}

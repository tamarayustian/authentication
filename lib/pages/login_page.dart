import 'package:authentication/components/my_button.dart';
import 'package:authentication/components/my_textfield.dart';
import 'package:authentication/components/square_tile.dart';
import 'package:authentication/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    _showLoadingIndicator();

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      _showErrorMessage(e.code);
    }
  }

  void _showLoadingIndicator() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepOrange,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width > 600;

    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: screenSize.width * 0.05),
            child: isDesktop ? _buildDesktopLayout() : _buildMobileLayout(),
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopLayout() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Left Side: Icon and Welcome Text
        Expanded(
          flex: 1,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.lock, size: 100),
                const SizedBox(height: 10),
                Text(
                  'Welcome back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: MediaQuery.of(context).size.width * 0.03,
                  ),
                ),
              ],
            ),
          ),
        ),
        // Right Side: Form Fields and Buttons
        Expanded(
          flex: 2,
          child: _buildForm(),
        ),
      ],
    );
  }

  Widget _buildMobileLayout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        const Icon(Icons.lock, size: 100),
        const SizedBox(height: 10), // Space between icon and text
        Text(
          'Welcome back!',
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: MediaQuery.of(context).size.width * 0.05,
          ),
        ),
        const SizedBox(height: 50),
        _buildForm(),
      ],
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 25),
        MyTextField(
            controller: emailController, hintText: 'Email', obscureText: false),
        const SizedBox(height: 10),
        MyTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true),
        const SizedBox(height: 10),
        _buildForgotPassword(),
        const SizedBox(height: 25),
        MyButton(text: 'Sign In', onTap: signUserIn),
        const SizedBox(height: 50),
        _buildDivider(),
        const SizedBox(height: 50),
        _buildGoogleSignIn(),
        const SizedBox(height: 50),
        _buildRegisterRow(),
      ],
    );
  }

  Widget _buildForgotPassword() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text('Forgot Password?', style: TextStyle(color: Colors.grey[600])),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400])),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text('Or continue with',
              style: TextStyle(color: Colors.grey[700])),
        ),
        Expanded(child: Divider(thickness: 0.5, color: Colors.grey[400])),
      ],
    );
  }

  Widget _buildGoogleSignIn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SquareTile(
          onTap: () => AuthService().signInWithGoogle(),
          imagePath: 'lib/images/google-icon.png',
        ),
      ],
    );
  }

  Widget _buildRegisterRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Not a member?', style: TextStyle(color: Colors.grey[700])),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: widget.onTap,
          child: const Text(
            'Register now',
            style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

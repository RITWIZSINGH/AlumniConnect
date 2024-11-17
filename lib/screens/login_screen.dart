// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, avoid_print, use_key_in_widget_constructors, library_private_types_in_public_api, sort_child_properties_last, unused_field, unused_element, no_leading_underscores_for_local_identifiers, unused_local_variable, unused_import
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = false;
  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  Future<void> _signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print("Error signing in with email: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to sign in: $e")),
      );
    }
  }

  Future<void> _signUpWithEmailAndPassword() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print("Error signing up: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to sign up: $e")),
      );
    }
  }

  // Future<void> _signInWithGoogle() async {
  //   try {
  //     final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
  //     if (googleUser == null) return;

  //     final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
  //     final AuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );

  //     await _auth.signInWithCredential(credential);
  //     Navigator.pushReplacementNamed(context, '/home');
  //   } catch (e) {
  //     print("Error signing in with Google: $e");
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text("Failed to sign in with Google: $e")),
  //     );
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isSignUp ? "Sign Up" : "Login"),
        backgroundColor: Colors.blue.shade700,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome to Alumni Connect",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isSignUp
                    ? _signUpWithEmailAndPassword
                    : _signInWithEmailAndPassword,
                child: Text(_isSignUp ? "Sign Up" : "Login"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.blue.shade700,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isSignUp = !_isSignUp;
                  });
                },
                child: Text(
                  _isSignUp
                      ? "Already have an account? Login"
                      : "Don't have an account? Sign Up",
                  style: TextStyle(color: Colors.blue.shade700),
                ),
              ),
              SizedBox(height: 20),
              Divider(),
              SizedBox(height: 20),
              // ElevatedButton.icon(
              //   onPressed: _signInWithEmailAndPassword,
              //   icon: Icon(Icons.login),
              //   label: Text("Sign in with Google"),
              //   style: ElevatedButton.styleFrom(
              //     foregroundColor: Colors.blue.shade700,
              //     padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(8),
              //     ),
              //   ),
              // ),
              _googleSignInButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _googleSignInButton() {
    return SignInButton(
      Buttons.google,
      onPressed: _handleGoogleSignIn,
      text: "Sign Up with Google",
    );
  }

  Future<void> _handleGoogleSignIn() async {
  try {
    // Trigger the Google Sign In process
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return;

    // Obtain auth details from the request
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    
    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in to Firebase with the credential
    final UserCredential userCredential = 
        await _auth.signInWithCredential(credential);
        
    // Navigate to home page after successful sign in
    if (userCredential.user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    }
  } catch (e) {
    print("Error signing in with Google: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Failed to sign in with Google: $e")),
    );
  }
}
}

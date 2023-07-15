// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pest_detection/auth/SignupScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../home_screen.dart';
import 'AuthService.dart';
import 'UserService.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _auth = AuthService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late UserService _userService;

  @override
  void initState() {
    super.initState();
    _initUserService();
  }

  void _initUserService() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _userService = UserService(prefs: prefs);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      User? user = await _auth.signInWithEmailAndPassword(
          _emailController.text.trim(), _passwordController.text.trim());
      if (user != null) {
        await _userService.saveUserData(_emailController.text.trim());
        Navigator.of(context).pop();
        Get.to(const HomeScreen());
      } else {
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Incorrect email or password.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Form(
          key: _formKey,
          child: Padding(
              padding: const EdgeInsets.only(top: 20, left: 40, right: 40),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      "Pest Detection",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    const Image(
                      image: AssetImage('assets/icon.png'),
                      height: 200,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address.';
                        }
                        if (value.length < 6) {
                          return 'Email cannot be less than 6 characters.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        if (value.length < 6) {
                          return 'Password cannot be less than 6 characters.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                      onPressed: _handleLogin,
                      child: const Text('Login'),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                        onTap: _handleGoogleLogin,
                        child: const Text(
                          "SignIn With Google",
                          style: TextStyle(color: Colors.green),
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      const Text('No account? '),
                      InkWell(
                        onTap: () {
                          Get.to(() => const SignupScreen(),
                              transition: Transition.leftToRight);
                        },
                        child: const Text(
                          'Create an account',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ]),
                  ]))),
    ));
  }

  void _handleGoogleLogin() async {
    try {
      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        await _userService.saveUserData(userCredential.user!.email!);
        Get.to(const HomeScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Error while signing in with Google')));
      }
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Sign-in failed: ${e.message}')));
    }
  }
}

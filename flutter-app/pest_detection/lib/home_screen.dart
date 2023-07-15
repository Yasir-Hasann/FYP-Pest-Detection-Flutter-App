// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: no_leading_underscores_for_local_identifiers, use_build_context_synchronously
// ignore_for_file: deprecated_member_use, unused_field
import 'dart:convert';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/LoginScreen.dart';
import 'auth/UserService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State {
  File? imageFile;
  String? email;

  // Future<PickedFile>? file
  Future<void> _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Choose option",
              style: TextStyle(color: Colors.blue),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openGallery(context);
                    },
                    title: const Text("Gallery"),
                    leading: const Icon(
                      Icons.account_box,
                      color: Colors.blue,
                    ),
                  ),
                  const Divider(
                    height: 1,
                    color: Colors.blue,
                  ),
                  ListTile(
                    onTap: () {
                      _openCamera(context);
                    },
                    title: const Text("Camera"),
                    leading: const Icon(
                      Icons.camera,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  final bool _loading = true;
  List? _output;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      email = prefs.getString('email');
    });
  }

  late String classname = '';
  late String exception = '';
  late String confidence = '';
  late String treatment = '';

  Future<dynamic> uploadImage(pickedFile) async {
    if (pickedFile != null) {
      final file = File(pickedFile.path);

      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.8.33.0:3000/upload'),   // // Replace it with your IP Address
      );
      request.files.add(await http.MultipartFile.fromPath('image', file.path,
          filename: pickedFile.name));

      final response = await request.send();
      if (response.statusCode == 200) {
        try {
          final jsonResponse =
              jsonDecode(await response.stream.bytesToString());
          setState(() {
            exception = '';
            classname =
                jsonResponse['data']['predictions'][0]['class'].toString();
            confidence =
                jsonResponse['data']['predictions'][0]['confidence'].toString();
            if (classname == 'aphid') {
              treatment =
                  '\nInsecticidal Soap\nNeem Oil\nPyrethrin-based Insecticides\nHorticultural Oils.';
            } else if (classname == 'sawfly') {
              treatment =
                  '\nSpinosad\nBacillus thuringiensis (Bt)\nPyrethrin-based Insecticides\nCarbaryl.';
            } else if (classname == 'grasshopper') {
              treatment =
                  '\nInsecticidal Dusts\nNeem Oil\nPyrethrin-based Insecticides\nBiological Controls.';
            } else if (classname == 'Green-Leafhopper') {
              treatment =
                  '\nInsecticidal Soap\nNeem Oil\nPyrethrin-based Insecticides\nHorticultural Oils.';
            } else if (classname == 'beetle') {
              treatment = '\nImidacloprid\nAcephate\nDinotefuran\nThiamethoxam';
            } else if (classname == 'armyworm') {
              treatment =
                  '\nBacillus thuringiensis (Bt)\nSpinosad\nPyrethrin-based Insecticides\nCarbaryl.';
            }
          });
          print(jsonResponse['data']['predictions'][0]['class']);
          print(jsonResponse['data']['predictions'][0]['confidence']);
          return jsonResponse;
        } catch (e) {
          setState(() {
            confidence = '';
            classname = '';
            treatment = '';
            exception = '123';
            imageFile = null;
          });
          print('Error: $e');
          return 'An error occurred while processing the response.';
        }
      } else {
        print('Image upload failed with status: ${response.statusCode}');
        return 'Image upload failed';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    void _handleSignOut() async {
      showDialog(
          context: context,
          builder: (context) {
            return const Center(child: CircularProgressIndicator());
          });
      SharedPreferences prefs = await SharedPreferences.getInstance();
      UserService userService = UserService(prefs: prefs);
      await userService.removeUserData();
      await GoogleSignIn().signOut();
      FirebaseAuth.instance.signOut();
      Navigator.of(context).pop();
      Get.offAll(const LoginScreen());
    }

    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: [
          const DrawerHeader(
              child: Icon(
            Icons.person,
            size: 100,
          )),
          Center(child: Text('$email')),
          const SizedBox(
            height: 40,
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Signout'),
            onTap: _handleSignOut,
          )
        ],
      )),
      appBar: AppBar(
        title: const Text("Pest Detection"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Card(
              child: (imageFile == null)
                  ? Image.asset('assets/home.png')
                  : Image.file(
                      File(imageFile!.path),
                      width: 400,
                      height: 400,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  classname.isNotEmpty
                      ? Row(
                          children: [
                            const Text(
                              'Pest is : ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              classname,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  confidence.isNotEmpty
                      ? Row(
                          children: [
                            const Text(
                              'Accuracy is : ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              confidence.substring(0, 10),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            )
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(
                    height: 10,
                  ),
                  classname.isNotEmpty
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Recommended Pesticides : ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            Text(
                              treatment,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            )
                          ],
                        )
                      : const SizedBox(),
                  exception.isNotEmpty
                      ? const Text(
                          'Sorry, cannot detect any pest.\nPlease select another image.',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        )
                      : const SizedBox(),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              textColor: Colors.white,
              color: Colors.blue,
              onPressed: () {
                _showChoiceDialog(context);
              },
              child: const Text("Select Image"),
            )
          ],
        ),
      ),
    );
  }

  final picker = ImagePicker();
  void _openGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    setState(() {
      imageFile = File(pickedFile!.path);
      confidence = '';
      classname = '';
      treatment = '';
      exception = '';
    });
    uploadImage(pickedFile);
    Navigator.pop(context);
  }

  void _openCamera(BuildContext context) async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = File(pickedFile!.path);
      confidence = '';
      classname = '';
      treatment = '';
      exception = '';
    });
    uploadImage(pickedFile);

    Navigator.pop(context);
  }
}

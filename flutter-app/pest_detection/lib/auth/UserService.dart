// ignore_for_file: file_names

import 'package:shared_preferences/shared_preferences.dart';

//...

class UserService {
  final SharedPreferences prefs;

  UserService({required this.prefs});

  // save user data to local storage
  Future saveUserData(String email) async {
    await prefs.setString('email', email);
  }

  // retrieve user data from local storage
  Future<Map<String, String>> getUserData() async {
    String? email = prefs.getString('email');

    return {'email': email ?? ''};
  }

  Future removeUserData() async {
    await prefs.remove('email');
  }
}

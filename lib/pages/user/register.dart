import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../home.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

Future<bool> isEmailRegistered(String email) async {
  const String url = 'https://itrungrul.xyz/users/all';

  try {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List users = jsonDecode(response.body);
      // Check if any user has the given email
      return users.any((user) => user['email'] == email);
    } else {
      throw Exception('Failed to fetch users: ${response.statusCode}');
    }
  } catch (error) {
    if (kDebugMode) {
      print('Error fetching users: $error');
    }
    return false;
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final Box userBox = Hive.box('userBox');
  bool _isLoading = false;

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> registerUser(
      String username, String phone, String email, String password) async {
    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Center(child: Text('Invalid email format'))),
      );
      return; // Exit if email is invalid
    }

    bool emailExists = await isEmailRegistered(email);
    if (emailExists) {
      Get.snackbar(
        '',
        '',
        backgroundColor: Colors.red,
        titleText: const Center(child: Text('Email already registered')),
        messageText: const Center(child: Text('Please use a different email.')),
      );
      return; // Exit if email is already registered
    }

    const String url = 'https://itrungrul.xyz/users/create';

    try {
      _toggleLoading();

      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'phone': phone,
          'email': email,
          'password': password,
        }),
      );

      _toggleLoading();

      if (response.statusCode == 201) {
        var res = jsonDecode(response.body);

        Get.snackbar(
          '',
          '',
          snackPosition: SnackPosition.BOTTOM,
          titleText: const Center(
            child: Text(
              'Register Success',
              style: TextStyle(color: Colors.green),
            ),
          ),
        );

        // Store user info in Hive
        userBox.put('username', username);
        userBox.put('phone', phone);
        userBox.put('email', email);
        userBox.put('password', password);
        userBox.put('id', res['user']['_id']);

        // Clear form fields
        nameController.clear();
        phoneController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();

        Get.off(Home(
          username: username,
          phone: phone,
          email: email,
        ));
      } else {
        if (kDebugMode) {
          print('Failed to register user: ${response.body}');
        }
        Get.snackbar(
          '',
          '',
          backgroundColor: Colors.red,
          titleText: const Center(child: Text('Registration Failed')),
          messageText: const Center(child: Text('Please try again later.')),
        );
      }
    } catch (error) {
      _toggleLoading();
      if (kDebugMode) {
        print('Error during registration: $error');
      }
      Get.snackbar(
        '',
        '',
        backgroundColor: Colors.red,
        titleText: const Center(child: Text('Error')),
        messageText: const Center(child: Text('An unexpected error occurred.')),
      );
    }
  }

  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100),
                  const Text(
                    'Sign up',
                    style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                      'Name', nameController, false, TextInputType.text),
                  const SizedBox(height: 10),
                  _buildTextField(
                      'Phone', phoneController, false, TextInputType.number),
                  const SizedBox(height: 10),
                  _buildTextField(
                      'Email', emailController, false, TextInputType.text),
                  const SizedBox(height: 10),
                  _buildTextField(
                      'Password', passwordController, true, TextInputType.text),
                  const SizedBox(height: 10),
                  _buildTextField('Confirm Password', confirmPasswordController,
                      true, TextInputType.text),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (passwordController.text ==
                            confirmPasswordController.text) {
                          registerUser(
                              nameController.text,
                              phoneController.text,
                              emailController.text,
                              passwordController.text);
                        } else {
                          Get.showSnackbar(const GetSnackBar(
                            backgroundColor: Colors.red,
                            duration: Duration(seconds: 3),
                            messageText: Center(
                              child: Text(
                                'Passwords do not match!',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black45,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 50, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Register',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      bool isPassword, TextInputType? keyboardType) {
    return TextField(
      controller: controller,
      autocorrect: false,
      keyboardType: keyboardType,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

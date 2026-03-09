import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:laihla_lyrics/pages/user/register.dart';

import '../../home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Box userBox = Hive.box('userBox');

  bool isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    if (!isValidEmail(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            backgroundColor: Colors.red,
            content: Center(child: Text('Invalid email format'))),
      );
      return; // Exit if email is invalid
    }

    const String url = 'https://laihlalyrics.itrungrul.com/users/login';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      var list = jsonDecode(response.body);

      const Center(
        child: CircularProgressIndicator(),
      );
      if (response.statusCode == 200) {
        await userBox.put('email', email);
        await userBox.put('username', list['user']['username']);
        await userBox.put('phone', list['user']['phone']);
        await userBox.put('id', list['user']['_id']);
        await userBox.put('password', password);
        Get.off(() => Home());
      } else {
        // Show error if fetching users failed
        Get.snackbar(
          '',
          '',
          titleText: Center(child: Text(response.body)),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
      }
    } catch (error) {
      // Handle network or API errors
      Get.snackbar(
        '',
        '',
        titleText: Center(child: Text('Error: $error')),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  void _checkSavedCredentials() async {
    String savedEmail = await userBox.get('email');
    final savedPassword = await userBox.get('password');
    String username = await userBox.get('username');
    String phone = await userBox.get('phone');

    if (savedEmail.isNotEmpty &&
        savedPassword != null &&
        username.isNotEmpty &&
        phone.isNotEmpty) {
      Get.off(() => Home());
    }
  }

  @override
  void initState() {
    super.initState();
    _checkSavedCredentials(); // Check saved credentials on startup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Text(
                'Laihla lyrics',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.topRight,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                      'assets/logo1.png'), // Replace with your image path
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Login',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildTextField('Email', emailController, false),
              const SizedBox(height: 10),
              _buildTextField('Password', passwordController, true),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forgot password ?'),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.to(const SignUpPage());
                    },
                    child: const Text('Create an account'),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center(
                child: TextButton(
                  onPressed: () {
                    Get.off(const Home());
                  },
                  child: const Text('Use the Application Without Sign In'),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: TextButton(
                  onPressed: () {
                    loginUser(
                        context, emailController.text, passwordController.text);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }
}

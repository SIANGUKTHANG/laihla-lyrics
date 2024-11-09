import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart'; // for `basename`

class ImageUploadService {
  final ImagePicker _picker = ImagePicker();

  // Method to pick an image and return the file path
  Future<String?> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      return pickedFile.path; // Return the file path of the selected image
    } else {
      if (kDebugMode) {

      }
      return null;
    }
  }

  // Method to upload the image file to the server
  Future<void> uploadImage(String username, Box userBox) async {
    const String url = 'http://192.168.219.101:3000/users/update';
    String? imagePath = await pickImage();

    if (imagePath == null) {

      return;
    }

    try {
      // Create a multipart request for image upload
      var request = http.MultipartRequest('POST', Uri.parse('$url/$username'));

      // Add the image file to the request
      request.files.add(
        await http.MultipartFile.fromPath(
          'imageUrl', // Field name expected by the server
          imagePath, filename: basename(imagePath), // Extract the file name
        ),
      );

      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final decodedData = jsonDecode(responseData); // Decode JSON response if needed
        userBox.put('imageUrl', decodedData['user']['imageUrl']);
      } else {
        if (kDebugMode) {
          print('Image upload failed with status: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading image: $e');
      }
    }
  }
}


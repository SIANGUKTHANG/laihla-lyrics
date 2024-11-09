import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class UploadSongPage extends StatefulWidget {
  const UploadSongPage({Key? key}) : super(key: key);

  @override
  UploadSongPageState createState() => UploadSongPageState();
}

class UploadSongPageState extends State<UploadSongPage> {
  final _formKey = GlobalKey<FormState>();
  final Box userBox = Hive.box('userBox');
  late String username;
  late String id;

  //add cards
  bool singer = false;
  bool composer = false;
  bool verse1 = false;
  bool chorus = false;
  bool verse2 = false;
  bool verse3 = false;
  bool verse4 = false;
  bool verse5 = false;
  bool endingChorus = false;

  // Controllers for each text field
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _composerController = TextEditingController();
  final TextEditingController _singerController = TextEditingController();
  final TextEditingController _verse1Controller = TextEditingController();
  final TextEditingController _verse2Controller = TextEditingController();
  final TextEditingController _verse3Controller = TextEditingController();
  final TextEditingController _verse4Controller = TextEditingController();
  final TextEditingController _chorusController = TextEditingController();
  final TextEditingController _endingController = TextEditingController();

  String category = 'pathian-hla'; // Default category
  bool chord = false;

  // Loading state variable
  bool _isLoading = false;

  // Initialize toggle loading function
  void _toggleLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    username = await userBox.get('username');
    id = await userBox.get('id');
  }

  Future<void> _uploadSong() async {
    if (_formKey.currentState!.validate()) {
      _toggleLoading();
      try {
        // Prepare the song data
        final newSong = {
          "title": _titleController.text,
          "composer": _composerController.text,
          "singer": _singerController.text,
          "verse1": _verse1Controller.text,
          "verse2": _verse2Controller.text,
          "verse3": _verse3Controller.text,
          "verse4": _verse4Controller.text,
          "chorus": _chorusController.text,
          "category": category,
          "chord": chord,
          "name": username,
          "uploader": id,
          "songtrack": '',
        };

        // Get file path in temporary directory
        const fileName = 'hla'; // Specify the desired file name
        final dir = await getTemporaryDirectory();
        final filePath = '${dir.path}/$fileName';
        final file = File(filePath);

        // Read the existing list of songs from the file (if exists)
        List<dynamic> songList = [];
        if (await file.exists()) {
          final fileContent = await file.readAsString();
          songList = json.decode(fileContent) as List<dynamic>;
        }

        // Send the new song data to the server
        final response = await http.post(
          Uri.parse('https://itrungrul.xyz/api/songs'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(newSong),
        );
        _toggleLoading();
        // Check if the response is successful
        if (response.statusCode == 201) {
          // Add the new song to the beginning of the list
          songList.insert(0, newSong);

          // Write the updated list back to the file
          await file.writeAsString(json.encode(songList));

          _clearFormFields();
          // Close the screen with success
          Get.back(result: true, closeOverlays: true);
        } else {
          // Handle unsuccessful response
          Get.snackbar('Error', 'Failed to upload song to the server');
          Get.back(closeOverlays: true);
        }
      } catch (e) {
        // Handle any errors
        Get.snackbar('Error', 'An unexpected error occurred');
        Get.back(closeOverlays: true);
      }
    }
  }

  // Function to clear form fields after successful upload
  void _clearFormFields() {
    _titleController.clear();
    _composerController.clear();
    _singerController.clear();
    _verse1Controller.clear();
    _verse2Controller.clear();
    _verse3Controller.clear();
    _verse4Controller.clear();
    _chorusController.clear();
    _endingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Upload ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const SizedBox(),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(closeOverlays: true);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          TextButton(
            onPressed: _uploadSong,
            child: const Text(
              'Done',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildBlurCard(
                      child: Column(
                        children: [
                          // Category Dropdown
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                  color: Colors.purple.withOpacity(1)),
                            ),
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: DropdownButtonFormField<String>(
                              value: category,
                              items: [
                                'pathian-hla',
                                "christmas-hla",
                                "kumthar-hla",
                                "thitum-hla",
                                "ram-hla",
                                'zun-hla',
                                'hladang'
                              ]
                                  .map((category) => DropdownMenuItem(
                                        value: category,
                                        child: Text(
                                          category,
                                          style: const TextStyle(
                                              color: Colors.red, fontSize: 20),
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  category = value!;
                                });
                              },
                              decoration: const InputDecoration(
                                labelText: 'Category',
                                labelStyle: TextStyle(color: Colors.white70),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Text Fields for song details
                          _validateTextField(
                              label: 'title', controller: _titleController),
                          singer
                              ? _validateTextField(
                                  label: 'singer',
                                  controller: _singerController)
                              : const SizedBox(),
                          composer
                              ? _validateTextField(
                                  label: 'composer',
                                  controller: _composerController)
                              : const SizedBox(),
                          verse1
                              ? _validateTextField(
                                  label: 'verse1',
                                  controller: _verse1Controller)
                              : const SizedBox(),
                          chorus
                              ? _justTextField(
                                  label: 'chorus',
                                  controller: _chorusController)
                              : const SizedBox(),
                          verse2
                              ? _justTextField(
                                  label: 'verse2',
                                  controller: _verse2Controller)
                              : const SizedBox(),
                          verse3
                              ? _justTextField(
                                  label: 'verse3',
                                  controller: _verse3Controller)
                              : const SizedBox(),
                          verse4
                              ? _justTextField(
                                  label: 'verse4',
                                  controller: _verse4Controller)
                              : const SizedBox(),

                          endingChorus
                              ? _justTextField(
                                  label: 'endingchorus',
                                  controller: _endingController)
                              : const SizedBox(),
                          const SizedBox(height: 10),

                          endingChorus
                              ? const SizedBox()
                              : CircleAvatar(
                                  backgroundColor: Colors.purple.shade400,
                                  child: IconButton(
                                      onPressed: () {
                                        if (singer == false) {
                                          setState(() {
                                            singer = true;
                                          });
                                        } else if (composer == false) {
                                          setState(() {
                                            composer = true;
                                          });
                                        } else if (verse1 == false) {
                                          setState(() {
                                            verse1 = true;
                                          });
                                        } else if (chorus == false) {
                                          setState(() {
                                            chorus = true;
                                          });
                                        } else if (verse2 == false) {
                                          setState(() {
                                            verse2 = true;
                                          });
                                        } else if (verse3 == false) {
                                          setState(() {
                                            verse3 = true;
                                          });
                                        } else if (verse4 == false) {
                                          setState(() {
                                            verse4 = true;
                                          });
                                        } else if (endingChorus == false) {
                                          setState(() {
                                            endingChorus = true;
                                          });
                                        }
                                      },
                                      icon: endingChorus
                                          ? const SizedBox()
                                          : const Icon(
                                              Icons.add,
                                              color: Colors.black,
                                            )),
                                )
                          // File Picker Button
                        ],
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ),
          ),
          if (_isLoading) const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }

  Widget _validateTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.withOpacity(0.5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: TextFormField(
        cursorColor: Colors.white,
        minLines: 1,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          labelStyle: const TextStyle(color: Colors.white70),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  Widget _justTextField({
    required String label,
    required TextEditingController controller,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.purple.withOpacity(0.5)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: TextFormField(
        cursorColor: Colors.white,
        minLines: 1,
        maxLines: null,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        controller: controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
          border: InputBorder.none,
          labelStyle: const TextStyle(color: Colors.white70),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.purple),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white70),
          ),
        ),
      ),
    );
  }

  Widget _buildBlurCard({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.white.withOpacity(0.2)),
          ),
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }
}

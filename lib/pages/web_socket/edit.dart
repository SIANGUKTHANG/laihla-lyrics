import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateSongPage extends StatefulWidget {
  final Map<String, dynamic> song;

  const UpdateSongPage({super.key, required this.song});

  @override
  UpdateSongPageState createState() => UpdateSongPageState();
}

class UpdateSongPageState extends State<UpdateSongPage> {
  final _formKey = GlobalKey<FormState>();
  final Box userBox = Hive.box('userBox');
  late String username;
  late String id;

  // Controllers
  late TextEditingController _titleController;
  late TextEditingController _composerController;
  late TextEditingController _singerController;
  late TextEditingController _verse1Controller;
  late TextEditingController _verse2Controller;
  late TextEditingController _verse3Controller;
  late TextEditingController _verse4Controller;
  late TextEditingController _chorusController;

  // Focus Nodes for each field
  final FocusNode _titleFocus = FocusNode();
  final FocusNode _composerFocus = FocusNode();
  final FocusNode _singerFocus = FocusNode();
  final FocusNode _verse1Focus = FocusNode();
  final FocusNode _verse2Focus = FocusNode();
  final FocusNode _verse3Focus = FocusNode();
  final FocusNode _verse4Focus = FocusNode();
  final FocusNode _chorusFocus = FocusNode();

  late String category;
  late bool chord;
  late String songtrack;


  getUser()async{
    username = await userBox.get('username');
    id = await userBox.get('id');

  }

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


    // Initialize controllers with the song data
    _titleController = TextEditingController(text: widget.song['title']);
    _composerController = TextEditingController(text: widget.song['composer']);
    _singerController = TextEditingController(text: widget.song['singer']);
    _verse1Controller = TextEditingController(text: widget.song['verse1']);
    _verse2Controller = TextEditingController(text: widget.song['verse2']);
    _verse3Controller = TextEditingController(text: widget.song['verse3']);
    _verse4Controller = TextEditingController(text: widget.song['verse4']);
    _chorusController = TextEditingController(text: widget.song['chorus']);
    category = widget.song['category'];
    chord = widget.song['chord'];
    songtrack = widget.song['songtrack'];
    super.initState();
  }

  Future<void> _updateSong() async {
    if (_formKey.currentState!.validate()) {
      _toggleLoading();
      final updatedSong = {
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
        "uploader": id,
        "name": username,
        "songtrack": '',
      };

      final response = await http.put(
        Uri.parse(
            'https://itrungrul.xyz/api/songs/${widget.song["_id"]}'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(updatedSong),
      );
      _toggleLoading();
      if (response.statusCode == 200) {
        Get.back(result: true, closeOverlays: true);
      } else {
        Get.back(closeOverlays: true);

      }
    }
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes
    _titleController.dispose();
    _composerController.dispose();
    _singerController.dispose();
    _verse1Controller.dispose();
    _verse2Controller.dispose();
    _verse3Controller.dispose();
    _verse4Controller.dispose();
    _chorusController.dispose();

    _titleFocus.dispose();
    _composerFocus.dispose();
    _singerFocus.dispose();
    _verse1Focus.dispose();
    _verse2Focus.dispose();
    _verse3Focus.dispose();
    _verse4Focus.dispose();
    _chorusFocus.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'update song',
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
              onPressed: _updateSong,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: const Text(
                  'Done',
                  style: TextStyle(color: Colors.white),
                ),
              ))
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
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border:
                                  Border.all(color: Colors.purple.withOpacity(1)),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: DropdownButtonFormField<String>(
                              focusColor: Colors.white,
                              icon: const Icon(
                                Icons.arrow_drop_down_outlined,
                                size: 26,
                              ),
                              iconEnabledColor: Colors.white,
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
                                        alignment: Alignment.center,
                                        value: category,
                                        child: Text(
                                          category,
                                          style: TextStyle(
                                              color: Colors.red.shade600,
                                              fontSize: 20),
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
                                  labelStyle: TextStyle(color: Colors.white70)),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          _buildTextField(
                            label: 'Title',
                            controller: _titleController,
                            focusNode: _titleFocus,
                          ),
                          _buildTextField(
                            label: 'Composer',
                            controller: _composerController,
                            focusNode: _composerFocus,
                          ),
                          _buildTextField(
                            label: 'Singer',
                            controller: _singerController,
                            focusNode: _singerFocus,
                          ),
                          _buildTextField(
                            label: 'Verse 1',
                            controller: _verse1Controller,
                            focusNode: _verse1Focus,
                          ),
                          _buildTextField(
                            label: 'Verse 2',
                            controller: _verse2Controller,
                            focusNode: _verse2Focus,
                          ),
                          _buildTextField(
                            label: 'Verse 3',
                            controller: _verse3Controller,
                            focusNode: _verse3Focus,
                          ),
                          _buildTextField(
                            label: 'Verse 4',
                            controller: _verse4Controller,
                            focusNode: _verse4Focus,
                          ),
                          _buildTextField(
                            label: 'Chorus',
                            controller: _chorusController,
                            focusNode: _chorusFocus,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
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
        // Start with a single line
        maxLines: null,
        // Allow expansion to multiple lines
        keyboardType: TextInputType.multiline,
        // Enable multiline input
        textInputAction: TextInputAction.newline,
        // Allow Enter key to add a new line
        controller: controller,
        focusNode: focusNode,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          labelText: label,
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

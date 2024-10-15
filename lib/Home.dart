import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;
  bool _showLottie = true; // Flag to control Lottie visibility

  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('imagePath');
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
        _showLottie = false; // Hide Lottie when an image is loaded from SharedPreferences
      });
    }
  }

  Future<void> _saveImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', path);
  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    Navigator.pop(context);
    setState(() => _isLoading = true);

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _saveImage(image.path);
        _showLottie = false; // Hide Lottie when an image is selected
      });
    }

    setState(() => _isLoading = false);
  }

  Future<void> _pickImageFromCamera(BuildContext context) async {
    Navigator.pop(context);
    setState(() => _isLoading = true);

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      setState(() {
        _image = File(image.path);
        _saveImage(image.path);
        _showLottie = false; // Hide Lottie when an image is selected
      });
    }

    setState(() => _isLoading = false);
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SizedBox(
        height: 130,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt,color: Colors.deepPurpleAccent[200],),
              title: const Text('Camera',style: TextStyle(color: Colors.black),),
              onTap: () => _pickImageFromCamera(context),
            ),
            ListTile(
              leading: Icon(Icons.photo_library,color: Colors.deepPurpleAccent[200],),
              title: const Text('Gallery',style: TextStyle(color: Colors.black),),
              onTap: () => _pickImageFromGallery(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title:  Row(
            children: [
              Text("Options"),
            ],
          ),
          actions: [
           Column(
             children: [
               TextButton(
                 onPressed: () {
                   _showBottomSheet(context);
                 },
                 child: Row(
                   children: [
                     Icon(Icons.edit,color: Colors.deepPurpleAccent[200],),
                     Padding(
                       padding: const EdgeInsets.only(left:20.0),
                       child: Text("Edit",style: TextStyle(color: Colors.deepPurpleAccent[200],),),
                     ),
                   ],
                 ),
               ),
               TextButton(
                 onPressed: () {
                   // Handle delete option
                   setState(() {
                     _image = null; // Clear the selected image
                     _clearImage(); // Clear from SharedPreferences
                     _showLottie = true; // Show Lottie again
                   });
                   Navigator.of(context).pop(); // Close dialog
                 },
                 child: Row(
                   children: [
                     Icon(Icons.delete,color: Colors.deepPurpleAccent[200],),
                     Padding(
                       padding: const EdgeInsets.only(left: 20.0),
                       child: Text("Delete",style: TextStyle(color: Colors.deepPurpleAccent[200],),),
                     ),
                   ],
                 ),
               ),
             ],
           )
          ],
        );
      },
    );
  }

  Future<void> _clearImage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('imagePath');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Text("UPLOAD AN IMAGE",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,letterSpacing: 5)),
              ),
              Align(alignment: Alignment.topCenter,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Lottie animation in the background, controlled by _showLottie
                    if (_showLottie)
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Container(
                          width: 400,
                          height: 400,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Lottie.asset(
                            "assets/Lottiefiles/Animi dp.json", // Lottie animation
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    // Display image if selected, otherwise show plus icon
                    if (_image != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 150),
                        child: GestureDetector(
                          onLongPress: _showAlertDialog, // Show alert dialog on long press
                          child: ClipOval(
                            child: Image.file(
                              _image!,
                              width: 170, // Match the size of the Lottie background
                              height: 170, // Match the size of the Lottie background
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      )
                    else
                      Positioned(
                        bottom: 90,
                        right: 90,
                        child: InkWell(
                          onTap: () => _showBottomSheet(context),
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: Colors.deepPurpleAccent[200],
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

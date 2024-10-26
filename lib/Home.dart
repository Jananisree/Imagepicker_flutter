import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'ImageController.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  void _showBottomSheet(BuildContext context) {
    Get.bottomSheet(
      SizedBox(
        height: 130,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.deepPurpleAccent[200]),
              title: const Text('Camera', style: TextStyle(color: Colors.black)),
              onTap: () {
                Get.find<ImageController>().pickImageFromCamera();
                Get.back();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library, color: Colors.deepPurpleAccent[200]),
              title: const Text('Gallery', style: TextStyle(color: Colors.black)),
              onTap: () {
                Get.find<ImageController>().pickImageFromGallery();
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Options"),
        actions: [
          Column(
            children: [
              TextButton(
                onPressed: () {
                  _showBottomSheet(Get.context!);
                },
                child: Row(
                  children: [
                    Icon(Icons.edit, color: Colors.deepPurpleAccent[200]),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("Edit", style: TextStyle(color: Colors.deepPurpleAccent[200])),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.find<ImageController>().clearImage(); // Clear image
                  Get.back(); // Close dialog
                },
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.deepPurpleAccent[200]),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text("Delete", style: TextStyle(color: Colors.deepPurpleAccent[200])),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ImageController controller = Get.put(ImageController());

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() { // Listen to changes in observables
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text("UPLOAD AN IMAGE",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 5)),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Lottie animation in the background
                      if (controller.showLottie.value)
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Container(
                            width: 400,
                            height: 400,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Lottie.asset(
                              "assets/Lottiefiles/Animi dp.json",
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      // Display image if selected, otherwise show plus icon
                      if (controller.imagePath.value.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 150),
                          child: GestureDetector(
                            onLongPress: _showAlertDialog, // Show alert dialog on long press
                            child: ClipOval(
                              child: Image.file(
                                File(controller.imagePath.value),
                                width: 170,
                                height: 170,
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
            );
          }),
        ),
      ),
    );
  }
}

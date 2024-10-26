import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ImageController extends GetxController {
  var imagePath = ''.obs;
  var isLoading = false.obs;
  var showLottie = true.obs;

  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    _loadImage();
  }

  Future<void> _loadImage() async {
    final prefs = await SharedPreferences.getInstance();
    String? path = prefs.getString('imagePath');
    if (path != null) {
      imagePath.value = path;
      showLottie.value = false;
    }
  }

  Future<void> _saveImage(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', path);
  }

  Future<void> pickImageFromGallery() async {
    isLoading.value = true;
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imagePath.value = image.path;
      _saveImage(image.path);
      showLottie.value = false;
    }
    isLoading.value = false;
  }

  Future<void> pickImageFromCamera() async {
    isLoading.value = true;
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      imagePath.value = image.path;
      _saveImage(image.path);
      showLottie.value = false;
    }
    isLoading.value = false;
  }

  Future<void> clearImage() async {
    imagePath.value = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('imagePath');
    showLottie.value = true;
  }
}

import 'package:e_com/app/data/firebase/firebase_functions.dart';
import 'package:e_com/app/modules/admin/views/add_watch.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AdminController extends GetxController {
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final buttonPress = false.obs;
  final count = 0.obs;
  String imageurl = '';
  XFile? image;
  final hasImage = false.obs;
  final isNetwork = false.obs;
  final ImagePicker _picker = ImagePicker();

  final productNameController = TextEditingController();
  final productColorController = TextEditingController();
  final productHighlightsController = TextEditingController();
  final productPriceController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchRecords();
    FirebaseFirestore.instance
        .collection('watches')
        .snapshots()
        .listen((event) {
      mapRecords(event);
    });
  }

  @override
  void onClose() {}
  fetchRecords() async {
    var records = await FirebaseFirestore.instance.collection('watches').get();
    mapRecords(records);
  }

  String? validatePrice(String value) {
    if (value.isEmpty) {
      return 'Enter Price';
    }
    return null;
  }

  String? validateStrapColor(String value) {
    if (value.isEmpty) {
      return 'Enter Strap Color';
    }
    return null;
  }

  String? validateHighlights(String value) {
    if (value.isEmpty) {
      return 'Enter HighLights';
    }
    return null;
  }

  String? validateProductName(String value) {
    if (value.isEmpty) {
      return 'Enter Product Name';
    }
    return null;
  }

  void checkUploading({
    required bool isedit,
    String? id,
  }) async {
    buttonPress.value = true;
    isLoading.value = true;
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      isLoading.value = false;
      return;
    }
    loginFormKey.currentState!.save();
    if (image != null || imageurl.isNotEmpty) {
      uploadImage(
              id: id,
              imageurl: imageurl,
              isedit: isedit,
              highlights: productHighlightsController.text.trim(),
              image: image,
              price: int.parse(productPriceController.text.trim()),
              productName: productNameController.text.trim(),
              status: true,
              strapColor: productColorController.text.trim())
          .then((value) {
        // Get.back();

        productNameController.clear();
        productColorController.clear();
        productHighlightsController.clear();
        productPriceController.clear();
        image = null;
        hasImage.value = false;
        buttonPress.value = false;
        isLoading.value = false;
      });
    } else {
      Get.snackbar('Empty', 'Please Choose Image to Continue ',
          colorText: Colors.red);
    }
  }

  takeImage() async {
    image = await _picker.pickImage(
        imageQuality: 75,
        maxHeight: 512,
        maxWidth: 512,
        source: ImageSource.gallery);
    if (image != null) {
      hasImage.value = true;
      isNetwork.value = false;
    }
  }

  editView({
    required AdminController controller,
    required String name,
    required int price,
    required String id,
    required String highlights,
    required String color,
    required String imageUrl,
  }) {
    isNetwork.value = true;
    imageurl = imageUrl;
    controller.hasImage.value = true;
    controller.productColorController.text = color;
    controller.productHighlightsController.text = highlights;
    controller.productNameController.text = name;
    controller.productPriceController.text = price.toString();
    Get.to(() => AddWatch(
              isedit: true,
              id: id,
            ))!
        .then((value) {});
  }
}

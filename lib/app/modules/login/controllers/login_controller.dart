import 'package:e_com/app/modules/admin/views/admin_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:location/location.dart';

class LoginController extends GetxController {
  final box = GetStorage();
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final buttonPress = false.obs;

  final isPasswordVisible = true.obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    getUserLocation();
  }

  @override
  void onClose() {}
  String? validateUserName(String value) {
    if (value.length < 4) {
      return 'user name must be in 4 to 10 characters';
    } else if (value != 'Admin') {
      return 'User does not exists';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Enter Valid Password';
    } else if (value != 'Admin@123') {
      return 'Invalid Password';
    }
    return null;
  }

  void checkLogin(BuildContext context) async {
    isLoading.value = true;
    buttonPress.value = true;
    update();
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      isLoading.value = false;

      return;
    }
    loginFormKey.currentState!.save();
    loginFunction(context);
  }

  void passwordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void loginFunction(BuildContext context) {
    box.write('Login', true);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AdminView(),
        ));
  }

  getUserLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
  }
}

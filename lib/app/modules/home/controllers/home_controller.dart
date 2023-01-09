import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/app/data/firebase/firebase_functions.dart';
import 'package:e_com/app/service/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  bool selected = false;
  int index = -1;

  final count = 0.obs;
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

  selectUpdate({required bool select, required int index}) {
    selected = select;
    this.index = index;
    update();
  }

  Future logout(BuildContext context) async {
    AuthService().signOut();
    GetStorage().erase();
  }

  adminLogout() {
    GetStorage().erase();
    Get.offAndToNamed('/login');
  }
}

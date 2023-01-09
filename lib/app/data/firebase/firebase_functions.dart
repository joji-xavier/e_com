import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_com/app/modules/admin/views/models/watch_model.dart';
import 'package:e_com/app/modules/cart/views/cart_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart' show rootBundle;

final watches = <WatchModel>[].obs;
final cartId = <CartModel>[].obs;

final isLoading = false.obs;
final productId = [].obs;
String imageUrl = '';
mapRecords(QuerySnapshot<Map<String, dynamic>> records) async {
  isLoading.value = true;
  var list = records.docs
      .map((item) => WatchModel(
          productid: item.id,
          image: item["IMAGE"],
          highlights: item["HIGHLIGHTS"],
          price: item["PRICE"],
          productname: item["PRODUCTNAME"],
          status: item["STATUS"],
          strapcolor: item["STRAPCOLOR"]))
      .toList();

  watches.value = list;
  String jsonString = await rootBundle.loadString('assets/json/watches.json');

  final watche = watchModelFromJson(jsonString);
  for (var element in watche!) {
    watches.add(element!);
  }
  isLoading.value = false;
}

Future<void> addProduct(
    {required String imageUrl,
    required String strapColor,
    required bool status,
    required int price,
    required String highlights,
    required String productName}) async {
  var watch = WatchModel(
      productid: 'id',
      image: imageUrl,
      strapcolor: strapColor,
      status: status,
      price: price,
      highlights: highlights,
      productname: productName);
  FirebaseFirestore.instance
      .collection('watches')
      .add(watch.toJson())
      .then((value) {
    Get.snackbar('Uploaded', 'Product Successfully Uploaded',
        colorText: Colors.green);
    isLoading.value = false;
  });
}

deleteItem(String id) {
  FirebaseFirestore.instance.collection('watches').doc(id).delete();
}

updateItem(
    {required String id,
    required String imageUrl,
    required String strapColor,
    required bool status,
    required int price,
    required String highlights,
    required String productName}) {
  var watch = WatchModel(
      productid: id,
      image: imageUrl,
      strapcolor: strapColor,
      status: status,
      price: price,
      highlights: highlights,
      productname: productName);
  FirebaseFirestore.instance
      .collection('watches')
      .doc(id)
      .update(watch.toJson())
      .then((value) {
    Get.snackbar('Updated', 'Product Successfully Updated',
        colorText: Colors.green);
  });
}

Future<void> uploadImage(
    {XFile? image,
    String? id,
    String? imageurl,
    required String strapColor,
    required bool status,
    required int price,
    required String highlights,
    required bool isedit,
    required String productName}) async {
  isLoading.value = true;
  if (!isedit) {
    Reference ref =
        FirebaseStorage.instance.ref().child("images/${image!.name}");
    await ref.putFile(File(image.path));
    ref.getDownloadURL().then((value) {
      imageUrl = value;

      addProduct(
          status: status,
          price: price,
          highlights: highlights,
          strapColor: strapColor,
          imageUrl: value,
          productName: productName);
    });
  } else {
    if (image != null) {
      Reference ref =
          FirebaseStorage.instance.ref().child("images/${image.name}");
      await ref.putFile(File(image.path));
      ref.getDownloadURL().then((value) {
        imageUrl = value;

        updateItem(
            id: id!,
            status: status,
            price: price,
            highlights: highlights,
            strapColor: strapColor,
            imageUrl: value,
            productName: productName);
      });
    } else {
      updateItem(
          id: id!,
          status: status,
          price: price,
          highlights: highlights,
          strapColor: strapColor,
          imageUrl: imageurl!,
          productName: productName);
    }
  }
}

addToCart(
    {required String quntity, required String id, required String uuid}) async {
  isLoading.value = true;
  var cart = CartModel(
    productId: id,
    quntity: quntity,
  );

  await FirebaseFirestore.instance
      .collection('Cart')
      .doc(uuid)
      .collection('products')
      .add(cart.toJson());

  isLoading.value = false;
}

getItemsFromCart(String id) async {
  var records = await FirebaseFirestore.instance
      .collection('Cart')
      .doc(id)
      .collection('products')
      .get();
  cartRecords(records);
}

cartRecords(QuerySnapshot<Map<String, dynamic>> records) {
  cartId.clear();
  productId.clear();
  for (var element in records.docs) {
    productId.add(element['productId']);
  }
}

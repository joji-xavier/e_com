import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_com/app/core/widgets/input_field.dart';
import 'package:e_com/app/data/firebase/firebase_functions.dart';
import 'package:e_com/app/modules/admin/controllers/admin_controller.dart';

class AddWatch extends GetView<AdminController> {
  const AddWatch({
    required this.isedit,
    this.id,
  });
  final bool isedit;
  final String? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Obx(
              () => Form(
                autovalidateMode: controller.buttonPress.value
                    ? AutovalidateMode.onUserInteraction
                    : AutovalidateMode.disabled,
                key: controller.loginFormKey,
                child: Column(
                  children: [
                    !isedit
                        ? Text(
                            'Add Product',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          )
                        : Text(
                            'Edit Product',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                    SizedBox(
                      height: 40,
                    ),
                    InputField(
                        validator: (value) {
                          return controller.validateProductName(value!);
                        },
                        border: 8,
                        title: 'Product Name',
                        isHidden: false,
                        hint: 'Product Name',
                        isRequired: true,
                        controller: controller.productNameController,
                        readOnly: false,
                        keyboardType: TextInputType.name),
                    InputField(
                        validator: (value) {
                          return controller.validateStrapColor(value!);
                        },
                        border: 8,
                        title: 'Strap Color',
                        isHidden: false,
                        hint: 'Strap Color',
                        isRequired: true,
                        controller: controller.productColorController,
                        readOnly: false,
                        keyboardType: TextInputType.name),
                    InputField(
                        validator: (value) {
                          return controller.validateHighlights(value!);
                        },
                        border: 8,
                        maxline: 10,
                        title: 'Highlights',
                        isHidden: false,
                        hint: 'Highlights',
                        isRequired: true,
                        controller: controller.productHighlightsController,
                        readOnly: false,
                        keyboardType: TextInputType.name),
                    InputField(
                        validator: (value) {
                          return controller.validatePrice(value!);
                        },
                        border: 8,
                        title: 'Price',
                        isHidden: false,
                        hint: 'Price',
                        isRequired: true,
                        controller: controller.productPriceController,
                        readOnly: false,
                        keyboardType: TextInputType.number),
                    controller.hasImage.value
                        ? controller.isNetwork.value
                            ? GestureDetector(
                                onTap: () {
                                  controller.hasImage.value = false;
                                  controller.takeImage();
                                },
                                child: SizedBox(
                                    height: 250,
                                    child: Image.network(controller.imageurl)),
                              )
                            : GestureDetector(
                                onTap: () {
                                  controller.hasImage.value = false;
                                  controller.takeImage();
                                },
                                child: SizedBox(
                                    height: 250,
                                    child: Image.file(
                                        File(controller.image!.path))),
                              )
                        : GestureDetector(
                            onTap: () {
                              controller.takeImage();
                            },
                            child: DottedBorder(
                              strokeWidth: 2,
                              color: const Color(0xffDFE0DF),
                              dashPattern: const [8, 4],
                              child: SizedBox(
                                height: 130,
                                width: 367,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      height: 27,
                                    ),
                                    Icon(
                                      Icons.camera_alt_rounded,
                                      color: Colors.orange,
                                    ),
                                    const SizedBox(
                                      height: 21,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      child: const Center(
                                        child: Text(
                                          'Take a photo',
                                          style: TextStyle(
                                              color: Color(0xff081C36),
                                              fontSize: 12),
                                        ),
                                      ),
                                      height: 30,
                                      width: 155,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.orange),
                                    ),
                                    const SizedBox(
                                      height: 27,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    SizedBox(
                      height: 50,
                    ),
                    isLoading.value
                        ? CircularProgressIndicator()
                        : isedit
                            ? ElevatedButton(
                                onPressed: () {
                                  controller.checkUploading(
                                      isedit: true, id: id);
                                },
                                child: Text('Update'))
                            : ElevatedButton(
                                onPressed: () {
                                  controller.checkUploading(
                                    isedit: false,
                                  );
                                },
                                child: Text('Add Product'))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

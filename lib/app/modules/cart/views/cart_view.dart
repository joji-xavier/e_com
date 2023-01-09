import 'package:e_com/app/core/widgets/product_card.dart';
import 'package:e_com/app/data/firebase/firebase_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  final cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          'Cart',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Obx(() => productId.isEmpty
          ? Center(child: Text('No Products'))
          : Container(
              margin: EdgeInsets.all(20),
              child: ListView.builder(
                  itemCount: watches.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: Visibility(
                        visible: productId.contains(watches[index].productid),
                        child: ProductCard(
                          index: index,
                          isCart: true,
                          userid: FirebaseAuth.instance.currentUser!.uid,
                          isAdmin: false,
                          imageUrl: watches[index].image!,
                          id: watches[index].productid!,
                          name: watches[index].productname!,
                          price: watches[index].price!,
                        ),
                      ),
                    );
                  }),
            )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:e_com/app/data/firebase/firebase_functions.dart';
import 'package:e_com/app/modules/admin/controllers/admin_controller.dart';
import 'package:e_com/app/modules/cart/controllers/cart_controller.dart';

class ProductCard extends StatelessWidget {
  final cartController = Get.put(CartController());
  final String name;
  final int price;
  final String id;
  final String? discription;
  final String? color;
  final String imageUrl;
  final bool isAdmin;
  final String? userid;
  final bool? isCart;
  final int index;
  ProductCard({
    Key? key,
    required this.name,
    required this.price,
    required this.id,
    this.discription,
    this.color,
    required this.imageUrl,
    required this.isAdmin,
    this.userid,
    this.isCart,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      width: MediaQuery.of(context).size.width,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(height: 100, child: Image.network(imageUrl)),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Text(
                    '₹$price',
                    style: TextStyle(fontSize: 20),
                  ),
                  isAdmin
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GetBuilder<AdminController>(
                              init: AdminController(),
                              initState: (_) {},
                              builder: (_) {
                                return IconButton(
                                    onPressed: () {
                                      _.editView(
                                          controller: _,
                                          color: color!,
                                          highlights: discription!,
                                          id: id,
                                          imageUrl: imageUrl,
                                          name: name,
                                          price: price);
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.black,
                                    ));
                              },
                            ),
                            IconButton(
                                onPressed: () {
                                  deleteItem(id);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ))
                          ],
                        )
                      : isCart != null
                          ? GestureDetector(
                              onTap: () {
                                cartController.makePayment(
                                    context, price.toString(), id);
                              },
                              child: Container(
                                height: 40,
                                width: 100,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Card(
                                  color: Colors.orange,
                                  elevation: 8,
                                  child: Center(
                                    child: Text('Buy'),
                                  ),
                                ),
                              ),
                            )
                          : Obx(() => isLoading.value &&
                                  index == cartController.index
                              ? CircularProgressIndicator()
                              : GestureDetector(
                                  onTap: () {
                                    cartController.index = index;
                                    addToCart(
                                        id: id, quntity: '1', uuid: userid!);
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Card(
                                      color: Colors.orange,
                                      elevation: 8,
                                      child: Center(
                                        child: Text('Add To Cart'),
                                      ),
                                    ),
                                  ),
                                ))
                ],
              )
            ],
          ),
        ),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}

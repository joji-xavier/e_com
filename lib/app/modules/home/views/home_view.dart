import 'package:e_com/app/core/widgets/drawer_items.dart';
import 'package:e_com/app/core/widgets/product_card.dart';
import 'package:e_com/app/data/firebase/firebase_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: const EdgeInsets.all(0),
            children: [
              DrawerHeader(
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(4.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 35,
                            child: Text(
                              FirebaseAuth
                                  .instance.currentUser!.displayName![0],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 6,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                FirebaseAuth.instance.currentUser!.displayName!,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    height: 200,
                    color: Colors.orange,
                  )),
              GetBuilder<HomeController>(
                builder: (controller) {
                  return AppDraderItems(
                    index: controller.index,
                    id: 0,
                    selected: controller.selected,
                    onPress: () {
                      getItemsFromCart(FirebaseAuth.instance.currentUser!.uid);
                      controller.selectUpdate(index: 0, select: true);

                      Get.toNamed('/cart');
                    },
                    title: 'Cart',
                  );
                },
              ),
              GetBuilder<HomeController>(
                builder: (_) {
                  return AppDraderItems(
                    index: _.index,
                    id: 1,
                    selected: _.selected,
                    onPress: () {
                      controller.selectUpdate(select: true, index: 1);
                      controller.logout(context);
                    },
                    title: 'Log Out',
                  );
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(
            'Products',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Obx(() => isLoading.value
            ? CircularProgressIndicator()
            : watches.isEmpty
                ? Center(child: Text('No Products'))
                : Container(
                    margin: EdgeInsets.all(20),
                    child: ListView.builder(
                        itemCount: watches.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 5),
                            child: watches[index].status!
                                ? ProductCard(
                                    index: index,
                                    userid:
                                        FirebaseAuth.instance.currentUser!.uid,
                                    isAdmin: false,
                                    imageUrl: watches[index].image!,
                                    id: watches[index].productid!,
                                    name: watches[index].productname!,
                                    price: watches[index].price!,
                                  )
                                : SizedBox(),
                          );
                        }),
                  )));
  }
}

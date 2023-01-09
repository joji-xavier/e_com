import 'package:e_com/app/core/widgets/drawer_items.dart';
import 'package:e_com/app/core/widgets/product_card.dart';
import 'package:e_com/app/data/firebase/firebase_functions.dart';
import 'package:e_com/app/modules/admin/views/add_watch.dart';
import 'package:e_com/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/admin_controller.dart';

class AdminView extends GetView<AdminController> {
  final adminController = Get.put(AdminController());
  @override
  Widget build(BuildContext context) {
    controller.fetchRecords();
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
                              'A',
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
                                'Admin',
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
                builder: (_) {
                  return AppDraderItems(
                    index: _.index,
                    id: 0,
                    selected: _.selected,
                    onPress: () {
                      _.selectUpdate(select: true, index: 0);
                      _.adminLogout();
                    },
                    title: 'Log Out',
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            tooltip: 'Add New Product',
            onPressed: () {
              controller.productColorController.clear();
              controller.productHighlightsController.clear();
              controller.productNameController.clear();
              controller.productPriceController.clear();
              Get.to(() => AddWatch(
                    isedit: false,
                  ));
            }),
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Admin Panel',
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: Obx(() => watches.isEmpty
            ? Center(child: Text('No Products'))
            : Container(
                margin: EdgeInsets.all(20),
                child: ListView.builder(
                    itemCount: watches.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: ProductCard(
                          index: index,
                          isAdmin: true,
                          imageUrl: watches[index].image!,
                          id: watches[index].productid.toString(),
                          name: watches[index].productname!,
                          price: watches[index].price!,
                          color: watches[index].strapcolor,
                          discription: watches[index].highlights,
                        ),
                      );
                    }),
              )));
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  Stripe.publishableKey =
      "pk_test_51LtR7tSBKw9BKHpciAspUmtrKO1tAwZQXu6a9fujy6Wp1bLlv64dCgXDWR6k4URgKiY2zP0ckjO1WO1oOIPyZAxX00AnOmpnKJ";
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}

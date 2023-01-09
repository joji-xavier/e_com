import 'dart:convert';

import 'package:e_com/app/data/firebase/firebase_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  int index = -1;
  var SECRET_KEY =
      'sk_test_51LtR7tSBKw9BKHpcorlfXjm8cDEcGrQSBoPo5wtt84sqVVd8h5ujoRiKqwp1smz9dy1v74u2FAXV9VrhtoRfYSHB003CYpCdzx';
  Map<String, dynamic>? paymentIntent;
  @override
  void onInit() {
    super.onInit();
    if (FirebaseAuth.instance.currentUser != null) {
      getItemsFromCart(FirebaseAuth.instance.currentUser!.uid);
    }
  }

  @override
  void onClose() {}
  Future<void> makePayment(
      BuildContext context, String price, String id) async {
    try {
      paymentIntent = await createPaymentIntent(price, 'INR');

      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret: paymentIntent!['client_secret'],
                  style: ThemeMode.dark,
                  merchantDisplayName: 'VinokhaTek'))
          .then((value) {});

      displayPaymentSheet(context, id);
    } catch (e) {}
  }

  displayPaymentSheet(BuildContext context, String id) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) {
        deleteItem(id);
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle,
                            color: Colors.green,
                          ),
                          Text("Payment Successfull"),
                        ],
                      ),
                    ],
                  ),
                ));

        paymentIntent = null;
      }).onError((error, stackTrace) {});
    } on StripeException {
      showDialog(
          context: context,
          builder: (_) => const AlertDialog(
                content: Text("Cancelled "),
              ));
    }
  }

  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
        body: body,
      );

      return jsonDecode(response.body);
    } catch (err) {}
  }

  calculateAmount(String amount) {
    final calculatedAmout = (int.parse(amount) * 100);
    return calculatedAmout.toString();
  }
}

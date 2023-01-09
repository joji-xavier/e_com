import 'dart:convert';

CartModel cartModelFromJson(String str) => CartModel.fromJson(json.decode(str));

String cartModelToJson(CartModel data) => json.encode(data.toJson());

class CartModel {
  String productId;
  String quntity;
  CartModel({
    required this.productId,
    required this.quntity,
  });

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        productId: json["productId"],
        quntity: json["quntity"],
      );

  Map<String, dynamic> toJson() => {
        "productId": productId,
        "quntity": quntity,
      };
}

// To parse this JSON data, do
//
//     final watchModel = watchModelFromJson(jsonString);

import 'dart:convert';

List<WatchModel?>? watchModelFromJson(String str) => json.decode(str) == null
    ? []
    : List<WatchModel?>.from(
        json.decode(str)!.map((x) => WatchModel.fromJson(x)));

String watchModelToJson(List<WatchModel?>? data) => json.encode(
    data == null ? [] : List<dynamic>.from(data.map((x) => x!.toJson())));

class WatchModel {
  WatchModel({
    required this.productid,
    required this.productname,
    required this.strapcolor,
    required this.highlights,
    required this.price,
    required this.status,
    required this.image,
  });

  String? productid;
  String? productname;
  String? strapcolor;
  String? highlights;
  int? price;
  bool? status;
  String? image;

  factory WatchModel.fromJson(Map<String, dynamic> json) => WatchModel(
        productid: json["PRODUCTID"].toString(),
        productname: json["PRODUCTNAME"],
        strapcolor: json["STRAPCOLOR"],
        highlights: json["HIGHLIGHTS"],
        price: json["PRICE"],
        status: json["STATUS"],
        image: json["IMAGE"],
      );

  Map<String, dynamic> toJson() => {
        "PRODUCTID": productid,
        "PRODUCTNAME": productname,
        "STRAPCOLOR": strapcolor,
        "HIGHLIGHTS": highlights,
        "PRICE": price,
        "STATUS": status,
        "IMAGE": image,
      };
}

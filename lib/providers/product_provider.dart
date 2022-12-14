import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;

import '../models/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> list_products = [];

  final categories = <String>[];

  final baseUrl = 'https://fakestoreapi.com';

  void getProduct() async {
    var url = '${baseUrl}/products';
    var client = http.Client();
    var rs = await client.get(Uri.parse(url));
    var jsonString = rs.body; // Chuỗi
    var jsonObject = jsonDecode(jsonString) as List;

    // Chuyển chuoi thành json
    list_products = jsonObject.map((item) {
      return ProductModel.fromJson(item);
    }).toList();
    // print(list.length) ;
    notifyListeners(); // Thông báo
  }

  Future<List<String>> getCategory() async {
    var url = '${baseUrl}/products/categories';
    var client = http.Client();
    var rs = await client.get(Uri.parse(url));

    var jsonObject = jsonDecode(rs.body);

    for (var category in jsonObject) {
      if (categories.contains(category)) {
        break;
      } else {
        categories.add(category);
      }
    }
    return categories;

    // print(jsonObject.runtimeType) ;

    notifyListeners();

    //   return
    // }).toList();
    // print(list) ;
  }
}

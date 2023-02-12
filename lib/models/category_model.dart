// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class CategoryModel {
  String category;

  CategoryModel({
    required this.category,
  });

  factory CategoryModel.mapping(Map<String, dynamic> object) {
    return CategoryModel(
      category: object['category'],
    );
  }

  static Future<List<CategoryModel>?> getAll(endpoint) async {
    try {
      var url = "https://newsroom.pikiran-rakyat.com/api/$endpoint";
      var urlData = Uri.parse(url);
      var resultData = await http.get(urlData, headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer hh9lPlndDnRiDF7RYcmMgwylZDnokHihUwFLseDuL8yTZ8tOttcVm6JHZk0R',
      });
      if (resultData.statusCode == 200) {
        var jsonData = jsonDecode(resultData.body);
        List<CategoryModel> datas = [];
        for (int i = 0; i < jsonData['data'].length; i++) {
          datas.add(CategoryModel.mapping(jsonData['data'][i]));
        }
        return datas;
      } else {
        return null;
      }
    } catch (err) {
      print(err);
      return null;
    }
  }
}

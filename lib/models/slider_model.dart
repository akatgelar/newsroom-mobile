// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class SliderModel {
  int id;
  String title;
  String slug;
  String image;
  String category;
  String tags;
  String creator;
  String source;
  String created_at;
  int created_by;
  int count_view;

  SliderModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.image,
    required this.category,
    required this.tags,
    required this.creator,
    required this.source,
    required this.created_at,
    required this.created_by,
    required this.count_view,
  });

  factory SliderModel.mapping(Map<String, dynamic> object) {
    return SliderModel(
      id: object['id'],
      title: object['title'],
      slug: object['slug'],
      image: 'https://newsroom.pikiran-rakyat.com/api${object['image']}',
      category: object['category'],
      tags: object['tags'],
      creator: object['creator'],
      source: object['source'],
      created_at: object['created_at'],
      created_by: object['created_by'],
      count_view: object['count_view'],
    );
  }

  static Future<List<SliderModel>?> getAll(
      int per_page, int page, String sort) async {
    try {
      var url = "https://newsroom.pikiran-rakyat.com/api/slider";
      url += "?per_page=$per_page&page=$page&sort=$sort";
      var urlData = Uri.parse(url);
      var resultData = await http.get(urlData, headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer hh9lPlndDnRiDF7RYcmMgwylZDnokHihUwFLseDuL8yTZ8tOttcVm6JHZk0R',
      });
      if (resultData.statusCode == 200) {
        var jsonData = jsonDecode(resultData.body);
        List<SliderModel> datas = [];
        for (int i = 0; i < jsonData['data'].length; i++) {
          datas.add(SliderModel.mapping(jsonData['data'][i]));
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

  static Future<SliderModel?> getById(String id) async {
    try {
      var url = "https://newsroom.pikiran-rakyat.com/api/slider/" + id;
      var urlData = Uri.parse(url);
      var resultData = await http.get(urlData, headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer hh9lPlndDnRiDF7RYcmMgwylZDnokHihUwFLseDuL8yTZ8tOttcVm6JHZk0R',
      });
      if (resultData.statusCode == 200) {
        var jsonData = jsonDecode(resultData.body);
        return SliderModel.mapping(jsonData['data']);
      } else {
        return null;
      }
    } catch (err) {
      print(err);
      return null;
    }
  }
}

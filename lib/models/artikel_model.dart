// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class ArtikelModel {
  int id;
  String title;
  String slug;
  String image;
  String category;
  String tags;
  String desc_short;
  String desc_long;
  String creator;
  String source;
  String created_at;
  int created_by;
  int count_view;

  ArtikelModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.image,
    required this.category,
    required this.tags,
    required this.desc_short,
    required this.desc_long,
    required this.creator,
    required this.source,
    required this.created_at,
    required this.created_by,
    required this.count_view,
  });

  factory ArtikelModel.mapping(Map<String, dynamic> object) {
    return ArtikelModel(
      id: object['id'],
      title: object['title'],
      slug: object['slug'],
      image: 'https://newsroom.pikiran-rakyat.com/api${object['image']}',
      category: object['category'],
      tags: object['tags'],
      desc_short: object['desc_short'],
      desc_long: object['desc_long'] ?? '',
      creator: object['creator'],
      source: object['source'],
      created_at: object['created_at'],
      created_by: object['created_by'],
      count_view: object['count_view'],
    );
  }

  static Future<List<ArtikelModel>?> getAll(
      int per_page, int page, String sort) async {
    try {
      var url = "https://newsroom.pikiran-rakyat.com/api/artikel";
      url += "?per_page=$per_page&page=$page&sort=$sort";
      var urlData = Uri.parse(url);
      var resultData = await http.get(urlData, headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer hh9lPlndDnRiDF7RYcmMgwylZDnokHihUwFLseDuL8yTZ8tOttcVm6JHZk0R',
      });
      if (resultData.statusCode == 200) {
        var jsonData = jsonDecode(resultData.body);
        List<ArtikelModel> datas = [];
        for (int i = 0; i < jsonData['data'].length; i++) {
          datas.add(ArtikelModel.mapping(jsonData['data'][i]));
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

  static Future<ArtikelModel?> getById(String id) async {
    try {
      var url = "https://newsroom.pikiran-rakyat.com/api//artikel/" + id;
      var urlData = Uri.parse(url);
      var resultData = await http.get(urlData, headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer hh9lPlndDnRiDF7RYcmMgwylZDnokHihUwFLseDuL8yTZ8tOttcVm6JHZk0R',
      });
      if (resultData.statusCode == 200) {
        var jsonData = jsonDecode(resultData.body);
        return ArtikelModel.mapping(jsonData['data']);
      } else {
        return null;
      }
    } catch (err) {
      print(err);
      return null;
    }
  }
}

// ignore_for_file: non_constant_identifier_names, avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;

class VideoModel {
  int id;
  String title;
  String slug;
  String image;
  String category;
  String tags;
  String desc_short;
  String desc_long;
  String link_type;
  String link;
  String creator;
  String source;
  String created_at;
  int created_by;
  int count_view;

  VideoModel({
    required this.id,
    required this.title,
    required this.slug,
    required this.image,
    required this.category,
    required this.tags,
    required this.desc_short,
    required this.desc_long,
    required this.link_type,
    required this.link,
    required this.creator,
    required this.source,
    required this.created_at,
    required this.created_by,
    required this.count_view,
  });

  factory VideoModel.mapping(Map<String, dynamic> object) {
    return VideoModel(
      id: object['id'],
      title: object['title'],
      slug: object['slug'],
      image: 'https://newsroom.pikiran-rakyat.com/api${object['image']}',
      category: object['category'],
      tags: object['tags'],
      desc_short: object['desc_short'],
      desc_long: object['desc_long'] ?? '',
      link_type: object['link_type'],
      creator: object['creator'],
      link: object['link'],
      source: object['source'],
      created_at: object['created_at'],
      created_by: object['created_by'],
      count_view: object['count_view'],
    );
  }

  static Future<List<VideoModel>?> getAll(
      int per_page, int page, String sort) async {
    try {
      var url = "https://newsroom.pikiran-rakyat.com/api/video";
      url += "?per_page=$per_page&page=$page&sort=$sort";
      var urlData = Uri.parse(url);
      var resultData = await http.get(urlData, headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer hh9lPlndDnRiDF7RYcmMgwylZDnokHihUwFLseDuL8yTZ8tOttcVm6JHZk0R',
      });
      if (resultData.statusCode == 200) {
        var jsonData = jsonDecode(resultData.body);
        List<VideoModel> datas = [];
        for (int i = 0; i < jsonData['data'].length; i++) {
          datas.add(VideoModel.mapping(jsonData['data'][i]));
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

  static Future<VideoModel?> getById(String id) async {
    try {
      var url = "https://newsroom.pikiran-rakyat.com/api//video/" + id;
      var urlData = Uri.parse(url);
      var resultData = await http.get(urlData, headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'Bearer hh9lPlndDnRiDF7RYcmMgwylZDnokHihUwFLseDuL8yTZ8tOttcVm6JHZk0R',
      });
      if (resultData.statusCode == 200) {
        var jsonData = jsonDecode(resultData.body);
        return VideoModel.mapping(jsonData['data']);
      } else {
        return null;
      }
    } catch (err) {
      print(err);
      return null;
    }
  }
}

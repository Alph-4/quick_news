import 'dart:convert';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quick_news/src/data/model/headline_new.dart';
import 'package:quick_news/src/fondation/constants.dart';

final newsProvider = Provider((ref) => NewsService());

class NewsService {
  Future<List<HeadLinesNews>> fetchHeadLineNews(
      {required String country, String? query}) async {
    final params = <String, String>{
      'country': country,
      'apiKey': Constants.of().apiKey,
    };

    if (query != null) {
      params['q'] = query;
    }

    final response =
        await http.get(Uri.https('newsapi.org', 'v2/top-headlines', params));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        final dataList = (jsonData['articles'] as List<dynamic>)
            .map((json) => HeadLinesNews.fromJson(json))
            .toList();

        return dataList;
      } else {
        throw Exception(jsonData['message']);
      }
    } else {
      throw Exception('Failed to load news');
    }
  }

   Future<List<HeadLinesNews>> fetchNewsByCategory(
      {required String country, String? category, String? query}) async {
    final params = <String, String>{
      'country': country,
      'apiKey': Constants.of().apiKey,
    };

    if (category != null) {
      params['category'] = category;
    }

    if (query != null) {
      params['q'] = query;
    }

    final response =
        await http.get(Uri.https('newsapi.org', 'v2/top-headlines', params));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        final dataList = (jsonData['articles'] as List<dynamic>)
            .map((json) => HeadLinesNews.fromJson(json))
            .toList();

        return dataList;
      } else {
        throw Exception(jsonData['message']);
      }
    } else {
      throw Exception('Failed to load news');
    }
  }
}

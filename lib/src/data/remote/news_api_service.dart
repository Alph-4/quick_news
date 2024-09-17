import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:quick_news/src/data/model/news.dart';
import 'package:quick_news/src/data/model/media.dart';
import 'package:quick_news/src/fondation/constants.dart';

final newsApiProvider = Provider((ref) => NewsService());

class NewsService {
  Future<List<NewModel>> fetchHeadLineNews(
      {required String country, String? query}) async {
    final params = <String, String>{
      'country': country,
      'apiKey': Constants.of().apiKey,
    };

    if (query != null) {
      params['q'] = query;
    }

    print('fetchHeadLineNews: started, params: $params');

    final response =
        await http.get(Uri.https('newsapi.org', 'v2/top-headlines', params));
    final newsBox = Hive.box<NewModel>(newsBoxName);

    print('fetchHeadLineNews: response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      print('fetchHeadLineNews: response data: $jsonData');

      if (jsonData['status'] == 'ok') {
        final dataList = (jsonData['articles'] as List<dynamic>)
            .map((json) => NewModel.fromJson(json))
            .toList();

        await newsBox.clear();
        await newsBox.addAll(dataList);

        print('fetchHeadLineNews: completed, data length: ${dataList.length}');

        return dataList;
      } else {
        print('fetchHeadLineNews: error: ${jsonData['message']}');
        return newsBox.values.toList();
      }
    } else {
      print('fetchHeadLineNews: error: Failed to load news');
      return newsBox.values.toList();
    }
  }

  Future<List<NewModel>> fetchNewsByCategory(
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
            .map((json) => NewModel.fromJson(json))
            .toList();

        return dataList;
      } else {
        throw Exception(jsonData['message']);
      }
    } else {
      throw Exception('Failed to load news');
    }
  }

  Future<List<NewModel>> fetchSearchNews({
    required String query,
    String? language,
    String? sortBy,
  }) async {
    final params = <String, String>{
      'q': query,
      'sortBy': query,
      'apiKey': Constants.of().apiKey,
    };

    final response =
        await http.get(Uri.https('newsapi.org', 'v2/everything', params));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        final dataList = (jsonData['articles'] as List<dynamic>)
            .map((json) => NewModel.fromJson(json))
            .toList();

        return dataList;
      } else {
        throw Exception(jsonData['message']);
      }
    } else {
      throw Exception('Failed to load news');
    }
  }

  /// Fetches a list of media sources from the News API.
  ///
  /// This call is identical to [fetchHeadLineNews] but returns a list of
  /// [Media] objects instead of [NewModel] objects.
  ///
  /// The [country], [category] and [language] parameters are optional.
  ///
  /// Throws an [Exception] if the API call fails.
  Future<List<Media>> fetchMedia({
    String? country,
    String? category,
    String? language,
  }) async {
    final mediaBox = Hive.box<Media>(mediaBoxName);

    final params = <String, String>{
      'apiKey': Constants.of().apiKey,
    };

    if (country != null) {
      params['country'] = country;
    }

    if (category != null) {
      params['category'] = category;
    }

    if (language != null) {
      params['language'] = language;
    }

    final response = await http
        .get(Uri.https('newsapi.org', 'v2/top-headlines/sources', params));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      if (jsonData['status'] == 'ok') {
        final dataList = (jsonData['sources'] as List<dynamic>)
            .map((json) => Media.fromJson(json))
            .toList();

        await mediaBox.clear();
        await mediaBox.addAll(dataList);

        return dataList; // Add this return statement
      } else {
        return throw Exception(jsonData['message']);
      }
    } else {
      throw Exception('Failed to load media');
    }
  }
}

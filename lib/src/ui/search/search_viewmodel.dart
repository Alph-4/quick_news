import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/data/model/headline_new.dart';
import 'package:quick_news/src/data/repository/search_news_repository_impl.dart';

final searchNewsViewModelProvider =
    ChangeNotifierProvider((ref) => SearchNewsViewModel(ref));

class SearchNewsViewModel with ChangeNotifier {
  SearchNewsViewModel(this.ref);

  final Ref ref;
  late final SearchNewsRepositoryImpl _repository =
      ref.read(searchNewsRepositoryProvider);

  String _query = '';
  String get query => _query;

  String sortBy = "publishedAt";

  List<Article>? _searchNews;
  List<Article>? get searchNews => _searchNews;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void updateQuery(String query, String languageCode) {
    _query = query;
    notifyListeners();
    if (_query.isEmpty) {
    } else {
      fetchSearchNews(languageCode);
    }
  }

  Future<void> fetchSearchNews(String languageCode) async {
    _isLoading = true;
    notifyListeners();

    final stopwatch = Stopwatch()..start();
    print('fetchSearchNews: started');
    try {
      final newArticleList =
          await _repository.searchNews(_query, languageCode, sortBy);
      print(
          'fetchSearchNews: completed in ${stopwatch.elapsed.inMilliseconds}ms');
      _searchNews = newArticleList;
    } catch (e, stackTrace) {
      print('fetchSearchNews: error: $e');
      print(stackTrace);
      rethrow;
    }

    _isLoading = false;
    notifyListeners();
  }
}

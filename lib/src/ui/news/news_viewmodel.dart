import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/data/model/news.dart';
import 'package:quick_news/src/data/repository/news_repository_impl.dart';
import 'package:quick_news/src/fondation/constants.dart';

final newsViewModelProvider =
    ChangeNotifierProvider((ref) => NewsViewModel(ref));

class NewsViewModel with ChangeNotifier {
  NewsViewModel(this.ref);

  final Ref ref;
  late final NewsRepositoryImpl _repository = ref.read(newsRepositoryProvider);

  String _selectedCategory = '';
  String get selectedCategory => _selectedCategory;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<NewModel>? _headlineNews;
  List<NewModel>? get headlineNews => _headlineNews;

  final newsBox = Hive.box<NewModel>(newsBoxName);

  void updateCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
    if (selectedCategory.isEmpty) {
      fetchHeadLineNews();
    } else {
      fetchHeadLineNewsByCategory(_selectedCategory);
    }
  }

  Future<void> fetchHeadLineNews() async {
    _isLoading = true;
    notifyListeners();
    final stopwatch = Stopwatch()..start();
    print('fetchHeadLineNews: started');
    try {
      final headLineNewsList = await _repository.fetchHeadLineNews();
      print(
          'fetchHeadLineNews: completed in ${stopwatch.elapsed.inMilliseconds}ms');
      _headlineNews = headLineNewsList;
    } catch (e, stackTrace) {
      _headlineNews = newsBox.values.toList();
      print('fetchHeadLineNews: error: $e');
      _isLoading = false;
      notifyListeners();
      print(stackTrace);
      rethrow;
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchHeadLineNewsByCategory(String selectedCategory) async {
    _isLoading = true;
    notifyListeners();
    final stopwatch = Stopwatch()..start();
    print('fetchHeadLineNewsByCategory: started');
    try {
      final headLineNewsList =
          await _repository.fetchHeadLineNewsByCategory(selectedCategory);
      print(
          'fetchHeadLineNewsByCategory: completed in ${stopwatch.elapsed.inMilliseconds}ms');
      _headlineNews = headLineNewsList;
    } catch (e, stackTrace) {
      _headlineNews = newsBox.values.toList();
      _isLoading = false;
      notifyListeners();
      print('fetchHeadLineNewsByCategory: error: $e');
      print(stackTrace);
      rethrow;
    }
    _isLoading = false;
    notifyListeners();
  }
}

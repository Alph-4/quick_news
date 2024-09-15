import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/data/model/headline_new.dart';
import 'package:quick_news/src/data/repository/news_repository_impl.dart';

final newsViewModelProvider =
    ChangeNotifierProvider((ref) => NewsViewModel(ref));

final headlineNewsProvider = FutureProvider<List<HeadLinesNews>>((ref) async {
  return ref.read(newsRepositoryProvider).fetchHeadLineNews();
});

class NewsViewModel with ChangeNotifier {
  NewsViewModel(this.ref);

  final Ref ref;
  late final NewsRepositoryImpl _repository = ref.read(newsRepositoryProvider);

  String _selectedCategory = '';
  String get selectedCategory => _selectedCategory;

  void updateCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
    if (selectedCategory.isEmpty) {
      fetchHeadLineNews();
    } else {
      fetchHeadLineNewsByCategory(_selectedCategory);
    }
  }

  Future<List<HeadLinesNews>> fetchHeadLineNews() async {
    final stopwatch = Stopwatch()..start();
    print('fetchHeadLineNews: started');
    try {
      final headLineNewsList = await _repository.fetchHeadLineNews();
      print(
          'fetchHeadLineNews: completed in ${stopwatch.elapsed.inMilliseconds}ms');
      return headLineNewsList;
    } catch (e, stackTrace) {
      print('fetchHeadLineNews: error: $e');
      print(stackTrace);
      rethrow;
    }
  }

  Future<List<HeadLinesNews>> fetchHeadLineNewsByCategory(
      String selectedCategory) async {
    final stopwatch = Stopwatch()..start();
    print('fetchHeadLineNewsByCategory: started');
    try {
      final headLineNewsList =
          await _repository.fetchHeadLineNewsByCategory(selectedCategory);
      print(
          'fetchHeadLineNewsByCategory: completed in ${stopwatch.elapsed.inMilliseconds}ms');
      return headLineNewsList;
    } catch (e, stackTrace) {
      print('fetchHeadLineNewsByCategory: error: $e');
      print(stackTrace);
      rethrow;
    }
  }
}

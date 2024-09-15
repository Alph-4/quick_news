import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/data/model/headline_new.dart';
import 'package:quick_news/src/data/repository/news_repository_impl.dart';

final newsViewModelProvider =
    ChangeNotifierProvider((ref) => NewsViewModel(ref));

class NewsViewModel with ChangeNotifier {
  NewsViewModel(this.ref);

  final Ref ref;
  late final NewsRepositoryImpl _repository = ref.read(newsRepositoryProvider);


  Future<List<HeadLinesNews>> fetchHeadLineNews() {
    return _repository.fetchHeadLineNews().then((value) {
      return value;
    });
  }


  Future<List<HeadLinesNews>> fetchHeadLineNewsByCategory(String selectedCategory) {
    return _repository.fetchHeadLineNewsByCategory();
  }
}

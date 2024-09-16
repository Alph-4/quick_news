import 'package:quick_news/src/data/model/headline_new.dart';

abstract class NewsRepository {
  Future<List<Article>> fetchHeadLineNews();
  Future<List<Article>> fetchHeadLineNewsByCategory(String selectedCategory);
}

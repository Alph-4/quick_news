import 'package:quick_news/src/data/model/news.dart';

abstract class NewsRepository {
  Future<List<NewModel>> fetchHeadLineNews();
  Future<List<NewModel>> fetchHeadLineNewsByCategory(String selectedCategory);
}

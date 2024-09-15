import 'package:quick_news/src/data/model/headline_new.dart';

abstract class NewsRepository {
 Future<List<HeadLinesNews>> fetchHeadLineNews();
  Future<List<HeadLinesNews>> fetchHeadLineNewsByCategory(String selectedCategory);
}

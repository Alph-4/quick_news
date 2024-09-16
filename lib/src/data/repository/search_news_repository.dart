import 'package:quick_news/src/data/model/news.dart';

abstract class SearchNewsRepository {
  Future<List<NewModel>> searchNews(
      String query, String language, String sortBy);
}

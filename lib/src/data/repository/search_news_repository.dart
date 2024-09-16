import 'package:quick_news/src/data/model/headline_new.dart';

abstract class SearchNewsRepository {
  Future<List<Article>> searchNews(
      String query, String language, String sortBy);
}

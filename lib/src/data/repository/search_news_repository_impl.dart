import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/data/model/headline_new.dart';
import 'package:quick_news/src/data/remote/news_api_service.dart';
import 'package:quick_news/src/data/repository/search_news_repository.dart';

final searchNewsRepositoryProvider =
    Provider((ref) => SearchNewsRepositoryImpl(ref));

class SearchNewsRepositoryImpl implements SearchNewsRepository {
  final Ref ref;

  SearchNewsRepositoryImpl(this.ref);

  @override
  Future<List<Article>> searchNews(
      String query, String language, String sortBy) {
    print("Fetching search news");
    // Appel à la méthode getNews de NewsService
    final response = ref
        .read(newsApiProvider)
        .fetchSearchNews(query: query, language: language, sortBy: sortBy);
    print("Fetched search news");
    return response;
  }
}

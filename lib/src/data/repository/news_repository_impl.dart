import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/data/model/news.dart';
import 'package:quick_news/src/data/remote/news_api_service.dart';
import 'package:quick_news/src/data/repository/news_repository.dart';

final newsRepositoryProvider = Provider((ref) => NewsRepositoryImpl(ref));

class NewsRepositoryImpl implements NewsRepository {
  final Ref ref;

  NewsRepositoryImpl(this.ref);

  @override
  Future<List<NewModel>> fetchHeadLineNews() async {
    print("Fetching top headlines");
    // Appel à la méthode getNews de NewsService
    final response = ref.read(newsApiProvider).fetchHeadLineNews(country: "us");
    print("Fetched top headlines");
    return response;
  }

  @override
  Future<List<NewModel>> fetchHeadLineNewsByCategory(
      String selectedCategory) async {
    return ref
        .read(newsApiProvider)
        .fetchNewsByCategory(country: "us", category: selectedCategory);
  }
}

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/data/model/headline_new.dart';
import 'package:quick_news/src/data/remote/news_service.dart';
import 'package:quick_news/src/data/repository/news_repository.dart';

final newsRepositoryProvider = Provider((ref) => NewsRepositoryImpl(ref));

class NewsRepositoryImpl implements NewsRepository {
  final Ref ref;

  NewsRepositoryImpl(this.ref);

  @override
  Future<List<HeadLinesNews>> fetchHeadLineNews() async {
    // Appel à la méthode getNews de NewsService
    return ref.read(newsProvider).fetchHeadLineNews(country: "us");
  }

  @override
  Future<List<HeadLinesNews>> fetchHeadLineNewsByCategory() async {
    // Appel à la méthode getNews de NewsService
    return ref.read(newsProvider).fetchNewsByCategory(country: "us");
  }
  

}

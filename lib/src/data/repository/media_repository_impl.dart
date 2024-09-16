import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/data/model/media.dart';
import 'package:quick_news/src/data/remote/news_api_service.dart';
import 'package:quick_news/src/data/repository/media_repository.dart';

final mediaRepositoryProvider = Provider((ref) => MediaRepositoryImpl(ref));

class MediaRepositoryImpl implements MediaRepository {
  final Ref ref;
  MediaRepositoryImpl(this.ref);

  @override
  Future<List<Media>> fetchMedia({
    String? country,
    String? category,
    String? language,
  }) async {
    print("Fetching top headlines");
    // Appel à la méthode getNews de NewsService
    final response = ref
        .read(newsApiProvider)
        .fetchMedia(country: country, category: category, language: language);
    print("Fetched top headlines");
    return response;
  }
}

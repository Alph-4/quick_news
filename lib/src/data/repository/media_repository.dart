import 'package:quick_news/src/data/model/media.dart';

abstract class MediaRepository {
  Future<List<Media>> fetchMedia({
    String? country,
    String? category,
    String? language,
  });
}

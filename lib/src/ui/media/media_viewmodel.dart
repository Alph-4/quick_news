import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/data/model/media.dart';
import 'package:quick_news/src/data/repository/media_repository_impl.dart';

final mediaViewModelProvider =
    ChangeNotifierProvider((ref) => MediaViewModel(ref));

final mediaProvider = FutureProvider<List<Media>>((ref) async {
  return ref.read(mediaRepositoryProvider).fetchMedia();
});

class MediaViewModel with ChangeNotifier {
  MediaViewModel(this.ref);

  final Ref ref;
  late final MediaRepositoryImpl _repository =
      ref.read(mediaRepositoryProvider);

  Future<List<Media>> fetchMedia() async {
    final stopwatch = Stopwatch()..start();
    print('fetchMedia: started');
    try {
      final mediaList = await _repository.fetchMedia();
      print('fetchMedia: completed in ${stopwatch.elapsed.inMilliseconds}ms');
      return mediaList;
    } catch (e, stackTrace) {
      print('fetchMedia: error: $e');
      print(stackTrace);
      rethrow;
    }
  }
}

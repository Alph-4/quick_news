import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/data/model/media.dart';
import 'package:quick_news/src/data/repository/media_repository_impl.dart';
import 'package:quick_news/src/fondation/constants.dart';

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

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<Media>? _mediaList;
  List<Media>? get mediaList => _mediaList;

  final _mediaBox = Hive.box<Media>(mediaBoxName);

  Future<void> fetchMedia() async {
    final stopwatch = Stopwatch()..start();
    print('fetchMedia: started');
    try {
      final mediaList = await _repository.fetchMedia();
      print('fetchMedia: completed in ${stopwatch.elapsed.inMilliseconds}ms');
      _mediaList = mediaList;
      _isLoading = false;
      notifyListeners();
    } catch (e, stackTrace) {
      print('fetchMedia: error: $e');
      print(stackTrace);
      _mediaList = _mediaBox.values.toList();
      _isLoading = false;
      notifyListeners();
      rethrow;
    }
    _isLoading = false;

    notifyListeners();
  }
}

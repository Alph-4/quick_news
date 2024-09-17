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
  final favoriteMediaBox = Hive.box<Media>(favoriteMediaBoxName);

  Future<void> fetchMedia() async {
    _isLoading = true;
    notifyListeners();

    final stopwatch = Stopwatch()..start();
    print('fetchMedia: started');
    try {
      final mediaList = await _repository.fetchMedia();
      print('fetchMedia: completed in ${stopwatch.elapsed.inMilliseconds}ms');
      _mediaList = mediaList;
    } on Exception catch (e, stackTrace) {
      print('fetchMedia: error: $e');
      print(stackTrace);
      _mediaList = _mediaBox.values.toList();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void addToFavoritesMedia(Media media) {
    print('addToFavoritesMedia: started');
    final stopwatch = Stopwatch()..start();
    try {
      favoriteMediaBox.add(media);
      print(
          'addToFavoritesMedia: completed in ${stopwatch.elapsed.inMilliseconds}ms');
    } on Exception catch (e, stackTrace) {
      print('addToFavoritesMedia: error: $e');
      print(stackTrace);
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  void removeFromFavoritesMedia(Media media) {
    print('removeFromFavoritesMedia: started');
    final stopwatch = Stopwatch()..start();
    try {
      favoriteMediaBox.delete(media);
      print(
          'removeFromFavoritesMedia: completed in ${stopwatch.elapsed.inMilliseconds}ms');
    } on Exception catch (e, stackTrace) {
      print('removeFromFavoritesMedia: error: $e');
      print(stackTrace);
      rethrow;
    } finally {
      notifyListeners();
    }
  }

  bool isFavoriteMedia(Media media) {
    print('isFavoriteMedia: started');
    final stopwatch = Stopwatch()..start();
    try {
      final result =
          favoriteMediaBox.values.any((element) => element.name == media.name);
      print(
          'isFavoriteMedia: completed in ${stopwatch.elapsed.inMilliseconds}ms');
      return result;
    } on Exception catch (e, stackTrace) {
      print('isFavoriteMedia: error: $e');
      print(stackTrace);
      rethrow;
    }
  }
}

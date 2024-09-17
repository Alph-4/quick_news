import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/data/model/media.dart';
import 'package:quick_news/src/fondation/constants.dart';
import 'package:quick_news/src/ui/media/media_viewmodel.dart';
import 'package:quick_news/src/ui/media/widget/media_card.dart';
import 'package:quick_news/src/ui/web_view/web_view.dart';

class FavoritesMediaPage extends ConsumerStatefulWidget {
  const FavoritesMediaPage({super.key});

  @override
  _FavoritesMediaPagetate createState() => _FavoritesMediaPagetate();
}

class _FavoritesMediaPagetate extends ConsumerState<FavoritesMediaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final mediaViewModel = ref.watch(mediaViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites Media'),
      ),
      body: mediaViewModel.favoriteMediaBox.isEmpty
          ? Center(child: noFavoritesMedia())
          : favoritesMediaFeed(mediaViewModel),
    );
  }

  Widget noFavoritesMedia() {
    return const Card(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(Icons.info_outline),
            SizedBox(width: 16),
            Text('You don\'t have any favorites media yet.')
          ],
        ),
      ),
    );
  }

  Widget favoritesMediaFeed(MediaViewModel mediaViewModel) {
    return ListView.builder(
      itemCount: mediaViewModel.favoriteMediaBox.values.toList().length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => WebViewPage(
                    url: mediaViewModel.favoriteMediaBox.values
                        .elementAt(index)
                        .url!),
              ),
            );
          },
          child: MediaCard(
            media: mediaViewModel.favoriteMediaBox.values.elementAt(index),
            viewModel: mediaViewModel,
          ),
        );
      },
    );
  }
}

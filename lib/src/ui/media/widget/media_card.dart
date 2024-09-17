import 'package:flutter/material.dart';
import 'package:quick_news/src/data/model/media.dart';
import 'package:quick_news/src/ui/media/media_viewmodel.dart';

class MediaCard extends StatelessWidget {
  final Media media;
  final MediaViewModel viewModel;

  const MediaCard({required this.media, required this.viewModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              media.name!,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              media.description!,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Category: ${media.category!}',
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    if (viewModel.isFavoriteMedia(media)) {
                      viewModel.removeFromFavoritesMedia(media);
                    } else {
                      viewModel.addToFavoritesMedia(media);
                    }
                  },
                  icon: viewModel.isFavoriteMedia(media)
                      ? const Icon(Icons.favorite)
                      : const Icon(Icons.favorite_border),
                  label: Text(viewModel.isFavoriteMedia(media)
                      ? "Remove from favorites"
                      : "Add to favorites"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

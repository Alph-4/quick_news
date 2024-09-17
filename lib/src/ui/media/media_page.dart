import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/ui/media/media_viewmodel.dart';
import 'package:quick_news/src/ui/web_view/web_view.dart';

class MediaPage extends ConsumerWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(mediaViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Media")),
      body: Expanded(
          child: viewModel.mediaList == null
              ? const CircularProgressIndicator()
              : mediaFeed(viewModel)),
    );
  }

  Widget mediaFeed(MediaViewModel viewModel) {
    return ListView.builder(
      itemCount: viewModel.mediaList!.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    WebViewPage(url: viewModel.mediaList![index].url!)));
          },
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    viewModel.mediaList![index].name!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    viewModel.mediaList![index].description!,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Category: ${viewModel.mediaList![index].category!}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

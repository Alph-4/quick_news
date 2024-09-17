import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/data/model/media.dart';
import 'package:quick_news/src/ui/media/media_viewmodel.dart';
import 'package:quick_news/src/ui/media/widget/media_card.dart';
import 'package:quick_news/src/ui/web_view/web_view.dart';

class MediaPage extends ConsumerStatefulWidget {
  const MediaPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<MediaPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mediaViewModelProvider).fetchMedia();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(mediaViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Media")),
      body: Center(
          child: Expanded(
              child: viewModel.mediaList == null
                  ? const CircularProgressIndicator()
                  : mediaFeed(viewModel))),
    );
  }

  /// A widget that displays a list of [Media] items.
  ///
  /// The widget uses a [ListView.builder] to display a list of [Card] widgets.
  /// Each card displays the name, description, and category of the media item.
  /// The user can tap on a card to navigate to the media item's URL in a web view.
  ///
  /// This widget takes a [MediaViewModel] as a parameter, which is used to
  /// retrieve the list of media items to display.
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
          child: MediaCard(
            media: viewModel.mediaList![index],
            viewModel: viewModel,
          ),
        );
      },
    );
  }
}

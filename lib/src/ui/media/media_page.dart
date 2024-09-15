import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/ui/news/news_viewmodel.dart';

class MediaPage extends ConsumerWidget {
  const MediaPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(newsViewModelProvider);

    final searchController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text("Media")),
      body: Expanded(
          child: FutureBuilder(
        future: viewModel.fetchHeadLineNews(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title!),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/ui/news/news_viewmodel.dart';
import 'package:quick_news/src/ui/widget/new_card.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(newsViewModelProvider).fetchHeadLineNews();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(newsViewModelProvider);

    const categories = [
      'Business',
      'Entertainment',
      'Health',
      'Science',
      'Sports',
      'technology',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('HeadLines News'),
      ),
      body: Column(
        children: [
          Container(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: List.generate(
                      categories.length,
                      (index) => ChoiceChip(
                        label: Text(categories[index]),
                        selected:
                            viewModel.selectedCategory == categories[index],
                        onSelected: (value) {
                          if (categories[index] == viewModel.selectedCategory) {
                            viewModel.updateCategory("");
                          } else {
                            viewModel.updateCategory(categories[index]);
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(),
          viewModel.headlineNews == null
              ? const CircularProgressIndicator()
              : newsFeed(viewModel),
        ],
      ),
    );
  }

  Widget newsFeed(NewsViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Expanded(
      child: RefreshIndicator(
          onRefresh: () => viewModel.selectedCategory.isEmpty
              ? viewModel.fetchHeadLineNews()
              : viewModel
                  .fetchHeadLineNewsByCategory(viewModel.selectedCategory),
          child: ListView.builder(
            itemCount: viewModel.headlineNews?.length ?? 0,
            itemBuilder: (context, index) => NewCard(
              newItem: viewModel.headlineNews![index],
            ),
          )),
    );
  }
}

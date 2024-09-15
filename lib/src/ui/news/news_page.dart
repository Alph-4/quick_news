import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/ui/news/news_viewmodel.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(newsViewModelProvider);
    final searchController = TextEditingController();
    String _selectedCategory = "";

    const categories = [
      'Business',
      'Technology',
      'Entertainment',
      'Health',
      'Science',
      'Sports',
      'Politics',
      'Finance',
      'World',
      'Travel',
      'Food',
      'Fashion',
      'Gaming',
      'Music',
      'Movies',
      'Lifestyle',
      'Automotive',
      'Environment',
      'Startups',
      'Education',
    ];
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Search news',
          ),
        ),
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
                        selected: _selectedCategory == categories[index],
                        onSelected: (value) {
                          setState(() {
                            _selectedCategory = categories[index];
                            viewModel
                                .fetchHeadLineNewsByCategory(_selectedCategory);
                          });
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Divider(),
          Expanded(
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
          ))
        ],
      ),
    );
  }
}

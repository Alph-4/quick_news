import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/ui/detail/article_detail_page.dart';
import 'package:quick_news/src/ui/news/news_viewmodel.dart';

class NewsPage extends ConsumerStatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends ConsumerState<NewsPage> {
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();

    searchController = TextEditingController();

    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(newsViewModelProvider);

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
        title: AppBar(
          title: const Text('HeadLines News'),
        ),
      ),
      body: Column(
        children: [
          searchBar(),
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
          Expanded(
              child: ref.watch(headlineNewsProvider).when(
                    data: (news) => ListView.builder(
                      itemCount: news.length,
                      itemBuilder: (context, index) {
                        final newsItem = news[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    ArticleDetailPage(article: newsItem)));
                          },
                          child: Card(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  newsItem.title,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  newsItem.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Author: ${newsItem.author}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  'Published at: ${newsItem.publishedAt}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    loading: () => CircularProgressIndicator(),
                    error: (err, stack) => Text('Error: $err'),
                  ))
        ],
      ),
    );
  }

  Widget searchBar() {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          //Do something wi
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
            color: Color(0xff4338CA),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: "Search headlines news",
          hintStyle: TextStyle(color: Colors.grey),
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 1.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 2.0),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          ),
        ),
      ),
    );
  }
}

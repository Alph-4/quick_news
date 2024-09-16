import 'package:animated_icon/animated_icon.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:quick_news/src/ui/news/news_viewmodel.dart';
import 'package:quick_news/src/ui/search/search_viewmodel.dart';
import 'package:quick_news/src/ui/widget/new_card.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  late final TextEditingController searchController;
  String languageCode = "us";
  String countryCode = "us";

  @override
  void initState() {
    super.initState();
    final locale = WidgetsBinding.instance.window.locale;
    languageCode = locale.languageCode;
    countryCode = locale.countryCode!.toString();
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
    final viewModel = ref.watch(searchNewsViewModelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search  News'),
      ),
      body: SafeArea(
        child: Center(
            child: Column(
          children: [
            searchBar(viewModel),
            viewModel.searchNews == null
                ? makeSearchView()
                : newsFeed(viewModel),
          ],
        )),
      ),
    );
  }

  Widget makeSearchView() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimateIcon(
                onTap: () {},
                color: Theme.of(context).colorScheme.primary,
                height: 100,
                width: 100,
                iconType: IconType.continueAnimation,
                animateIcon: AnimateIcons.loading2),
            const SizedBox(height: 20),
            Text(
              'No Search',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(
              'make search to get news',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget newsFeed(SearchNewsViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return Expanded(
      child: ListView.builder(
        itemCount: viewModel.searchNews!.length,
        itemBuilder: (context, index) {
          final newsItem = viewModel.searchNews![index];
          return NewCard(newItem: newsItem);
        },
      ),
    );
  }

  Widget searchBar(SearchNewsViewModel viewModel) {
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
        onChanged: (value) {},
        onSubmitted: (value) {
          debugPrint(value.toString());
          viewModel.updateQuery(value, languageCode);
        },
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.search,
          ),
          filled: true,
          hintText: "Search headlines news",
          contentPadding:
              EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
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

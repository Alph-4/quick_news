import 'package:flutter/material.dart';
import 'package:quick_news/src/data/model/headline_new.dart';
import 'package:quick_news/src/ui/detail/article_detail_page.dart';

class NewCard extends StatefulWidget {
  final Article newItem;

  const NewCard({super.key, required this.newItem});

  @override
  State<NewCard> createState() => _NewCardState();
}

class _NewCardState extends State<NewCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ArticleDetailPage(article: widget.newItem)));
      },
      child: Card(
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                widget.newItem.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.newItem.description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Text(
                'Published at: ${widget.newItem.publishedAt}',
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                    'Author: ${widget.newItem.author}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  )),
                  Spacer(),
                  Expanded(
                      child: Text(
                    '${widget.newItem.source.name}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

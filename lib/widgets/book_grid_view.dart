import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/utils/book_deailts_arguments.dart';

class BooksGridView extends StatelessWidget {
  const BooksGridView({
    super.key,
    required List<Book> books,
    required this.theme,
  }) : _books = books;

  final List<Book> _books;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
      itemCount: _books.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) {
        Book book = _books[index];

        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'details',
                arguments: BookDetailsArguments(
                  isFromHomeScreen: true,
                  itemBook: book,
                ));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceVariant,
                  borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: book.imageLinks.isEmpty
                          ? const Text('')
                          :
                          // Image.network(
                          //   book.imageLinks['thumbnail'] ?? '',
                          //   scale: 1.2,
                          // ),
                          CachedNetworkImage(
                              imageUrl: book.imageLinks['thumbnail'] ?? '',                            
                              imageBuilder: (context, imageProvider) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                              key: Key(book.id.toString()),
                              progressIndicatorBuilder:
                                  (context, url, progress) => Center(
                                child: CircularProgressIndicator(
                                  value: progress.progress,
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                   const Icon(Icons.error),
                            ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      book.title,
                      style: theme.textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      book.authors.join(", "),
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    ));
  }
}

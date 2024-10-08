import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/providers/major_provider.dart';
import 'package:reader_tracker/utils/book_deailts_arguments.dart';

class BookDetailsScreen extends StatefulWidget {
  const BookDetailsScreen({super.key});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final Book book = args.itemBook;
    var theme = Theme.of(context);
    double margin =
        double.parse(MediaQuery.of(context).size.width.toString()) * 0.2;
    var provider = Provider.of<MajorProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              book.imageLinks.isEmpty
                  ? const Text('')
                  : Image.network(
                      book.imageLinks['thumbnail'] ?? '',
                      fit: BoxFit.cover,
                    ),
              const SizedBox(
                height: 5,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: margin,
                  right: margin,
                ),
                child: Text(
                  book.title,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: margin,
                  right: margin,
                ),
                child: Text(
                  book.authors.join(
                    ', ',
                  ),
                  style: theme.textTheme.titleMedium,
                ),
              ),
              Text("Published: ${book.publishedDate}"),
              Text("Page count: ${book.pageCount}"),
              Text("Language: ${book.language}"),
              Container(
                margin: const EdgeInsets.only(top: 10, bottom: 10),
                child: args.isFromHomeScreen
                    ? ElevatedButton(
                        onPressed: () async {
                          await provider.saveBook(book, context);
                        },
                        child: const Text("Save"))
                    : ElevatedButton.icon(
                        onPressed: () async {
                          args.itemBook.isFavorite =
                              args.itemBook.isFavorite ? false : true;
                          await provider.toggleFavorite(
                              book.id, !book.isFavorite, context);
                        },
                        icon: Icon(book.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_outline),
                        label: Text(book.isFavorite
                            ? "Remove from favorites."
                            : "Add to favorites."),
                      ),
              ),
              if (book.description.isNotEmpty)
                Column(
                  children: [
                    Text("Description", style: theme.textTheme.titleMedium),
                    Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary.withOpacity(0.1),
                          border:
                              Border.all(color: theme.colorScheme.secondary),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(book.description)),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}

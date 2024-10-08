import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/providers/major_provider.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MajorProvider>(context);
    var theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: DataBaseHelper.instance.getFavorites(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                List<Book> favBooks = snapshot.data!;
                return ListView.builder(
                  itemCount: favBooks.length,
                  itemBuilder: (context, index) {
                    Book book = favBooks[index];

                    return Card(
                        child: ListTile(
                      leading: book.imageLinks.isEmpty
                          ? const Text('')
                          : Image.network(
                              book.imageLinks['thumbnail'] ?? '',
                              fit: BoxFit.cover,
                            ),
                      title: AutoSizeText(
                        book.title,
                        maxLines: 2,
                        minFontSize: 16.0,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: AutoSizeText(
                        book.authors.join(
                          ', ',
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: IconButton(
                          onPressed: () async {
                            provider.toggleFavorite(
                                book.id, book.isFavorite, context);
                          },
                          icon: book.isFavorite
                              ? Icon(
                                  Icons.favorite,
                                  color: theme.colorScheme.primary,
                                )
                              : Icon(
                                  Icons.favorite_outline,
                                  color: theme.colorScheme.primary,
                                )),
                    ));
                  },
                );
              } else {
                return const Center(
                  child: Text("No favorites books found."),
                );
              }
            }),
      ),
    );
  }
}

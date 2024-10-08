import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/providers/major_provider.dart';
import 'package:reader_tracker/utils/book_deailts_arguments.dart';

class SavedScreen extends StatefulWidget {
  const SavedScreen({super.key});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MajorProvider>(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: DataBaseHelper.instance.readAllBooks(),
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
                List<Book> savedBooks = snapshot.data!;
                return ListView.builder(
                  itemCount: savedBooks.length,
                  itemBuilder: (context, index) {
                    Book book = savedBooks[index];

                    return InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, 'details',
                            arguments: BookDetailsArguments(
                                isFromHomeScreen: false, itemBook: book));
                      },
                      child: Card(
                          child: ListTile(
                        leading: book.imageLinks.isEmpty
                            ? const Text('')
                            :
                            Image.network(
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
                        subtitle: Column(
                          children: [
                            AutoSizeText(
                              book.authors.join(
                                ', ',
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton.icon(
                              onPressed: () async {
                                await provider.toggleFavorite(
                                    book.id, book.isFavorite, context);
                              },
                              icon: Icon(book.isFavorite
                                  ? Icons.favorite
                                  : Icons.favorite_outline),
                              label: Text(book.isFavorite
                                  ? "Remove from favorites."
                                  : "Add to favorites."),
                            ),
                          ],
                        ),
                        trailing: IconButton(
                            onPressed: () async {
                              provider.deleteBook(book.id, context);
                            },
                            icon: const Icon(Icons.delete)),
                      )),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text("No saved books found."),
                );
              }
            }),
      ),
    );
  }
}

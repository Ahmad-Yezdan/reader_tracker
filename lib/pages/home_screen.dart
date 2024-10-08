import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reader_tracker/providers/home_provider.dart';
import 'package:reader_tracker/widgets/book_grid_view.dart';
import 'package:reader_tracker/widgets/search_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var homeProvider = Provider.of<HomeProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchField(homeProvider: homeProvider),
            ),
            BooksGridView(books: homeProvider.books, theme: theme)
          ],
        ),
      ),
    );
  }
}

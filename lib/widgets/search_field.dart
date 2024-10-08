import 'package:flutter/material.dart';
import 'package:reader_tracker/providers/home_provider.dart';

class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
    required this.homeProvider,
  });

  final HomeProvider homeProvider;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: "Search for a book",
        suffixIcon: Icon(Icons.search),
        // labelText: "Search",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      onSubmitted: (query) {
        homeProvider.searchBooks(query);
      },
    );
  }
}

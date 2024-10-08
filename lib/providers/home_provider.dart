import 'package:flutter/material.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/network/network.dart';

class HomeProvider with ChangeNotifier {
  Network network = Network();
  List<Book> _books = [];

  Future<void> searchBooks(String query) async {
    try {
      List<Book> books = await network.searchBooks(query);
      // print("Books: ${books.toString()}");
      _books = books;
      notifyListeners();
    } catch (e) {
      print("Didn't get anything...");
    }
    notifyListeners();
  }

  List<Book> get books => _books;
}

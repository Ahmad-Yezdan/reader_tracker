import 'package:flutter/material.dart';
import 'package:reader_tracker/db/database_helper.dart';
import 'package:reader_tracker/models/book.dart';
import 'package:reader_tracker/pages/favorites_screen.dart';
import 'package:reader_tracker/pages/home_screen.dart';
import 'package:reader_tracker/pages/saved_screen.dart';

class MajorProvider with ChangeNotifier {
  late int _currentIndex;

  MajorProvider() {
    _currentIndex = 0;
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const SavedScreen(),
    const FavoritesScreen(),
  ];

  int get currentIndex => _currentIndex;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Widget loadScreen() {
    return _screens[_currentIndex];
  }

  //insert book to database
  Future<void> saveBook(Book book, BuildContext context) async {
    try {
      await DataBaseHelper.instance.insert(book);
      showSnackBar(context: context, message: "Book Saved.");
    } catch (e) {
      print("Error: $e");
      if (e.toString().contains("UNIQUE constraint failed: books.id")) {
        showSnackBar(context: context, message: "Already in saved.");
      }
    }
  }

  //updating(toggling) favorite flag in Database, Books table
  Future<void> toggleFavorite(
      String id, bool isFavorite, BuildContext context) async {
    try {
      await DataBaseHelper.instance.toggleFavoriteStatus(id, isFavorite);
      showSnackBar(
          context: context,
          message: isFavorite
              ? "Book Removed from favorties."
              : "Book added in favorties.");
      notifyListeners();
    } catch (e) {
      print("Error: $e");
    }
  }

  //deleting book in database
  Future<void> deleteBook(String id, BuildContext context) async {
    try {
      await DataBaseHelper.instance.deleteBook(id);
      showSnackBar(context: context, message: "Book Deleted.");
      notifyListeners();
    } catch (e) {
      print("Error: $e");
    }
  }
}

void showSnackBar({required BuildContext context, required String message}) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
    duration: const Duration(milliseconds: 400),
    margin: const EdgeInsets.all(30),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

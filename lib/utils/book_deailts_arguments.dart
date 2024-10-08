import 'package:reader_tracker/models/book.dart';

class BookDetailsArguments {
  final Book itemBook;
  final bool isFromHomeScreen;

  BookDetailsArguments({required this.isFromHomeScreen, required this.itemBook});
}

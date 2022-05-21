import 'package:get/get.dart';
import 'package:librex/handlers/search_handler.dart';
import 'package:librex/models/book_model.dart';

class SearchController extends GetxController {
  final bookList = <BookModel>[].obs;
  final tagBookList = <BookModel>[].obs;

  void search(String query) {
    bookList.bindStream(SearchHandler.instance.searchBooks(query));
  }

  void searchByTag(String query) {
    tagBookList.bindStream(SearchHandler.instance.searchTags(query));
  }
}

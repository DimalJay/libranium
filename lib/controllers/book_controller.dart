import 'package:get/get.dart';
import 'package:librex/handlers/book_handler.dart';
import 'package:librex/models/book_model.dart';

class BookController extends GetxController {
  final bookLatestList = <BookModel>[].obs;
  final bookFeedList = <BookModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    bookLatestList
        .bindStream(BookHandler.instance.getBookCollectionOrderByLatest());
    bookFeedList.bindStream(BookHandler.instance.getBookCollection());
    bookFeedList.shuffle();
  }

  void feedRandomize() {
    bookFeedList.shuffle();
  }
}

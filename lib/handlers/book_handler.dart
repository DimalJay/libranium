import 'package:librex/handlers/content_handler.dart';

import 'package:librex/models/book_model.dart';
import 'package:librex/services/databse_service.dart';

class BookHandler extends FireDatabasehanlder {
  static BookHandler instance = BookHandler._init();
  BookHandler._init() : super(collection: FireDatabaseFeilds.books);

  // Create Book
  Future<BookModel> createBook(BookModel book) async {
    BookModel _book = book.copyWith(
        content: await ContentHanlder.instance.createContent(book.content));
    return await dbcreate(json: _book.toJson())
        .then((value) async => BookModel.fromDocumentSnapshot(await value));
  }

  // Update Book
  Future<bool> updateBook(BookModel book) async {
    return await dbupdate(id: book.id, json: book.toJson());
  }

  // Read Book
  Future<BookModel> getBook(String id) async {
    return BookModel.fromDocumentSnapshot(await dbreadDoc(id: id));
  }

  // Read Book Collection
  Stream<List<BookModel>> getBookCollection() {
    return dbreadCollection().map((snapshot) {
      List<BookModel> retVal = [];
      for (var book in snapshot.docs) {
        retVal.add(BookModel.fromDocumentSnapshot(book));
      }

      return retVal;
    });
  }

  // Read Book Collection
  Stream<List<BookModel>> getBookCollectionOrderByLatest() {
    return dbreadCollectionOrderBy(BookModelFeild.dateNtime).map((snapshot) {
      List<BookModel> retVal = [];
      for (var book in snapshot.docs) {
        retVal.add(BookModel.fromDocumentSnapshot(book));
      }
      return retVal.reversed.toList();
    });
  }

  // Delete Book
  Future<bool> delete(String id) async {
    return await dbdelete(id: id);
  }
}

import 'package:librex/models/book_model.dart';
import 'package:librex/services/databse_service.dart';

class TagHandler extends FireDatabasehanlder {
  static TagHandler instance = TagHandler._init();
  TagHandler._init() : super(collection: FireDatabaseFeilds.books);

// Read Book Collection
  Stream<List<String>> getTagList() {
    return dbreadCollection().map((snapshot) {
      List<String> retVal = [];
      for (var book in snapshot.docs) {
        retVal.addAll(BookModel.fromDocumentSnapshot(book).tags);
      }

      return retVal;
    });
  }
}

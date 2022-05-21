import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librex/models/book_model.dart';
import 'package:librex/services/databse_service.dart';

class SearchHandler extends FireDatabasehanlder {
  static SearchHandler instance = SearchHandler._init();
  SearchHandler._init() : super(collection: FireDatabaseFeilds.books);

  Stream<List<BookModel>> searchBooks(String query) {
    return dbreadCollection().map((QuerySnapshot querySnapshot) {
      List<BookModel> retVal = [];
      for (var element in querySnapshot.docs) {
        BookModel _book = BookModel.fromDocumentSnapshot(element);

        if (searchBookContent(book: _book, queryText: query.toLowerCase())) {
          retVal.add(_book);
        }
      }
      return retVal;
    });
  }

  Stream<List<BookModel>> searchTags(String query) {
    return dbreadCollection().map((QuerySnapshot querySnapshot) {
      List<BookModel> retVal = [];
      for (var element in querySnapshot.docs) {
        BookModel _book = BookModel.fromDocumentSnapshot(element);

        if (searchBooksbyTag(book: _book, queryText: query.toLowerCase())) {
          retVal.add(_book);
        }
      }
      return retVal;
    });
  }
}

bool searchBookContent({required BookModel book, required String queryText}) {
  bool retVal = false;
  bool hasTag = false;
  queryText.split(" ").forEach((query) {
    bool hasTitle = book.title.toLowerCase().contains(query.toLowerCase());
    bool hasDescription =
        book.description.toLowerCase().contains(query.toLowerCase());
    for (var tag in book.tags) {
      hasTag = tag.toLowerCase().contains(query.toLowerCase());
    }

    if (hasTitle || hasDescription || hasTag) {
      retVal = true;
    }
  });

  return retVal;
}

bool searchBooksbyTag({required BookModel book, required String queryText}) {
  bool retVal = false;
  queryText.split(" ").forEach((query) {
    for (var element in book.tags) {
      if (element.toLowerCase().contains(queryText.toLowerCase())) {
        retVal = true;
      }
    }
  });
  return retVal;
}

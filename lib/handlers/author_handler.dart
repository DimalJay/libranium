import 'package:librex/services/databse_service.dart';
import '../models/author_model.dart';

class AuthorHanlder extends FireDatabasehanlder {
  static AuthorHanlder instance = AuthorHanlder._init();
  AuthorHanlder._init() : super(collection: FireDatabaseFeilds.authors);

  // Create Book
  Future<AuthorModel> createAuthor(AuthorModel author) async {
    return await dbcreate(json: author.toJson())
        .then((value) async => AuthorModel.fromDocumentSnapshot(await value));
  }

  // Update Book
  Future<bool> updateAuthor(AuthorModel author) async {
    return await dbupdate(id: author.id!, json: author.toJson());
  }

  // Read Book
  Future<AuthorModel> getAuthor(String id) async {
    return AuthorModel.fromDocumentSnapshot(await dbreadDoc(id: id));
  }

  // Read Book Collection
  Stream<List<AuthorModel>> getAuthorCollection() {
    return dbreadCollection().map((snapshot) {
      List<AuthorModel> retVal = [];
      for (var author in snapshot.docs) {
        retVal.add(AuthorModel.fromDocumentSnapshot(author));
      }

      return retVal;
    });
  }

  // Read Book Collection
  Stream<List<AuthorModel>> getAuthorCollectionByFilter(
      {required String feild, required String value}) {
    return dbreadCollectionByFilter(field: feild, isEqualTo: value)
        .map((snapshot) {
      List<AuthorModel> retVal = [];
      for (var author in snapshot.docs) {
        retVal.add(AuthorModel.fromDocumentSnapshot(author));
      }

      return retVal;
    });
  }

  // Delete Book
  Future<bool> deleteAuthor(String id) async {
    return await dbdelete(id: id);
  }
}

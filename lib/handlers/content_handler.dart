import 'package:librex/models/content_model.dart';
import 'package:librex/services/databse_service.dart';

class ContentHanlder extends FireDatabasehanlder {
  static ContentHanlder instance = ContentHanlder._init();
  ContentHanlder._init() : super(collection: FireDatabaseFeilds.contents);

  // Create Content
  Future<ContentModel> createContent(ContentModel content) async {
    return await dbcreate(json: content.toJson()).then((doc) async {
      ContentModel _content = ContentModel.fromDocumentSnapshot(await doc);
      return content.copyWith(id: _content.id);
    });
  }

  // Update Content
  Future<bool> updateContent(ContentModel content) async {
    return await dbupdate(id: content.id!, json: content.toJson());
  }

  // Read Content
  Future<ContentModel> getContent(String id) async {
    return ContentModel.fromDocumentSnapshot(await dbreadDoc(id: id));
  }

  // Read Content Collection
  Stream<List<ContentModel>> getContentCollection() {
    return dbreadCollection().map((snapshot) {
      List<ContentModel> retVal = [];
      for (var content in snapshot.docs) {
        retVal.add(ContentModel.fromDocumentSnapshot(content));
      }

      return retVal;
    });
  }

  // Delete Content
  Future<bool> deleteContent(String id) async {
    return await dbdelete(id: id);
  }
}

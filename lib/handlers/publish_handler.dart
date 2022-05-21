import 'package:librex/models/publisher_model.dart';
import 'package:librex/services/databse_service.dart';

class PublisherHandler extends FireDatabasehanlder {
  static PublisherHandler instance = PublisherHandler._init();
  PublisherHandler._init() : super(collection: FireDatabaseFeilds.publishers);

  Future<PublisherModel> createPublisher(PublisherModel publisher) {
    return dbcreate(json: publisher.toJson()).then(
        (value) async => PublisherModel.fromDocumentSnapshots(await value));
  }

  Future<PublisherModel> getPublisher({required String id}) {
    return dbreadDoc(id: id)
        .then((value) => PublisherModel.fromDocumentSnapshots(value));
  }
}

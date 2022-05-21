import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:librex/constraints.dart';
import 'package:librex/handlers/publish_handler.dart';

class PublisherModelFeild {
  static const String name = "_name";
  static const String cover = "_cover";
}

class PublisherModel {
  final String? id;
  final String name;
  final String cover;

  const PublisherModel({
    this.id,
    required this.name,
    required this.cover,
  });

  static PublisherModel fromDocumentSnapshots(DocumentSnapshot doc) =>
      PublisherModel(
        id: doc.id,
        name: doc[PublisherModelFeild.name],
        cover: doc[PublisherModelFeild.cover],
      );
  Map<String, dynamic> toJson() => {
        PublisherModelFeild.name: name,
        PublisherModelFeild.cover: cover,
      };

  PublisherModel copyWith(String? name, String? cover) => PublisherModel(
        id: id,
        name: name ?? this.name,
        cover: cover ?? this.cover,
      );

  Future<PublisherModel> createPublisher() =>
      PublisherHandler.instance.createPublisher(this);

  static Future<PublisherModel> getPublisher() =>
      PublisherHandler.instance.getPublisher(id: Constants.pubID.trim());
}

import 'package:cloud_firestore/cloud_firestore.dart';

import '../handlers/content_handler.dart';

class ContentModelFeild {
  static const String content = "_content";
}

class ContentModel {
  final String? id;
  final String content;

  ContentModel({
    this.id,
    required this.content,
  });

  static ContentModel fromDocumentSnapshot(DocumentSnapshot doc) {
    return ContentModel(
      id: doc.id,
      content: doc[ContentModelFeild.content],
    );
  }

  Map<String, dynamic> toJson() => {
        ContentModelFeild.content: content,
      };

  ContentModel copyWith({String? id, String? content}) => ContentModel(
        id: id ?? this.id,
        content: content ?? this.content,
      );

  static ContentModel fromBookSnapshotid(String id) {
    return ContentModel(content: "", id: id);
  }

  // Database Oprations
  // Extend with Content Handler

  // @ Create Content
  Future<ContentModel> createContent() =>
      ContentHanlder.instance.createContent(this);

  // // @ Update Content
  // Future<bool> updateContent() => ContentHanlder.instance.updateContent(this);

  // // @ get Content by id
  // static Future<ContentModel> getContentById({required String id}) =>
  //     ContentHanlder.instance.getContent(id);

  // // @ Get All Content list
  // static Stream<List<ContentModel>> getAllContents() =>
  //     ContentHanlder.instance.getContentCollection();

  // // @ Delete Content
  // Future<bool> deleteContent() =>
  //     ContentHanlder.instance.delete(id).then((value) => value);
}
